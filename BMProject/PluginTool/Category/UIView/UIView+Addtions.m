//
//  UIView+Addtions.m
//  MyProject
//
//  Created by GMK on 15/10/15.
//  Copyright (c) 2015年 GMK. All rights reserved.
//

#import "UIView+Addtions.h"

@implementation UIView (Addtions)
@dynamic cornerRadius;
/**
 *视图中心
 */
-(CGFloat)x{
    return self.center.x;
}
-(void)setX:(CGFloat)x{
    self.center=CGPointMake(x, self.y);
}

-(CGFloat)y{
    return self.center.y;
}
-(void)setY:(CGFloat)y{
    self.center=CGPointMake(self.x, y);
}


/**
 *视图宽、高
 */
-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    self.frame=CGRectMake(self.left, self.top, width, self.height);
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    self.frame=CGRectMake(self.left, self.top, self.width, height);
}

/**
 *视图左边
 */
-(CGFloat)left{
    return self.x-self.width/2.0;
}

-(void)setLeft:(CGFloat)left{
    self.x=left+self.width/2.0;
}

/**
 *视图右边
 */
-(CGFloat)right{
    return CGRectGetMaxX(self.frame);
}

-(void)setRight:(CGFloat)right{
    self.x=right-self.width/2.0;
}

/**
 *视图上边
 */
-(CGFloat)top{
    return self.y-self.height/2.0;
}

-(void)setTop:(CGFloat)top{
    self.y=top+self.height/2.0;
}

/**
 *视图下边
 */
-(CGFloat)bottom{
    return CGRectGetMaxY(self.frame);
}

-(void)setBottom:(CGFloat)bottom{
    self.y=bottom-self.height/2.0;
}

/**
 *  获取/设置 视图的大小
 */
- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.left, self.top, size.width, size.height);
}


/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角数值
 */
-(void)setCornerRadiu:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

-(CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}



/**
 *  设置边框
 *
 *  @param width 边框宽度
 *  @param color 边框颜色
 */
-(void)addBorderdWidth:(CGFloat)width color:(UIColor *)color{
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}


- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView *child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

/**
 *添加横线
 */
-(void)addLineWithColor:(UIColor *)color{
    UIView *layer=[[UIView alloc]init];
    layer.backgroundColor=color;
    layer.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:layer];
    NSLayoutConstraint *centerX=[NSLayoutConstraint constraintWithItem:layer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY=[NSLayoutConstraint constraintWithItem:layer attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *width=[NSLayoutConstraint constraintWithItem:layer attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    NSLayoutConstraint *height=[NSLayoutConstraint constraintWithItem:layer attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1];

#ifdef __IPHONE_8_0
    centerX.active=YES;
    centerY.active=YES;
    width.active=YES;
    height.active=YES;
#else
    [self addConstraints:@[centerX,centerY,width,height]];
#endif

}
@end
