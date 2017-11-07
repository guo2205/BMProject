//
//  NSString+Category.m
//  WilliamFramework
//
//  Created by Well on 15/7/13.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import "NSString+BMExtension.h"

// MD5加密
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (BMExtension)

- (NSString *)ignoreHTMLSpecialString
{
    NSString *returnStr = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@""];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    // 如果还有别的特殊字符，请添加在这里
    /*
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ge;" withString:@"—"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&mdash;" withString:@"®"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@"“"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@"”"];
     returnStr = [returnStr stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
     */
    
    return returnStr;
}

- (NSString *)md5String{
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    // 先转MD5，再转大写
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (BOOL)isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (str.length == 0) {
        return YES;
    }
    
    if ([self isEqualToString:@"(null)"] || [self isEqualToString:@"null"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isPhoneNumber{
    //
    NSString *MOBILE    = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString *CM        = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378]|7[7])\\d)\\d{7}$";   // 包含电信4G 177号段
    NSString *CU        = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT        = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    //
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    BOOL res1 = [regextestmobile evaluateWithObject:self];
    BOOL res2 = [regextestcm evaluateWithObject:self];
    BOOL res3 = [regextestcu evaluateWithObject:self];
    BOOL res4 = [regextestct evaluateWithObject:self];
    
    if (res1 || res2 || res3 || res4 ){
        return YES;
    }
    return NO;
}

- (BOOL)isAvailableEmail{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString       = self.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString] ;
}

- (BOOL)isValidUsername{
    NSString *userNameRegex = @"^(?!_)(?!.*?_$)[a-zA-Z0-9_\u4e00-\u9fa5]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}

#pragma mark -时间和字符串相互转化

+ (NSString *)dateStringFromDate:(NSDate *)date{
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"YYYY-MM-dd";
        return [formatter stringFromDate:date];
    }
}

+ (NSString *)timeStringFromDate:(NSDate *)date{
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"hh:mm";
        return [formatter stringFromDate:date];
    }
}

+ (NSString *)dateTimeStringFromDate:(NSDate *)date{
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"YYYY-MM-dd hh:mm";
        return [formatter stringFromDate:date];
    }
}

- (NSDate *)dateFromString{
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"YYYY-MM-dd";
        return [formatter dateFromString:self];
    }
}

- (NSDate *)timeFromString{
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"hh:mm";
        return [formatter dateFromString:self];
    }
}

- (NSDate *)dateTimeFromString{
    @autoreleasepool {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"YYYY-MM-dd HH:mm";
        formatter.locale = [NSLocale systemLocale];
        return [formatter dateFromString:self];
    }
}

- (NSString *)urlUseUTF8Encoding{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlUseUTF8Decoding{
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end

/**
 *  时间字符串转化为日期
 *
 *  @return 日期 e.g. 2015-07-13
 */
//- (NSDate *)dateFromString;

/**
 *  时间字符串转化为时间
 *
 *  @return 时间 e.g. 13:45
 */
//- (NSDate *)timeFromString;

/**
 *  时间字符串转化为日期＋时间
 *
 *  @return 日期＋时间 e.g. 2015-07-13 13:45
 */
//- (NSDate *)dateTimeFromString;
