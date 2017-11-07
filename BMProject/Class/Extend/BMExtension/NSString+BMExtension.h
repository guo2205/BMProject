//
//  NSString+Category.h
//  WilliamFramework
//
//  Created by Well on 15/7/13.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BMExtension)

/**
 *  过滤html特殊字符
 *
 *  @return 过滤后的string
 */
- (NSString *)ignoreHTMLSpecialString;

#pragma mark -MD5加密

/**
 *  MD5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)md5String;

#pragma mark -判断字符串是否为空
/**
 *  判断是否为空
 *
 *  @return YES：空  NO：非空
 */
- (BOOL)isBlankString;

#pragma mark -判断字符是否为手机号、邮箱等
/**
 *  字符串是否为手机号
 *
 *  @return YES：是  NO：不是
 */
- (BOOL)isPhoneNumber;
/**
 *  字符串是否为邮箱
 *
 *  @return YES：是  NO：不是
 */
- (BOOL)isAvailableEmail;

#pragma mark -验证用户名是否合法
/**
 *  用户名是否合法，验证规则：
 *  只含有汉字、数字、字母、下划线不能以下划线开头和结尾
 *
 *  @return YES：合法 NO：不合法
 */
- (BOOL)isValidUsername;

#pragma mark -时间和字符串相互转化
/**
 *  日期转化为字符串
 *
 *  @param date 日期
 *
 *  @return 日期字符串 e.g. @"2015-07-13"
 */
+ (NSString *)dateStringFromDate:(NSDate *)date;

/**
 *  日期转化为时间
 *
 *  @param date 日期
 *
 *  @return 时间字符串 e.g. @"23:14"
 */
+ (NSString *)timeStringFromDate:(NSDate *)date;

/**
 *  日期转化为年月日＋时间
 *
 *  @param date 日期
 *
 *  @return 年月日时间 e.g. @"2015-07-17 23:14"
 */
+ (NSString *)dateTimeStringFromDate:(NSDate *)date;

#pragma mark -URL编码
/**
 *  使用UTF－8格式编码URL
 *
 *  @return 编码后的URL字符串
 */
- (NSString *)urlUseUTF8Encoding;

/**
 *  将UTF－8格式的URL字符串解码
 *
 *  @return 解码后的字符串
 */
- (NSString *)urlUseUTF8Decoding;

@end
