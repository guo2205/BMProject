//
//  NSString+Addtions.m
//  MyProject
//
//  Created by GMK on 15/10/15.
//  Copyright (c) 2015年 GMK. All rights reserved.
//

#import "NSString+Addtions.h"
#import "NSData+Encryption.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Addtions)

-(NSUInteger)cLength{
    NSUInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUTF8StringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding] ;i++) {
        if (*p) {
            if(*p == '\xe4' || *p == '\xe5' || *p == '\xe6' || *p == '\xe7' || *p == '\xe8' || *p == '\xe9')
            {
                strlength--;
            }
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

/**
 *  Font
 */
- (CGSize) size_With_Font:(UIFont *)font{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self sizeWithAttributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]];
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version < 7.0)
    {
        return [self sizeWithFont: font];
    }
    else
    {
        return [self sizeWithAttributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]];
    }
#endif
}

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif

}

- (CGSize) size_With_Font:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    return [self boundingRectWithSize: size
                              options: NSStringDrawingUsesLineFragmentOrigin
                           attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                              context: nil].size;
#else
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version < 7.0)
    {
        return [self sizeWithFont: font constrainedToSize: size lineBreakMode: lineBreakMode];
    }
    else
    {
        return [self boundingRectWithSize: size
                                  options: NSStringDrawingUsesLineFragmentOrigin
                               attributes: [NSDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName, nil]
                                  context: nil].size;
    }
#endif
}


/**
 *  MD5加密
 *  
 *  @return md5字符串
 */
-(NSString *)MD5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int)strlen(cStr), result );
    
    return [NSString stringWithFormat:  @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]];
}

- (NSString *)AES256ParmEncrypt:(NSString *)key
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data AES256ParmEncryptWithKey:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

- (NSString *)AES256ParmDecrypt:(NSString *)key
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data AES256ParmDecryptWithKey:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

/**
 *  UTF8乱码处理NSURL中带有汉字参数的乱码处理
 */
-(NSString *)UTF8Encoding{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (BOOL)isEmty{
    if (!self) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}


/**
 *  邮箱验证
 *
 *  @return bool值
 */
-(BOOL) isEmail{
    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/**
 * 手机号码验证
 */
- (BOOL) isMobileNum{

    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex =  @"(^1(3|4|5|7|8)[0-9]\\d{8}$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

/**
 * QQ验证
 */
- (BOOL) isQQNum{
    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    NSString *qqRegex = @"^[1-9][0-9]{4,9}$";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqTest evaluateWithObject:self];
}


/**
 * 车牌号
 */
- (BOOL) isLicenseNo{
    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    NSString *regex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{3}$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

/**
 * 身份证验证
 */
- (BOOL) isIdentityCard{
    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    NSString *regex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$|^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

/**
 * 验证是否为纯数字组成
 */
- (BOOL)isNumber{
    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    NSString *regex =[NSString stringWithFormat:@"^[0-9]+"];
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [identityCardPredicate evaluateWithObject:self];
}

/**
 * 查看包含某个字符串
 */
-(BOOL)isContains:(NSString *)string{
    if (nil==self||nil==string||[self isKindOfClass:[NSNull class]]||[string isKindOfClass:[NSNull class]]) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    if ([self rangeOfString:string].location!=NSNotFound) {
        return YES;
    }
    return NO;
}

/**
 * 查看字符串只包含数字和字母
 */
-(BOOL)checkIsOnlyHaveNumAndLetter{
    if (nil==self||[self isKindOfClass:[NSNull class]]||self.length==0) {
        NSLog(@"字符串长度为0或不存在");
        return NO;
    }
    //数字条件
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合数字条件的有几个字节
    NSInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:self
                                                                options:NSMatchingReportProgress
                                                                  range:NSMakeRange(0, self.length)];
    
    //英文字条件
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    //符合英文字条件的有几个字节
    NSInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    
//    if (tNumMatchCount == self.length)
//    {
//        //全部是数字，没有英文
//        return NO;
//    }
//    else if (tLetterMatchCount == self.length)
//    {
//        //全部是英文，没有数字
//        return NO;
//    }
//    else
    if (tNumMatchCount + tLetterMatchCount == self.length)
    {
        //符合英文和数字相加的长度
        return YES;
    }
    else
    {
        return NO;
    }
}

//判断是否有中文
-(BOOL)haveChinese{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}


//判断是否是纯中文
-(BOOL)isChinese{
    if(self.length == 0 ){
        return NO;
    }
    
//    for(int i=0; i< [self length];i++){
//        int a = [self characterAtIndex:i];
//        if( a <= 0x4e00 ||a >= 0x9fff)
//        {
//            return NO;
//        }
//    }
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
//    return YES;
}

- (NSString *)replacingOfRegexp:(NSString *)regexp withString:(NSString *)replacement
{
    NSError *error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regexp options:0 error:&error];
    
    if (error) {
        return self;
    }
    
    NSString *result = [reg stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replacement];
    return result;
}


@end
