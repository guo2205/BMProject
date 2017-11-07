//
//  BaseViewController.m
//  PerfectProject
//
//  Created by Meng huan on 14/11/19.
//  Copyright (c) 2014年 M.H Co.,Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Do any additional setup after loading the view.
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    // iOS7顶部屏幕适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
#endif
    
    // 默认背景色
    self.view.backgroundColor = DEF_RGB_COLOR(59, 172, 252);
}

#pragma mark - 错误提示
- (void)errorTipHUDByMsg:(NSString *)msg
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:msg
                                                delegate:nil
                                       cancelButtonTitle:@"好"
                                       otherButtonTitles:nil, nil];
    [av show];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark - 支持重力感应，屏幕旋转
- (BOOL)shouldAutorotate
{
    // 开启自动旋转，通过supportedInterfaceOrientations来指定旋转的方向
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    // 指定旋转的方向
    
    return UIInterfaceOrientationMaskAll;
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//    return UIInterfaceOrientationMaskPortrait;
}

@end
