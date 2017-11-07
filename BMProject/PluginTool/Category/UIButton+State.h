//
//  UIButton+State.h
//  Metro
//
//  Created by Json on 16/12/1.
//  Copyright © 2016年 Json. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIButtonStatus) {
    UIButtonStatusCommon       = 0,
    UIButtonStatusUnusual
};

@interface UIButton (State)
@property (nonatomic, assign, getter=isUnusual) BOOL unusual; // default NO.

- (void)setImage:(UIImage *)image forStatus:(UIButtonStatus)status;
- (void)setBackgroundColorState:(UIColor *)backgroundColor;

@end
