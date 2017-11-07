//
//  UIView+Animation.h
//  MHProject
//
//  Created by 董駸 on 16/1/20.
//  Copyright © 2016年 MengHuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CompletionBlock)();

@interface UIView (Animation)

@property (copy,nonatomic) CompletionBlock completionBlock;

- (void)viewHiddenWithDuration:(NSTimeInterval)timeInterval completion:(CompletionBlock)completionBlock;

- (void)viewShowWithDuration:(NSTimeInterval)timeInterval completion:(CompletionBlock)completionBlock;

@end
