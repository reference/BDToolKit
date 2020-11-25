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
#import <Foundation/Foundation.h>

@interface BDRSAEncryptor : NSObject

/*These APIs uesd to encrypt/decrypt data/string by pulick/private string.
  Sometimes we need to encrypt issue with string keys which wo get from web sercives.
  The goverment doesn't provide api which is able to encrypt/decrypt issue without certificate.
 
 The APIs fudges certificates use the pramaters 'str'.
 
 下面的api直接使用公私钥的字符串进行RSA加密。由于官方没有直接提供对应的api，所以这里使用公私钥字符串来伪造证书进行加密。
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

/*These APIs uesd to encrypt/decrypt data/string by pulick/private certificate
  The public key should be suffixal with .der and private key with .p12
  The original code https://github.com/baight/BDRSAEncryptor/blob/master/BDRSAEncryptor.m .
  I found that the decrypt mothed was wrong when data's length is longer than 128(the accurate value depends on the length of the keys.When the length of keys is 2048,it is 2048/8=256)
  I modified the code to make it run correctly.
  使用公私钥文件进行RSA加密
  代码来源 https://github.com/baight/BDRSAEncryptor/blob/master/BDRSAEncryptor.m ,之所以上传这个库,因为我发现原本的代码在解密时时错误的，它只在解密文件很小（小于秘钥长度／8）才能正常工作。我更改了代码,让它可以正常工作
 */
- (void)loadPublicKeyFromFile:(NSString*)derFilePath;
- (void)loadPublicKeyFromData:(NSData*)derData;

- (void)loadPrivateKeyFromFile:(NSString*)p12FilePath password:(NSString*)p12Password;
- (void)loadPrivateKeyFromData:(NSData*)p12Data password:(NSString*)p12Password;

- (NSString*)rsaEncryptString:(NSString*)string;
- (NSData*)rsaEncryptData:(NSData*)data ;

- (NSString*)rsaDecryptString:(NSString *)string;
- (NSData*)rsaDecryptData:(NSData *)data;

+ (void)setSharedInstance:(BDRSAEncryptor *)instance;
+ (BDRSAEncryptor*)sharedInstance;

@end
