//
//  NSObject+Addtions.m
//  MyProject
//
//  Created by 郭梦珂 on 15/11/27.
//  Copyright © 2015年 GMK. All rights reserved.
//

#import "NSObject+Addtions.h"
#import <objc/runtime.h>
#import "AlertLabel.h"
#import "XPPromptTag.h"
@implementation NSObject (Addtions)

-(NSIndexPath *)indexpPath{
    return  objc_getAssociatedObject(self, @"indexPath");
}


-(void)setIndexpPath:(NSIndexPath *)indexpPath{
    objc_setAssociatedObject(self, @"indexPath", indexpPath, OBJC_ASSOCIATION_RETAIN);
}

-(NSString *)btnIndex{
    return  objc_getAssociatedObject(self, @"btnIndex");
}

-(void)setBtnIndex:(NSString *)btnIndex{
    objc_setAssociatedObject(self, @"btnIndex", btnIndex, OBJC_ASSOCIATION_RETAIN);
}

-(NSString *)beString{
    if ([self isKindOfClass:[NSNumber class]]||[self isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",self];
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    if (nil==self) {
        return @"";
    }
    
    return @"";
}

-(void)showMsg:(NSString *)msg{
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
    //[[AlertLabel sharedManager] showTextWith:msg fromView:WINDOW];
    [XPPromptTag showWithText:msg];
}

@end
