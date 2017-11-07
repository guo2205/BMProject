//
//  UILabel+MHCommon.m
//  MHProject
//
//  Created by MengHuan on 16/3/25.
//  Copyright © 2016年 MengHuan. All rights reserved.
//

#import "UILabel+MHCommon.h"
#import <objc/runtime.h>

static const char* UILabelHeightEnhancementKey = "uilabel_height_associated_key";

@implementation UILabel (MHCommon)

- (CGFloat)originalHeight
{
    id obj = objc_getAssociatedObject(self, UILabelHeightEnhancementKey);
    
    if (obj && [obj respondsToSelector:@selector(floatValue)]) {
        return [obj floatValue];
    }
    
    // 还从来没设置过，这是第一次调用，以当前高度作为初始高度设置上去
    objc_setAssociatedObject(self, UILabelHeightEnhancementKey, [NSNumber numberWithFloat:self.frame.size.height], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return self.frame.size.height;
}


@end
