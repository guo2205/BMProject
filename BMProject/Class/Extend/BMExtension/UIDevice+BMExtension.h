//
//  UIDevice+Category.h
//  WilliamFramework
//
//  Created by Well on 15/7/14.
//  Copyright (c) 2015年 William. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DeviceiPhone) {
    DeviceiPhone4Series,    //iPhone4系列 iPhone4  iPhone4S
    DeviceiPhone5Series,    //iPhone5系列 iPhone5  iPhone5C iPhone5S
    DeviceiPhone6Series,    //iPhone6系列 iPhone6  iPhone6Plus
    DeviceiPhoneOther
};

@interface UIDevice (BMExtension)

/**
 *  系统是否7.0及以上
 *
 *  @return e.g. YES:是 NO:否
 */
+ (NSUInteger)systemMajorVersion;

/**
 *  获取当前设备类型
 *
 *  @return e.g. iPhone4系列 iPhone5系列 iPhone6系列 其他
 */
+ (DeviceiPhone)currentDeviceType;

@end


