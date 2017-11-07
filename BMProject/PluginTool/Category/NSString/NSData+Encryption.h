//
//  NSData+Encryption.h
//  MyProject
//
//  Created by Chance on 16/4/6.
//  Copyright © 2016年 GMK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)AES256ParmEncryptWithKey:(NSString *)key;   //加密
- (NSData *)AES256ParmDecryptWithKey:(NSString *)key;   //解密

@end
