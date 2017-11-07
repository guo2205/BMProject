//
//  AppDelegate.m
//  BMProject
//
//  Created by MengHuan on 15/4/19.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//
//57c6401f3e546439a366cf55
//cffe72bbb57835f60e2f6ce1

#import "AppDelegate.h"
#import "Reachability.h"
#import "GuideView.h"
#import "AFNetworking.h"

@interface AppDelegate ()

// 网络状态实时监听
@property (strong, nonatomic) Reachability *reachability;

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Crash日志统计功能
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
    
    // 实时监听网络状态
    [self startRealTimeNetworkStatus];
    
    // 构造window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 显示window主窗口
    [self.window makeKeyAndVisible];
    
    // 设置rootViewController
    self.mainNavViewController      = [[MainNavViewController alloc]init];
    self.window.rootViewController  = self.mainNavViewController;
    
//    //极光推送
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
//    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        // use registerUserNotificationSettings
//        // iOS 8 Notifications
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound             | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//            [application registerForRemoteNotifications];
//        });
//    } else {
//        // use registerForRemoteNotifications
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//             (UIRemoteNotificationTypeNewsstandContentAvailability |
//              UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |
//              UIRemoteNotificationTypeSound)];
//        });
//    }
//#else
//    // use registerForRemoteNotifications
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         (UIRemoteNotificationTypeNewsstandContentAvailability |
//          UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge |
//          UIRemoteNotificationTypeSound)];
//    });
//#endif
//    [JPushManager setupWithOptions:launchOptions];
   
    // 显示引导页
//    [self showGuideHUD];
    
    // 显示水印
//    [self blueMobiWatermark];
    
    // Override point for customization after application launch.
    return YES;
}







- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Error in registration. Error: %@", error);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -
+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - 显示引导页
- (void)showGuideHUD
{
    // 引导页
    if (![DEF_PERSISTENT_GET_OBJECT(@"showGuide") boolValue])
    {
        DEF_PERSISTENT_SET_OBJECT([NSNumber numberWithBool:YES], @"showGuide");
        GuideView *guide = [[GuideView alloc] initWithFrame:self.window.bounds];
        [self.window addSubview:guide];
    }
}

#pragma mark - 水印
- (void)blueMobiWatermark
{
    // 添加水印
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blueMobiWatermark"]];
    iv.frame        = CGRectMake(0, DEF_HEIGHT(self.window) - 12, DEF_WIDTH(self.window), 12);
    [self.window addSubview:iv];
    [self.window bringSubviewToFront:iv];
}


#pragma mark -
#pragma mark - 实时监听网络状态

- (void)startRealTimeNetworkStatus
{
    // 开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    self.reachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.reachability startNotifier];
}

- (void)reachabilityChanged:(NSNotification* )note
{
    Reachability *curReach  = [note object];
    NetworkStatus status    = [curReach currentReachabilityStatus];
    
    NSLog(@"网络状态值: %ld", (long)status);
    
    // 根据网络状态值，在这里做你想做的事
    // ...
}

#pragma mark -Crash日志

void UncaughtExceptionHandler(NSException *exception){
    NSArray *callStackArr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSMutableString *strSymbols = [NSMutableString string];
    
    for (int i = 0; i < callStackArr.count; i ++) {
        [strSymbols appendString:callStackArr[i]];
        [strSymbols appendString:@"\r\n"];
    }
    
    UIDevice *device = [UIDevice currentDevice];
    NSString *deInfo = [NSString stringWithFormat:@"%@,%@%@",device.model,device.systemName,device.systemVersion];
    
    NSDictionary *dictionary = @{@"DeviceInfo":deInfo,@"ExceptionName":name,@"ExceptionReason":reason,
                                 @"ExceptionCallStackInfo":strSymbols};
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/ExceptionLog"];
    [dictionary writeToFile:filePath atomically:YES];
}

@end
