//
//  MHDefine.h
//  PerfectProject
//
//  Created by Meng huan on 14/12/3.
//  Copyright (c) 2014年 M.H Co.,Ltd. All rights reserved.
//


#define CACHENAME @"metadataObject_string"


#import "MHLogDefine.h"
#import "MHPathDefine.h"
#import "MHViewDefine.h"
#import "MHLabelDefine.h"
#import "MHPersistentDefine.h"
#import "MHNotificationDefine.h"
#import "Masonry.h"
#import "MHCategory.h"

#ifndef PerfectProject_MHDefine_h
#define PerfectProject_MHDefine_h

// 底部TabBar的高度
#define DEF_TAB_BAR_HEIGHT 50

/**
 *  在此处定义宏
 */
// 判断屏幕尺寸
//是否为iphone6Plus
#define IS_IPHONE_6PLUS ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
#define IPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//RGB
#define RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b)     RGBA(r, g, b, 1.0f)
#define getColor(color)   [UIColor colorWithRed:((float)((strtoul([color UTF8String],0,16) & 0xFF0000) >> 16))/255.0 green:((float)((strtoul([color UTF8String],0,16) & 0xFF00) >> 8))/255.0 blue:((float)(strtoul([color UTF8String],0,16) & 0xFF))/255.0 alpha:1.0]

// 此App中使用的自定义字体名称
#define DEF_Default_FontName @"DFShaoNvW5"

#define SINGLE_LINE_WIDTH  (1.5 / [UIScreen mainScreen].scale)


/**
 *  获取屏幕的宽度,按比例计算控件的宽度
 */
#define Scalewidth [[UIScreen mainScreen] bounds].size.width/375.0

// 判断是否为3.5屏
#define DEF_640_960 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define Request_URL  @""

#endif
