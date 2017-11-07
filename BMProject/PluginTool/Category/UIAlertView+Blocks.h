//
//  UIAlertView+Blocks.h
//  MyProject
//
//  Created by admin on 16/5/23.
//  Copyright © 2016年 GMK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
typedef void (^ActionBlocks)(NSInteger btnIndex);
@interface UIAlertView (Blocks)<UIAlertViewDelegate>
/**
 *  alertView 点击事件
 *
 *  @param action 
 */
- (void) handleBlock:(ActionBlocks)action;
@end
