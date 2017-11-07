//
//  HomeViewController+Test.m
//  BMProject
//
//  Created by Well on 15/7/30.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "HomeViewController+Test.h"
#import "TestRootViewController.h"

@implementation HomeViewController (Test)

- (void)startSelectedGearTest{
    // 1，背景图
    CGFloat buttonX = CGRectGetWidth(self.view.frame) / 2.0f - 50;
    CGFloat buttonY = CGRectGetHeight(self.view.frame) * 0.618 - 50;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 50.0f;
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(buttonX, CGRectGetHeight(self.view.frame) - 140, 100, 100)];
    [button addTarget:self action:@selector(startTest) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        button.frame = CGRectMake(buttonX, buttonY, 100, 100);
    } completion:nil];
}

- (void)startTest{
    TestRootViewController *root = [[TestRootViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:root];
    [[[UIApplication sharedApplication] delegate] window].rootViewController = nav;
}


@end
