//
//  UIDevice+Category.m
//  WilliamFramework
//
//  Created by Well on 15/7/14.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import "UIDevice+BMExtension.h"
#import <sys/sysctl.h>
#import <sys/utsname.h>

@implementation UIDevice (BMExtension)

+ (NSUInteger)systemMajorVersion{
    
    return 7;
}

+ (DeviceiPhone)currentDeviceType{
    return [self platformNiceString];
}

+ (NSString *)platformRawString{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (DeviceiPhone)platformNiceString{
    NSString *platform = [self platformRawString];
    
    //iPhone4系列
    if ([platform isEqualToString:@"iPhone3,1"]) {
        return DeviceiPhone4Series;
    }
    if ([platform isEqualToString:@"iPhone3,3"]) {
        return DeviceiPhone4Series;
    }
    if ([platform isEqualToString:@"iPhone4,1"]) {
        return DeviceiPhone4Series;
    }
    
    //iPhone5系列
    if ([platform isEqualToString:@"iPhone5,1"]) {
        return DeviceiPhone5Series;
    }
    if ([platform isEqualToString:@"iPhone5,2"]) {
        return DeviceiPhone5Series;
    }
    if ([platform isEqualToString:@"iPhone5,3"]) {
        return DeviceiPhone5Series;
    }
    if ([platform isEqualToString:@"iPhone5,4"]) {
        return DeviceiPhone5Series;
    }
    if ([platform isEqualToString:@"iPhone6,1"]) {
        return DeviceiPhone5Series;
    }
    if ([platform isEqualToString:@"iPhone6,2"]) {
        return DeviceiPhone5Series;
    }
    
    //iPhone6 系列
    if ([platform isEqualToString:@"iPhone7,1"]) {
        return DeviceiPhone6Series;
    }
    if ([platform isEqualToString:@"iPhone7,2"]) {
        return DeviceiPhone6Series;
    }
    
    return DeviceiPhoneOther;
}

@end

/*
 
 @"i386"      on 32-bit Simulator
 @"x86_64"    on 64-bit Simulator
 @"iPod1,1"   on iPod Touch
 @"iPod2,1"   on iPod Touch Second Generation
 @"iPod3,1"   on iPod Touch Third Generation
 @"iPod4,1"   on iPod Touch Fourth Generation
 @"iPhone1,1" on iPhone
 @"iPhone1,2" on iPhone 3G
 @"iPhone2,1" on iPhone 3GS
 @"iPad1,1"   on iPad
 @"iPad2,1"   on iPad 2
 @"iPad3,1"   on 3rd Generation iPad
 @"iPhone3,1" on iPhone 4 (GSM)
 @"iPhone3,3" on iPhone 4 (CDMA/Verizon/Sprint)
 @"iPhone4,1" on iPhone 4S
 @"iPhone5,1" on iPhone 5 (model A1428, AT&T/Canada)
 @"iPhone5,2" on iPhone 5 (model A1429, everything else)
 @"iPad3,4" on 4th Generation iPad
 @"iPad2,5" on iPad Mini
 @"iPhone5,3" on iPhone 5c (model A1456, A1532 | GSM)
 @"iPhone5,4" on iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)
 @"iPhone6,1" on iPhone 5s (model A1433, A1533 | GSM)
 @"iPhone6,2" on iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)
 @"iPad4,1" on 5th Generation iPad (iPad Air) - Wifi
 @"iPad4,2" on 5th Generation iPad (iPad Air) - Cellular
 @"iPad4,4" on 2nd Generation iPad Mini - Wifi
 @"iPad4,5" on 2nd Generation iPad Mini - Cellular
 @"iPhone7,1" on iPhone 6 Plus
 @"iPhone7,2" on iPhone 6
 
 */