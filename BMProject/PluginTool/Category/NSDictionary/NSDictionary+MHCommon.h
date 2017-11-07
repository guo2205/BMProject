//
//  NSDictionary+MHCommon.h
//  Metro
//
//  Created by Json on 16/12/2.
//  Copyright (c) 2015年 Json. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MHCommon)

/**
 *  从字典中取出数组
 *
 *  @param key 字典的key
 *
 *  @return 数组
 */
-(NSArray *)arrayForKey:(id)key;
/**
 *  从字典中取出字符串
 *
 *  @param key 字典的key
 *
 *  @return 字符串
 */
-(NSString *)stringforMKey:(id)key;

#pragma mark - 代替原NSDictionary里的objectForKey方法
/**
 *  代替原NSDictionary里的objectForKey方法
 *
 *  @param aKey 传入key
 *
 *  @return 返回key对应的value
 */
- (id)objectForMHKey:(id)aKey;

/**
 *  删除字典中的null
 *
 *     替换""
 *
 *  @return  新字典
 */
-(NSDictionary *)deleteAllNullValue;
@end
