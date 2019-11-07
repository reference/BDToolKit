//
//  NSData+Encryption.m
//  HaoMai
//
//  Created by B-A-N on 2019/11/7.
//  Copyright © 2019 Haomai. All rights reserved.
//

#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonCrypto.h>
#import <Security/Security.h>

static const int AES_256_IV_SIZE = 16;


@interface NSString (Private)

- (SecKeyRef)getKeyRef;

@end

@interface NSData (Private)

- (NSData *)stripPublicKeyHeader;

@end

@implementation NSData(Encryption)

- (NSData *)randomDataWithLength:(NSUInteger)length {
    NSMutableData* data = [NSMutableData dataWithLength:length];
    int err = SecRandomCopyBytes(kSecRandomDefault, length, [data mutableBytes]);
    if (err)
        return nil;
    else
        return data;
}

- (NSString *)md5String {
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5([self bytes], (uint32_t)[self length], md5Buffer);
    
    // Convert unsigned char buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (NSData *)AES256EncryptWithKey:(NSString *)key {
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    NSMutableData *data = [[self randomDataWithLength:AES_256_IV_SIZE] mutableCopy];  //IV
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key cStringUsingEncoding:NSUTF8StringEncoding],
                                          [key length],
                                          [data bytes],
                                          [self bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    
    
    if (cryptStatus == kCCSuccess) {
        NSData *message = [NSData dataWithBytes:buffer
                                         length:numBytesEncrypted]; //Message
        /* Do HMac */
        NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
        NSData *hmac = [message doHmacWithKeyData:keyData];

        /* IV+Message+HMac */
        [data appendData:message];
        [data appendData:hmac];

        free(buffer);
        return data;
    }
    free(buffer);
    return nil;
}

- (NSData *)doHmacWithKeyData:(NSData *)salt {
    NSMutableData *macOut = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256,
           salt.bytes,
           salt.length,
           self.bytes,
           self.length,
           macOut.mutableBytes);
    
    return macOut;
}

- (NSData *)AES256DecryptWithKey:(NSString *)key {
    
    /* Server MAC */
    unsigned char hmacSvrBuffer[CC_SHA256_DIGEST_LENGTH];
    unsigned long hmacStartLoc = [self length]-CC_SHA256_DIGEST_LENGTH;
    [self getBytes:hmacSvrBuffer
             range:NSMakeRange(hmacStartLoc, CC_SHA256_DIGEST_LENGTH)];
    NSData *hmacSvr = [NSData dataWithBytes:hmacSvrBuffer
                                     length:CC_SHA256_DIGEST_LENGTH];
    
    /* Client MAC */
    NSData *messageData = [self subdataWithRange:NSMakeRange(AES_256_IV_SIZE, [self length]-CC_SHA256_DIGEST_LENGTH-AES_256_IV_SIZE)];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *hmacApp = [messageData doHmacWithKeyData:keyData];
    if (![hmacApp isEqualToData:hmacSvr]) {
        NSLog(@"Authentication Code From Svr[%@] != Calc by Client[%@]", hmacSvr, hmacApp);
        return nil;
    }
    
    unsigned char iv[AES_256_IV_SIZE] = {0};
    memcpy(iv, [self bytes], sizeof(iv));
    
    NSUInteger dataLength = [self length]-AES_256_IV_SIZE-CC_SHA256_DIGEST_LENGTH;
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          [key cStringUsingEncoding:NSUTF8StringEncoding],
                                          [key length],
                                          iv,
                                          [self bytes]+AES_256_IV_SIZE,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer
                                    length:numBytesDecrypted];
    }
    free(buffer);
    return nil;
}

//rsa
- (NSData *)RSAEncryptWithPublicKey:(NSString *)pubKey {
    if (self == nil || pubKey == nil) {
        return nil;
    }
    SecKeyRef keyRef = [pubKey getKeyRef];
    if(!keyRef) {
        return nil;
    }
    
    const uint8_t *srcbuf = (const uint8_t *)[self bytes];
    size_t srclen = (size_t)[self length];
    
    size_t outlen = SecKeyGetBlockSize(keyRef) * sizeof(uint8_t);
    if(srclen > outlen - 11) { //PKCS1 padding
        CFRelease(keyRef);
        return nil;
    }
    void *outbuf = malloc(outlen);
    
    OSStatus status = noErr;
    status = SecKeyEncrypt(keyRef,
                           kSecPaddingOAEP,
                           srcbuf,
                           srclen,
                           outbuf,
                           &outlen
                           );
    NSData *ret = nil;
    if (status != errSecSuccess) {
        NSLog(@"SecKeyEncrypt fail. Error Code: %d", (int)status);
    } else {
        ret = [NSData dataWithBytes:outbuf length:outlen];
    }
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

- (NSData *)stripPublicKeyHeader {
    // Skip ASN.1 public key header
    if (self == nil || [self length] <= 0)
        return nil;
    
    unsigned char *c_key = (unsigned char *)[self bytes];
    unsigned int  idx    = 0;
    
    if (c_key[idx++] != 0x30)
        return nil;
    
    if (c_key[idx] > 0x80)
        idx += c_key[idx] - 0x80 + 1;
    else
        idx++;
    
    // PKCS #1 rsaEncryption szOID_RSA_RSA
    static unsigned char seqiod[] =
    { 0x30,   0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01,
        0x01, 0x05, 0x00 };
    
    if (memcmp(&c_key[idx], seqiod, 15))
        return nil;
    
    idx += 15;
    
    if (c_key[idx++] != 0x03)
        return nil;
    
    if (c_key[idx] > 0x80)
        idx += c_key[idx] - 0x80 + 1;
    else
        idx++;
    
    if (c_key[idx++] != '\0')
        return nil;
    
    // Now make a new NSData from this buffer
    return [NSData dataWithBytes:&c_key[idx] length:[self length] - idx];
}

@end

@implementation NSString (RSA)

//rsa
- (NSString *)RSAEncryptWithPublicKey:(NSString *)pubKey {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *entryData = [data RSAEncryptWithPublicKey:pubKey];
    return [entryData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (SecKeyRef)getKeyRef {
    // Remove all fuck characters.
    NSString *string = [self copy];
    NSRange spos = [string rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [string rangeOfString:@"-----END PUBLIC KEY-----"];
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        string = [string substringWithRange:range];
    }
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    // This will be base64 encoded, decode it.
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [data stripPublicKeyHeader];
    if(!data){
        return nil;
    }
    
    NSString *tag = @"what_the_fuck_is_this";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    // Delete any old lingering key with the same tag
    NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    // Add persistent version of the key to system keychain
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)
     kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)
     kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil){
        CFRelease(persistKey);
    }
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }
    
    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    // Now fetch the SecKeyRef version of the key
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
    if(status != noErr){
        return nil;
    }
    return keyRef;
}

@end
