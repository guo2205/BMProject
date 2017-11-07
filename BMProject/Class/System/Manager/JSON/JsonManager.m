//
//  JsonManager.m
//  Metro
//
//  Created by MengHuan on 15/4/19.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "JsonManager.h"

@implementation JsonManager

+ (id)JSONValue:(NSString *)string
{
    return [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableContainers
                                             error:nil];
}

+ (NSString *)jsonStringFromValue:(id)value{
    if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]] ) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:value
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}

@end
