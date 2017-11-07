//
//  NSDictionary+MHCommon.m
//  Metro
//
//  Created by Json on 16/12/2.
//  Copyright (c) 2015年 Json. All rights reserved.
//

#import "NSDictionary+MHCommon.h"

@implementation NSDictionary (MHCommon)
-(NSArray *)arrayForKey:(id)key{
    id obj=[self objectForKey:key];
    if ([obj isKindOfClass:[NSArray class]]) {
        return obj;
    }
    
    return [NSArray new];
}

/**
 *  从字典中取出字符串
 *
 *  @param key 字典的key
 *
 *  @return 字符串
 */
-(NSString *)stringforMKey:(id)key{
    if (![self.allKeys isContains:key]) {
        return @"";
    }
    
    id obj=[self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    
    return [obj beString];
}

#pragma mark - 代替原NSDictionary里的objectForKey方法
/**
 *  代替原NSDictionary里的objectForKey方法
 *
 *  @param aKey 传入key
 *
 *  @return 返回key对应的value
 */
- (id)objectForMHKey:(id)aKey
{
    if (![[self allKeys] containsObject:aKey])
    {
        DEF_DEBUG(@"[字典对应的key:\"%@\"不存在]", aKey);
        
        // 如果aKay不存在，则返回空字符串
        return @"";
    }
    
    // 返回原本key对应的value
    return [self objectForKey:aKey];
}

/**
 *  删除字典中的null
 *
 *     替换""
 *
 *  @return  新字典
 */
- (NSDictionary *)deleteAllNullValue{
    NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    for (NSString *keyStr in self.allKeys) {
        if ([[self objectForKey:keyStr] isEqual:[NSNull null]]) {
            [mutableDic setObject:@"" forKey:keyStr];
        }
        else{
            [mutableDic setObject:[self objectForKey:keyStr] forKey:keyStr];
        }
    }
    return mutableDic;
}
@end

