//
//  UIView+Addtions.h
//  MyProject
//
//  Created by GMK on 15/10/15.
//  Copyright (c) 2015年 GMK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Addtions)
/**
 *视图中心点
 */
@property (nonatomic)CGFloat x;

@property (nonatomic)CGFloat y;

/**
 *视图宽、高
 */
@property (nonatomic)CGFloat width;

@property (nonatomic)CGFloat height;

/**
 *视图左边
 */
@property (nonatomic)CGFloat left;

/**
 *视图右边
 */
@property (nonatomic)CGFloat right;

/**
 *视图上边
 */
@property (nonatomic)CGFloat top;

/**
 *视图下边
 */
@property (nonatomic)CGFloat bottom;

/**
 *视图大小
 */
@property (nonatomic)CGSize size;

/**
 *  设置圆角
 */
@property (nonatomic)CGFloat cornerRadius;
- (void)removeAllSubviews;
/**
 *  设置边框
 *
 *  @param width 边框宽度
 *  @param color 边框颜色
 */
-(void)addBorderdWidth:(CGFloat)width color:(UIColor *)color;

/**
 *  给视图添加横线 位置在中心点
 *
 *  @param color 删除线颜色
 */
-(void)addLineWithColor:(UIColor *)color;
@end
