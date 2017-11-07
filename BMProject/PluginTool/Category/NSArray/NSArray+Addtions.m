//
//  NSArray+Addtions.m
//  MyProject
//
//  Created by 郭梦珂 on 15/11/24.
//  Copyright © 2015年 GMK. All rights reserved.
//

#import "NSArray+Addtions.h"

@implementation NSArray (Addtions)
/**
 *  英文字母排序
 *
 *  @return NSArray 排好序的数组
 */
-(NSArray *)EnSort{
    if (nil==self||self.count==0||[self isKindOfClass:[NSNull class]]) {
        return self;;
    }
    
    NSArray *sortArray = [self sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    return sortArray;
}

/**
 *  查看是否包含某一字符串
 *
 *  @return bool
 */
-(BOOL)isContain:(NSString *)string{
    if (nil==self||self.count==0||nil==string||[self isKindOfClass:[NSNull class]]||[string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",string];
    NSArray *array= [self filteredArrayUsingPredicate:pred];
    if (array.count>0) {
        return YES;
    }
    return NO;
}

-(BOOL)isContains:(id)object{
    
    if (nil==self||self.count==0||nil==object||[self isKindOfClass:[NSNull class]]||[object isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    if ([self indexOfObject:object]!=NSNotFound) {
        return YES;
    }
    
    return NO;
    
}

@end
