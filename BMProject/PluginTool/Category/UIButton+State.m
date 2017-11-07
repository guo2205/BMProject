//
//  UIButton+State.m
//  Metro
//
//  Created by Json on 16/3/19.
//  Copyright © 2016年 Json. All rights reserved.
//

#import "UIButton+State.h"
#import <objc/runtime.h>

@implementation UIButton (State)

- (void)setCommonImage:(UIImage *)commonImage {
    objc_setAssociatedObject(self, "chance_UIButton_commonImage", commonImage, OBJC_ASSOCIATION_RETAIN);
    if (!self.isUnusual) {
        [self setImage:[self commonImage] forState:UIControlStateNormal];
    }
}
- (UIImage *)commonImage {
    return objc_getAssociatedObject(self, "chance_UIButton_commonImage");
}

- (void)setUnusualImage:(UIImage *)unusualImage {
    objc_setAssociatedObject(self, "chance_UIButton_unusualImage", unusualImage, OBJC_ASSOCIATION_RETAIN);
    if (self.isUnusual) {
        [self setImage:[self unusualImage] forState:UIControlStateNormal];
    }
}
- (UIImage *)unusualImage {
    return objc_getAssociatedObject(self, "chance_UIButton_unusualImage");
}

- (void)setUnusual:(BOOL)unusual {
    if (self.isUnusual != unusual) {
        objc_setAssociatedObject(self, "chance_UIButton_status", @(unusual), OBJC_ASSOCIATION_RETAIN);
        
        if (unusual && [self unusualImage]) {
            [self setImage:[self unusualImage] forState:UIControlStateNormal];
        } else if ([self commonImage]) {
            [self setImage:[self commonImage] forState:UIControlStateNormal];
        }
    }
}

- (BOOL)isUnusual {
    id c = objc_getAssociatedObject(self, "chance_UIButton_status");
    return c ? [c boolValue] : NO;
}

- (void)setImage:(UIImage *)image forStatus:(UIButtonStatus)status {
    switch (status) {
        case UIButtonStatusUnusual:
            [self setUnusualImage:image];
            break;
        default:
            [self setCommonImage:image];
            break;
    }
}

- (void)setBackgroundColorState:(UIColor *)backgroundColor {
    [self setBackgroundColor:backgroundColor];
    [self setBackgroundImage:[self imageColor:backgroundColor] forState:UIControlStateHighlighted];
}

- (UIImage *)imageColor:(UIColor *)color {
    
    CIColor *cicolor = [CIColor colorWithCGColor:color.CGColor];
    CIColor *cicolor1 = [CIColor colorWithRed:fabs(cicolor.red - 0.1) green:fabs(cicolor.green - 0.1) blue:fabs(cicolor.blue - 0.1)];
    UIColor *color1 = [UIColor colorWithCIColor:cicolor1];
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color1 CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
