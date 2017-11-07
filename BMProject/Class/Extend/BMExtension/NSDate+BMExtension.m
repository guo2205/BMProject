//
//  NSDate+Category.m
//  WilliamFramework
//
//  Created by Well on 15/7/13.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import "NSDate+BMExtension.h"

#define D_MINUTE 60
#define D_HOUR   3600
#define D_DAY    86400
#define D_WEEK   604800
#define D_YEAR   31556926
@implementation NSDate (BMExtension)
+(NSDate*)dateWithString:(NSString*)dateStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateStr];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

- (NSString *)timeIntervalDescription{
    NSTimeInterval interval = -[self timeIntervalSinceNow];
    if (interval < D_MINUTE) {
        return @"一分钟内";
    } else if (interval < D_HOUR){
        return [NSString stringWithFormat:@"%.f分钟前",interval / D_MINUTE];
    } else if (interval < D_DAY){
        return [NSString stringWithFormat:@"%.f小时前",interval / D_HOUR];
    } else if (interval < 2592000){
        return [NSString stringWithFormat:@"%.f天前", interval / D_DAY];
    } else if (interval < 31536000){
        NSDateFormatter *formatter = [self formatterWithString:@"M月d日"];
        return [formatter stringFromDate:self];
    } else{
        return [NSString stringWithFormat:@"%.f年前", interval / 31536000];
    }
}

- (NSString *)friendlyTimeDescription{
    NSDateFormatter *formatter = [self formatterWithString:@"yyyy-MM-dd"];
    
    NSString *theDay = [formatter stringFromDate:self];
    NSString *today = [formatter stringFromDate:[NSDate date]];
    
    //获取只有年月日的日期
    NSDate *theDate = [formatter dateFromString:theDay];
    NSDate *todayDate = [formatter dateFromString:today];
    
    if ([theDay isEqualToString:today]) {
        [formatter setDateFormat:@"ah:mm"];
        return [formatter stringFromDate:self];
    } else if ([todayDate timeIntervalSinceDate:theDate] == D_DAY){
        [formatter setDateFormat:@"ah:mm"];
        return [NSString stringWithFormat:@"昨天 %@",[formatter stringFromDate:self]];
    } else if ([todayDate timeIntervalSinceDate:theDate] < D_WEEK*7){
        [formatter setDateFormat:@"EEEE ah:mm"];
        return [formatter stringFromDate:self];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd ah:mm"];
        return [formatter stringFromDate:self];
    }
}

- (NSString *)standardTimeDescription{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString * dateNow = [formatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:[[dateNow substringWithRange:NSMakeRange(8,2)] intValue]];
    [components setMonth:[[dateNow substringWithRange:NSMakeRange(5,2)] intValue]];
    [components setYear:[[dateNow substringWithRange:NSMakeRange(0,4)] intValue]];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date = [gregorian dateFromComponents:components]; //今天 0点时间
    
    
    NSInteger hour = [self hoursAfterDate:date];
    NSDateFormatter *dateFormatter = nil;
    NSString *ret = @"";
    
    //hasAMPM==TURE为12小时制，否则为24小时制
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM = containsA.location != NSNotFound;
    
    if (!hasAMPM) {
        if (hour <= 24 && hour > 0) {
            dateFormatter = [self formatterWithString:@"HH:mm"];
        }else if (hour < 0 && hour >= -24){
            dateFormatter = [self formatterWithString:@"昨天 HH:mm"];
        }else {
            dateFormatter = [self formatterWithString:@"yyyy-MM-dd"];
        }
    }else{
        if (hour >= 0 && hour <= 6) {
            dateFormatter = [self formatterWithString:@"凌晨 hh:mm"];
        }else if (hour > 6 && hour <= 11){
            dateFormatter = [self formatterWithString:@"上午 hh:mm"];
        }else if (hour > 11 && hour <= 17){
            dateFormatter = [self formatterWithString:@"下午 hh:mm"];
        }else if (hour > 17 && hour <= 24){
            dateFormatter = [self formatterWithString:@"晚上 hh:mm"];
        }else if (hour < 0 && hour >=-24){
            dateFormatter = [self formatterWithString:@"昨天 HH:mm"];
        }else{
            dateFormatter = [self formatterWithString:@"yyyy-MM-dd"];
        }
    }
    ret = [dateFormatter stringFromDate:self];
    return ret;
}

- (NSDateFormatter *)formatterWithString:(NSString *)fromatterString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = fromatterString;
    return formatter;
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

@end
