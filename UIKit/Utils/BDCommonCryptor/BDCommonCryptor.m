/**
 MIT License
 
 Copyright (c) 2018 Scott Ban (https://github.com/reference/BDToolKit)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
#import "BDCommonCryptor.h"

@implementation NSData (BDCommonCryptor)

// Reference https://github.com/Gurpartap/AESCrypt-ObjC/blob/master/NSData+CommonCrypto.m
static void FixKeyLengths(CCAlgorithm algorithm, NSMutableData *keyData, NSMutableData *ivData) {
    NSUInteger keyLength = [keyData length];
    switch (algorithm) {
        case kCCAlgorithmAES128:
        {
            if (keyLength < 16) {
                [keyData setLength:16];
            } else if (keyLength < 24) {
                [keyData setLength:24];
            } else {
                [keyData setLength:32];
            }
            break;
        }
            
        case kCCAlgorithmDES:
        {
            [keyData setLength:8];
            break;
        }
            
        case kCCAlgorithm3DES:
        {
            [keyData setLength:24];
            break;
        }
            
        case kCCAlgorithmCAST:
        {
            if (keyLength < 5) {
                [keyData setLength:5];
            } else if (keyLength > 16) {
                [keyData setLength:16];
            }
            break;
        }
            
        case kCCAlgorithmRC4:
        {
            if (keyLength > 512) {
                [keyData setLength:512];
            }
            break;
        }
            
        default:
            break;
    }
    
    [ivData setLength:[keyData length]];
}

- (NSData *)_runCryptor:(CCCryptorRef)cryptor result:(CCCryptorStatus *)status {
    size_t bufsize = CCCryptorGetOutputLength(cryptor, (size_t)[self length], true);
    void *buf = malloc(bufsize);
    size_t bufused = 0;
    size_t bytesTotal = 0;
    *status = CCCryptorUpdate(cryptor, [self bytes], (size_t)[self length], buf, bufsize, &bufused);
    if (*status != kCCSuccess) {
        free(buf);
        return (nil);
    }
    
    bytesTotal += bufused;
    
    // From Brent Royal-Gordon (Twitter:architechies):
    //  Need to update buf ptr past used bytes when calling CCCryptorFinal()
    *status = CCCryptorFinal(cryptor, buf + bufused, bufsize - bufused, &bufused);
    if (*status != kCCSuccess) {
        free(buf);
        return (nil);
    }
    
    bytesTotal += bufused;
    
    return ([NSData dataWithBytesNoCopy:buf length:bytesTotal]);
}

- (NSData *)encryptUsingAlgorithm:(CCAlgorithm)algorithm
                              key:(id)key
             initializationVector:(id)iv
                          options:(CCOptions)options
                            error:(CCCryptorStatus *)error
{
    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    NSParameterAssert([key isKindOfClass:[NSData class]] || [key isKindOfClass:[NSString class]]);
    NSParameterAssert(iv == nil || [iv isKindOfClass:[NSData class]] || [iv isKindOfClass:[NSString class]]);
    
    NSMutableData *keyData, *ivData;
    if ([key isKindOfClass:[NSData class]]) {
        keyData = (NSMutableData *)[key mutableCopy];
    } else {
        keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    }
    
    if ([iv isKindOfClass:[NSString class]]) {
        ivData = [[iv dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    } else {
        ivData = (NSMutableData *)[iv mutableCopy];    // data or nil
    }
    
#if !__has_feature(objc_arc)
    [keyData autorelease];
    [ivData autorelease];
#endif
    // ensure correct lengths for key and iv data, based on algorithms
    FixKeyLengths(algorithm, keyData, ivData);
    
    status = CCCryptorCreate(kCCEncrypt, algorithm, options,
                             [keyData bytes], [keyData length], [ivData bytes],
                             &cryptor);
    
    if (status != kCCSuccess) {
        if (error != NULL) {
            *error = status;
        }
        return (nil);
    }
    
    NSData *result = [self _runCryptor:cryptor result:&status];
    if ((result == nil)&& (error != NULL)) {
        *error = status;
    }
    
    CCCryptorRelease(cryptor);
    
    return (result);
}

- (NSData *)decryptUsingAlgorithm:(CCAlgorithm)algorithm
                              key:(id)key // data or string
             initializationVector:(id)iv // data or string
                          options:(CCOptions)options
                            error:(CCCryptorStatus *)error {
    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    NSParameterAssert([key isKindOfClass:[NSData class]] || [key isKindOfClass:[NSString class]]);
    NSParameterAssert(iv == nil || [iv isKindOfClass:[NSData class]] || [iv isKindOfClass:[NSString class]]);
    
    NSMutableData *keyData, *ivData;
    if ([key isKindOfClass:[NSData class]]) {
        keyData = (NSMutableData *)[key mutableCopy];
    } else {
        keyData = [[key dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    }
    
    if ([iv isKindOfClass:[NSString class]]) {
        ivData = [[iv dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    } else {
        ivData = (NSMutableData *)[iv mutableCopy];    // data or nil
    }
    
#if !__has_feature(objc_arc)
    [keyData autorelease];
    [ivData autorelease];
#endif
    
    // ensure correct lengths for key and iv data, based on algorithms
    FixKeyLengths(algorithm, keyData, ivData);
    
    status = CCCryptorCreate(kCCDecrypt, algorithm, options,
                             [keyData bytes], [keyData length], [ivData bytes],
                             &cryptor);
    
    if (status != kCCSuccess) {
        if (error != NULL) {
            *error = status;
        }
        return (nil);
    }
    
    NSData *result = [self _runCryptor:cryptor result:&status];
    if ((result == nil)&& (error != NULL)) {
        *error = status;
    }
    
    CCCryptorRelease(cryptor);
    
    return (result);
}

#pragma mark BDCommonCryptor

- (NSData *)encryptedDataUsingCCAlgorithm:(uint32_t)algorithm key:(id)key {
    CCCryptorStatus status = kCCSuccess;
    NSData *result = [self encryptUsingAlgorithm:algorithm
                                             key:key
                            initializationVector:nil
                                         options:kCCOptionPKCS7Padding|kCCOptionECBMode
                                           error:&status];
    if (status != kCCSuccess) {
        NSLog(@">>>encrypt data error <CCCryptorStatus:%d>", status);
    }
    
    return result;
}

- (NSData *)decryptedDataUsingCCAlgorithm:(uint32_t)algorithm key:(id)key {
    CCCryptorStatus status = kCCSuccess;
    NSData *result = [self decryptUsingAlgorithm:algorithm
                                             key:key
                            initializationVector:nil
                                         options:kCCOptionPKCS7Padding|kCCOptionECBMode
                                           error:&status];
    if (status != kCCSuccess) {
        NSLog(@"<<<decrypt data error <CCCryptorStatus:%d>", status);
    }
    
    return result;
}

@end

@implementation NSString (BDCommonCryptor)

- (NSData *)encryptedDataUsingCCAlgorithm:(uint32_t)algorithm key:(id)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data encryptedDataUsingCCAlgorithm:algorithm key:key];
}

- (NSData *)decryptedDataUsingCCAlgorithm:(uint32_t)algorithm key:(id)key {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data decryptedDataUsingCCAlgorithm:algorithm key:key];
}

@end
