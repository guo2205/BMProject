//
//  UIView+Extension.m
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"
#import "AView.h"
@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}
- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}
- (CGFloat)centerY
{
    return self.center.x;
}
- (void)presentView:(UIView *)view
{
    [view.superview bringSubviewToFront:view];
    [UIView animateWithDuration:.25 delay:0 options:7<<16 animations:^{
        view.y = [[UIScreen mainScreen] bounds].size.height * 0.5;
        
    } completion:nil];
}

- (void)dismissView
{
    __weak __typeof(self) _self = self;
    [UIView animateWithDuration:.25 delay:0 options:7<<16 animations:^{
        _self.y = [[UIScreen mainScreen] bounds].size.height * 1.5;
        
    } completion:nil];
}
- (void)present
{
    [self presentAnimations:nil completion:nil];
}

- (void)presentAnimations:(void (^)(void))animations
{
    [self presentAnimations:animations completion:nil];
}

- (void)presentAnimations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    UIView *view = [[AView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__dismiss:)]];
    [window addSubview:view];
    
    self.center = CGPointMake(self.center.x, window.frame.size.height + self.frame.size.height * 0.5);
    [view addSubview:self];
    
    __weak __typeof(self) _self = self;
    [UIView animateWithDuration:1 delay:0 options:7<<16 animations:^{
        
        _self.center = CGPointMake(_self.center.x, [[UIScreen mainScreen] bounds].size.height - _self.frame.size.height * 0.5);
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        if (animations) {
            animations();
        }
        
    } completion:^(BOOL finished) {
        
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)__dismiss:(UITapGestureRecognizer *)tap
{
    if ([tap locationInView:self].y < 0) {
        [self dismiss];
    }
}

- (void)dismiss
{
    [self dismissAnimations:nil completion:nil];
}

- (void)dismissAnimations:(void (^)(void))animations
{
    [self dismissAnimations:animations completion:nil];
}

- (void)dismissAnimations:(void (^)(void))animations completion:(void (^ __nullable)(BOOL finished))completion
{
    __weak __typeof(self) _self = self;
    [UIView animateWithDuration:1 delay:0 options:7<<16 animations:^{
        
        _self.center = CGPointMake(_self.center.x, [[UIScreen mainScreen] bounds].size.height + _self.frame.size.height * 0.5);
        _self.superview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        
        if (animations) {
            animations();
        }
        
    } completion:^(BOOL finished) {
        [_self.superview removeFromSuperview];
        [_self removeFromSuperview];
        
        if (completion) {
            completion(finished);
        }
    }];
}


@end
