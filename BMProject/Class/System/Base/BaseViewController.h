//
//  BaseViewController.h
//  PerfectProject
//
//  Created by Meng huan on 14/11/19.
//  Copyright (c) 2014年 M.H Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  错误提示
 *
 *  @param msg 提示的内容
 */
- (void)errorTipHUDByMsg:(NSString *)msg;

@end
