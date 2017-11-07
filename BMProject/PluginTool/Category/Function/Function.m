//
//  Function.m
//  MyProject
//
//  Created by GMK on 15/10/15.
//  Copyright (c) 2015年 GMK. All rights reserved.
//

#import "Function.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation Function
#pragma mark-font

CGFloat DEF_Scale(){
    if (Scalewidth == 1) {
        return Scalewidth;
    }
    
    return 1+(Scalewidth -1)*0.5;
}

UIFont * DEF_Font(CGFloat fontSize){
    if(IS_IPHONE_6PLUS){
        return [UIFont systemFontOfSize:fontSize+1];
    }
    return [UIFont systemFontOfSize:fontSize];
}

UIFont * DEF_SPFont(CGFloat fontSize){
    if(IS_IPHONE_6PLUS){
        return [UIFont systemFontOfSize:fontSize+1];
    }
    return [UIFont systemFontOfSize:fontSize];
}

CGFloat Font_Size(CGFloat fontSize){
    if(IS_IPHONE_6PLUS){
        return fontSize + 1;
    }
    return fontSize;
}

#pragma mark-UIImage
UIImage * image_name (NSString *imageName){
    return [UIImage imageNamed:imageName];
}


#pragma mark-UIColor
UIColor *color_rgb(UInt8 r, UInt8 g, UInt8 b) {
    return color_rgba(r, g, b, 1);
}

UIColor *color_rgba(UInt8 r, UInt8 g, UInt8 b, CGFloat a) {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}
UIColor * color_image (UIImage *image){
    UIColor *color=[UIColor colorWithPatternImage:image];
    
    return color;
}


UIImage *image_color(UIColor *color)
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}  

UIColor *color_hex (NSUInteger hex){
    CGFloat red = (hex >> 16 & 0xFF) / 255.0f;
    CGFloat green = (hex >> 8 & 0xFF) / 255.0f;
    CGFloat blue = (hex & 0xFF) / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

UIColor *color_hexStr (NSString * color){
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0];
}

#pragma mark-checkCamera
BOOL checkCameraCanUse(){
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark-时间/时间戳
NSString * Get_TimeSp(){
    @autoreleasepool {
        NSDate *datenow = [NSDate date];
        
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        
        NSInteger interval = [zone secondsFromGMTForDate:datenow];
        
        NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
        
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
        
        return timeSp;
    }
}

NSDate * GetDate_With_TimeSp (NSString *timeSp){
    int timesp=[timeSp intValue];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timesp];
    return confromTimesp;
}

NSString * GetTime_With_TimeSp (NSString *timeSp){
    NSTimeInterval time=[timeSp doubleValue];
    //实例化一个NSDateFormatter对象
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}
#pragma mark-倒计时1
dispatch_source_t countdown_create_v3(double duration, double decrease, double interval, void(^runingHandler)(double currentTime), void(^stopHandler)(double stopTime)) {
    if ((runingHandler || stopHandler)) {
        __block double      _timeout    = duration;
        dispatch_queue_t    _queue      = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t   _timer      = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), interval * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            
            if (_timeout > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (runingHandler) {
                        runingHandler(_timeout);
                    }
                    _timeout -= decrease;
                });
            } else {
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (stopHandler) {
                        stopHandler(_timeout);
                    }
                });
            }
        });
        dispatch_resume(_timer);
        return _timer;
    }
    return NULL;
}

#pragma mark-倒计时2
void CountDownTimeOut(NSTimeInterval timeOut,NSTimeInterval timeInterval,void(^runLoop)(int currentTime),void(^runStop)()){
    __block int timeout=timeOut; //倒计时时间
    
    __block int allTime=timeOut+1; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),timeInterval*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                runStop();
            });
        }else{
            int seconds=timeout%allTime;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                runLoop(seconds);
            });
            timeout-=timeInterval;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark-复制内容到剪切板
void CopyToPasteboard(NSString *string){
    if (string.length==0||nil==string) {
        return;
    }
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;
}

#pragma mark-截屏代码
/*
 * 只能对在当前屏幕上显示的内容进行截图
 */
UIImage * ScreenShot(UIView *view){
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark-把两张图片合成一张图片
UIImage * AddImage(UIImage *image1,UIImage *toImage){
    UIGraphicsBeginImageContext(toImage.size);
    
    [toImage drawInRect:CGRectMake(0, 0, toImage.size.width, toImage.size.height)];
    
    [image1  drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}

#pragma mark-获取手机macaddress
NSString *macAddress()
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    free(buf);
    
    return [outstring uppercaseString];
}



@end
