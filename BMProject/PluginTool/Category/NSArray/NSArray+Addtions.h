//
//  NSArray+Addtions.h
//  MyProject
//
//  Created by 郭梦珂 on 15/11/24.
//  Copyright © 2015年 GMK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Addtions)
/**
 *  按英文字母排序  只能对字符串数组进行排序
 *
 *  @return NSArray 排好序的数组
 */
-(NSArray *)EnSort;


/**
 *  查看是否包含某一字符串 方法1:只能查询字符串  方法2:查看任意对象类型
 *
 *  @param  object 要查询的对象
 *
 *  @return bool
 */
-(BOOL)isContain:(NSString *)string;
-(BOOL)isContains:(id)object;
@end
