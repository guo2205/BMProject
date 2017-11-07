//
//  UIButton+ClickBlock.h
//  MyProject
//
//  Created by admin on 16/5/23.
//  Copyright © 2016年 GMK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef void (^ActionBlock)(UIButton *sender);
@interface UIButton (Blocks)

- (void) handleBlock:(ActionBlock)action;

- (void) sd_setImageWithUrlString:(NSString *)urlStr placeImage:(UIImage *)image;
@end
