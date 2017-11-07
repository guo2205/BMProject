//
//  UIView+Extension.h
//  黑马微博2期
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 *  模仿模态弹出view(全屏)
 */
- (void)presentView:(UIView *)view;

/**
 *  模仿模态消失view(全屏)
 */
- (void)dismissView;
/**
 *  从屏幕底部弹出
 */
- (void)present;
- (void)presentAnimations:(void (^)(void))animations;
- (void)presentAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
/**
 *  从屏幕底部消失
 */
- (void)dismiss;
- (void)dismissAnimations:(void (^)(void))animations;
- (void)dismissAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
@end
