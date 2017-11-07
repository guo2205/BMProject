//
//  NSString+Addtions.h
//  MyProject
//
//  Created by GMK on 15/10/15.
//  Copyright (c) 2015年 GMK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addtions)

/**
 *  可以计算中文字符串的字节数
 */
-(NSUInteger)cLength;

/**
 *  Font
 */
- (CGSize) size_With_Font:(UIFont *)font;

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size;

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

/**
 *  MD5加密
 *
 *  @return 返回加密后的字符串
 */
-(NSString *)MD5;

- (NSString *)AES256ParmEncrypt:(NSString *)key;
- (NSString *)AES256ParmDecrypt:(NSString *)key;

- (BOOL)isEmty;
/**
 *  UTF8乱码处理NSURL中带有汉字参数的乱码处理
 */
-(NSString *)UTF8Encoding;

/**
 * 邮箱验证
 */
-(BOOL) isEmail;

/**
 * 手机号码验证
 */
- (BOOL) isMobileNum;

/**
 * 车牌号
 */
- (BOOL) isLicenseNo;

/**
 * QQ验证
 */
- (BOOL) isQQNum;

/**
 * 身份证验证
 */
- (BOOL) isIdentityCard;

/**
 * 验证是否为纯数字组成
 */
- (BOOL) isNumber;

-(BOOL)isChinese;

/**
 * 查看字符串只包含数字和字母
 */
-(BOOL) checkIsOnlyHaveNumAndLetter;

/**
 * 查看包含某个字符串
 */
-(BOOL) isContains:(NSString *)string;
- (NSString *)replacingOfRegexp:(NSString *)regexp withString:(NSString *)replacement;
//判断是否有中文
-(BOOL)haveChinese;
@end
