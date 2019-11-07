//
//  NSData+Encryption.h
//  HaoMai
//
//  Created by B-A-N on 2019/11/7.
//  Copyright © 2019 Haomai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData(Encryption)

- (NSString *)md5String;

/**
 *  AES_256_CBC_PKCS7Padding+HMAC, 加密后输出的格式为IV+AES密文+SHA256+Salt
 */
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

/// rsa
- (NSData *)RSAEncryptWithPublicKey:(NSString *)pubKey;

@end

NS_ASSUME_NONNULL_END
