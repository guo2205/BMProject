//
//  Function.h
//  MyProject
//
//  Created by GMK on 15/10/15.
//  Copyright (c) 2015年 GMK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Function : NSObject
CGFloat DEF_Scale();

CGFloat Font_Size(CGFloat fontSize);

UIFont * DEF_Font(CGFloat fontSize);
UIFont * DEF_SPFont(CGFloat fontSize);
#pragma mark - UIColor
/**
 *  获取UIColor对象 (0 - 255)
 *
 *  @param r 红 0 - 255
 *  @param g 绿 0 - 255
 *  @param b 蓝 0 - 255
 */
UIColor *color_rgb(UInt8 r, UInt8 g, UInt8 b);

#pragma mark-UIImage

/**
 *  根据图片名获取图片
 *
 *  @param imageName 图片名字
 *
 *  @return UIImage
 */
UIImage * image_name  (NSString *imageName);

UIImage *image_color(UIColor *color);

#pragma mark-UIColor
/**
 *  根据图片获取颜色
 *
 *  @param image 图片
 *
 *  @return UIColor
 */
UIColor * color_image (UIImage *image);

/**
 *  把16进制颜色转化为UIColor
 *
 *  @param 颜色的16进制
 *
 *  @return UIColor
 */
UIColor *color_hex (NSUInteger hex);

UIColor *color_hexStr (NSString * color);

#pragma mark-checkCamera
BOOL checkCameraCanUse();

#pragma mark-时间/时间戳
NSString * Get_TimeSp();

NSDate   * GetDate_With_TimeSp (NSString *timeSp);

NSString * GetTime_With_TimeSp (NSString *timeSp);

#pragma mark-倒计时1
/**
 *  倒计时 1
 *
 *  @date   2016.05.08
 *
 *  @param duration         总时长
 *  @param decrease         每个时间间隔减少量
 *  @param interval         时间间隔
 *  @param runingHandler    每个时间间隔执行(当前时间)
 *  @param stopHandler      停止时执行(停止时间)
 *
 *  @return                 返回一个 t 用来控制运行. 取消运行dispatch_source_cancel(t)
 */
dispatch_source_t countdown_create_v3(double duration, double decrease, double interval, void(^runingHandler)(double currentTime), void(^stopHandler)(double stopTime));

#pragma mark-倒计时2
/**
 *  倒计时器2
 *
 *  @param timeOut      超时时间
 *  @param timeInterval 时间间隔
 *
 */
void CountDownTimeOut(NSTimeInterval timeOut,NSTimeInterval timeInterval,void(^runLoop)(int currentTime),void(^runStop)());

#pragma mark-复制内容到剪切板
/**
 *  需要自己判断一下nil和空
 *
 *  @param string 需要copy到粘贴板上的字符串
 */
void CopyToPasteboard(NSString *string);

#pragma mark-截屏代码
/**
 *  截取特定视图的图像
 *
 *  @param  string 需要截图的视图
 *
 *  @return 截取好的图片
 */
UIImage * ScreenShot(UIView *view);

#pragma mark-把两张图片合成一张图片
/**
 *  合出来的图片效果不怎么样
 *
 *  @param  image1    第一张图片
 *  @param  toImage   想要加到的图片
 *
 *  @return image
 */     
UIImage * AddImage(UIImage *image1,UIImage *toImage);

#pragma mark-获取手机macaddress
/**
 *  获取手机macaddress
 *
 *
 *  @return macaddress 字符串
 */

NSString *macAddress();

@end
