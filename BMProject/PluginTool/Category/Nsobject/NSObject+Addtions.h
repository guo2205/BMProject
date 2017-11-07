//
//  NSObject+Addtions.h
//  MyProject
//
//  Created by 郭梦珂 on 15/11/27.
//  Copyright © 2015年 GMK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Addtions)

/**
 *  为对象类型添加属性（可以仿照添加所需属性）
 *
 */
@property (nonatomic ,strong) NSIndexPath* indexpPath;

@property (nonatomic ,strong) NSString *btnIndex;

/**
 *  转化为字符串类型 
 *
 *  @return 字符串
 */
-(NSString *)beString;

-(void)showMsg:(NSString *)msg;

@end
