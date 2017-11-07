//
//  NSDate+Category.h
//  WilliamFramework
//
//  Created by Well on 15/7/13.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BMExtension)
+(NSDate*)dateWithString:(NSString*)dateStr;
/**
 *  距离当前时间间隔的描述
 *
 *  @return 时间描述字符串 e.g. 1分钟内 3分钟前 4小时前 5天前
 */
- (NSString *)timeIntervalDescription;

/**
 *  时间间隔另一种描述
 *
 *  @return 间隔描述 e.g. 昨天20:14 星期三1:15
 */
- (NSString *)friendlyTimeDescription;

/**
 *  标准时间间隔描述
 *
 *  @return e.g. 昨天20:15 凌晨1:23 上午8:45 晚上8:14
 */
- (NSString *)standardTimeDescription;

@end
