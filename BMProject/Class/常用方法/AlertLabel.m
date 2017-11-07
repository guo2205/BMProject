//
//  AlertLabel.m
//  MyProject
//
//  Created by 郭梦珂 on 15/12/3.
//  Copyright © 2015年 GMK. All rights reserved.
//

#import "AlertLabel.h"
@class AlertLabel;
@interface AlertLabel ()<UIScrollViewDelegate>
{
    NSString *alertMsg;
    float msgHeight;
}
@end

@implementation AlertLabel

+ (AlertLabel*)sharedManager {
    static dispatch_once_t once;
    static AlertLabel *shared=nil;
    dispatch_once(&once, ^ {
        shared=[[self alloc]init];
        shared.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        shared.showsVerticalScrollIndicator=NO;
        shared.layer.masksToBounds=YES;
        shared.layer.cornerRadius=7.0;
    });
    return shared;
}

-(void)showTextWith:(NSString *)msg fromView:(id)view{
    
    [self removeFromSuperview];
    
    self.contentOffset=CGPointMake(0, 0);
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dissmiss) object:nil];
    
    CGSize size=[msg size_With_Font:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-50, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    alertMsg=[msg beString];
    
    self.delegate=self;
    float with=[UIScreen mainScreen].bounds.size.width;
    float height=[UIScreen mainScreen].bounds.size.height;
    float sWidth=size.width;
    float sHeight=size.height+10;
    msgHeight=size.height;
    sHeight=sHeight<40?40:sHeight;
    sHeight=sHeight>(height-113)?(height-113):sHeight;
    
    BOOL isWindow=[view isKindOfClass:[UIWindow class]];
    
    self.frame=CGRectMake((with-size.width-30)/2,(150+sHeight)>(height-113)?(isWindow?64:0):height-150-sHeight, sWidth+30, sHeight);
    
    self.contentSize=CGSizeMake(size.width+30, msgHeight+10);
    
    [view addSubview:self];
    
    [self setNeedsDisplay];

    [self performSelector:@selector(dissmiss) withObject:nil afterDelay:1.5];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self setNeedsDisplay];
}
-(void)dissmiss{
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBFillColor (context, 1, 1, 1, 1);
    [alertMsg drawInRect:CGRectMake(10, (self.contentSize.height-msgHeight+(self.size.height==40?10:0))/2, self.width-20, msgHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor whiteColor],NSKernAttributeName:@1}];
}

@end
