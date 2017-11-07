//
//  JsonManager.h
//  Metro
//
//  Created by MengHuan on 15/4/19.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonManager : NSObject

/**
 *  json解析
 *
 *  @param string数据源
 *
 *  @return 解析后的数据
 */
+ (id)JSONValue:(NSString *)string;

/**
 *  字典或数组转化为json
 *
 *  @param value 字典或数组
 *
 *  @return 转化后的字符串
 */
+ (NSString *)jsonStringFromValue:(id)value;

@end
