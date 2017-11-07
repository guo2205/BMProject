//
//  CommUtls.m
//  SDHBusiness
//
//  Created by wangjing on 15/8/12.
//  Copyright (c) 2015年 . All rights reserved.
//

#import "CommUtls.h"

#import  <dlfcn.h>
#include <netdb.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#import  <CommonCrypto/CommonCryptor.h>
#import  <SystemConfiguration/SystemConfiguration.h>
#import <objc/runtime.h>
#include <sys/param.h>
#include <sys/mount.h>


@implementation CommUtls

/**
 *	@brief	通过字节获取文件大小
 *
 *	@param  number  字节数
 *
 *	@return	返回大小
 */
+ (NSString *)getSize:(NSNumber *)number
{
    long size = [number longValue];
    if (size < 1024)
        return [NSString stringWithFormat:@"%ldB", size];
    else {
        long size1 = size/1024;
        if (size1 < 1024) {
            return [NSString stringWithFormat:@"%ld.%ldKB", size1, (size-size1*1024)/10];
        } else {
            long size2 = size1/1024;
            if (size2 < 1024)
                return [NSString stringWithFormat:@"%ld.%ldMB", size2, (size1-size2*1024)/10];
            else {
                long size3 = size2/1024;
                return [NSString stringWithFormat:@"%ld.%ldGB", size3, (size2-size3*1024)/10];
            }
        }
    }
    return @"0B";
}

/**
 *	@brief	获取随即数
 *
 *	@param  min     最小数值
 *	@param  max     最大数值
 *
 *	@return	返回数值
 */
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max
{
    NSInteger value = 0;
    if (min > 0)
        value = (arc4random() % (max-min+1)) + min;
    else
        value = arc4random() % max;
    return value;
}

/**
 *	@brief	获取颜色
 *
 *	@param  stringToConvert         取色数值
 *
 *	@return	返回颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6)
        return [UIColor whiteColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float)r / 255.0f)
                           green:((float)g / 255.0f)
                            blue:((float)b / 255.0f)
                           alpha:1.0f];
}


/**
 *	@brief	mac地址
 *
 *	@return	返回地址
 */
+ (NSString *)macAddress
{
    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    size_t length;
    unsigned char macAddress[6];
    struct if_msghdr *interfaceMsgStruct;
    struct sockaddr_dl *socketStruct;
    NSString *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL) {
        free(msgBuffer);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *)msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *)(interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

/**
 *	@brief	转换字符串编码
 *
 *	@param  s       字符串
 *
 *	@return	返回UTF-8的编码
 */
+ (NSString *)encode:(NSString *)s
{
    return [s stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

/**
 * @brief 图片压缩
 *  UIGraphicsGetImageFromCurrentImageContext函数完成图片存储大小的压缩
 * Detailed
 * @param[in] 源图片；指定的压缩size
 * @param[out] N/A
 * @return 压缩后的图片
 * @note
 */
+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize
{
    CGFloat scale;
    CGSize newsize = image.size;
    if (newsize.height && (newsize.height > viewsize.height)) {
        scale = viewsize.height/newsize.height;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    if (newsize.width && (newsize.width >= viewsize.width)) {
        scale = viewsize.width /newsize.width;
        newsize.width *= scale;
        newsize.height *= scale;
    }
    UIGraphicsBeginImageContext(viewsize);
    
    float dwidth = (viewsize.width - newsize.width)/2.0f;
    float dheight = (viewsize.height - newsize.height)/2.0f;
    
    CGRect rect = CGRectMake(dwidth, dheight, newsize.width, newsize.height);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *)systemTime:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    [[NSDate date] timeIntervalSince1970];
    [formatter setDateFormat:format];
    NSString *returnTime = [formatter stringFromDate:date];
    return returnTime;
}

+ (NSString *)specialCharForXML:(NSString *)str
{
    if (str != nil) {
        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        str = [str stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
        str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }
    return str;
}

/**
 *	@brief	转换字典对象,根据info属性名赋值
 *
 *	@param  infoObject      <#infoObject description#>
 *	@param  jsonDic         <#jsonDic description#>
 *
 *	@return	<#return value description#>
 */
+ (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic
{
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([infoObject class], &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameStr = [NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding];
        if ([jsonDic valueForKey:propertyNameStr] != nil) {
            [infoObject setValue:[jsonDic valueForKey:propertyNameStr] forKey:propertyNameStr];
        }
    }
    free(properties);
    return infoObject;
}

+ (NSNumber *)freeDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemFreeSize];
}

+ (NSNumber *)totalDiskSpace
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [fattributes objectForKey:NSFileSystemSize];
}

//计算文本的大小
+ (CGSize)getContentSize:(NSString *)content font:(UIFont *)font size:(CGSize)size
{
    CGSize cSize = CGSizeZero;
    NSDictionary *attribute = @{NSFontAttributeName:font};
    cSize = [content boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return cSize;
}

+ (NSString *)getSoftShowVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)getSoftBuildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)getDomainIP:(NSString *)host
{
    NSString *webSiteString = host;
    
    //NSString to char*
    const char *webSite = [webSiteString cStringUsingEncoding:NSASCIIStringEncoding];
    
    // Get host entry info for given host
    struct hostent *remoteHostEnt = gethostbyname(webSite);
    
    // Get address info from host entry
    struct in_addr *remoteInAddr = (struct in_addr *)remoteHostEnt->h_addr_list[0];
    
    // Convert numeric addr to ASCII string
    char *sRemoteInAddr = inet_ntoa(*remoteInAddr);
    
    //char* to NSString
    NSString *ip = [[NSString alloc] initWithCString:sRemoteInAddr
                                            encoding:NSASCIIStringEncoding];
    return ip;
}


/**
 *  根据text字段排序
 *
 *  @param array 数据源
 *  @param text  排序字段
 *  @param desc  是否降序
 *
 *  @return 排列后的数据
 */
+ (NSArray *)sequenceArray:(NSArray *)array text:(NSString *)text desc:(BOOL)desc
{
    if (array.count == 0) {
        return array;
    }
    
    //排序
    NSMutableArray *marray1 = [NSMutableArray arrayWithArray:array];
    
    for (int i = 0; i < marray1.count-1; i++) {
        for (int j = 0; j < marray1.count-1-i; j++) {
            NSDictionary *dic1 = [marray1 objectAtIndex:j];
            NSDictionary *dic2 = [marray1 objectAtIndex:(j+1)];
            
            BOOL change = NO;
            if (desc && [[dic2 objectForKey:text] intValue] > [[dic1 objectForKey:text] intValue]) {
                change = YES;
            } else if (!desc && [[dic2 objectForKey:text] intValue] < [[dic1 objectForKey:text] intValue]) {
                change = YES;
            }
            if (change) {
                [marray1 replaceObjectAtIndex:j withObject:dic2];
                [marray1 replaceObjectAtIndex:(j+1) withObject:dic1];
            }
        }
    }
    return marray1;
}

/**
 *  根据text字段将fromArray数组的数据添加到toArray中字典的key字段里
 *
 *  @param fromArray 需要添加的数据源
 *  @param text      根据字段
 *  @param toArray   添加到的数据源
 *  @param key       添加到toArray中数据的key字段
 *
 *  @return 添加完成的数据源
 */
+ (NSArray *)packageArray:(NSArray *)fromArray text:(NSString *)text forArray:(NSArray *)toArray key:(NSString *)key
{
    if (toArray.count == 0) {
        return toArray;
    }
    
    //fromArray数据组装
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    for (NSDictionary *d1 in fromArray) {
        NSString *title = [NSString stringWithFormat:@"%@", [d1 objectForKey:text]];
        if (![dic objectForKey:title]) {
            [dic setObject:[NSMutableArray arrayWithCapacity:1] forKey:title];
        }
        NSMutableArray *array = [dic objectForKey:title];
        [array addObject:d1];
    }
    
    //组装数据
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < toArray.count; i++) {
        NSDictionary *d2 = [toArray objectAtIndex:i];
        NSString *title = [NSString stringWithFormat:@"%@", [d2 objectForKey:text]];
        
        NSMutableDictionary *d3 = [NSMutableDictionary dictionaryWithDictionary:d2];
        [array addObject:d3];
        if ([dic objectForKey:title]) {
            [d3 setObject:[dic objectForKey:title] forKey:key];
        }
    }
    
    return array;
}

+ (NSInteger)getFloatPointNumbers:(double)floatValue
{
    NSInteger totalCount = 0;
    NSString *str1 = [NSString stringWithFormat:@"%f",floatValue];
    NSRange range = [str1 rangeOfString:@"."];
    for (NSInteger i=(NSInteger)range.location ;i<(str1.length-range.location);i++) {
        NSString *substr = [str1 substringWithRange:NSMakeRange(i,1)];
        if (![substr isEqualToString:@"0"]) {
            totalCount = (i-(NSInteger)range.location);
            continue;
        }
    }
    return totalCount;
}
/**
 *  RGB颜色
 *
 *  @param alpha 透明度 0~1
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithR:(float)red G:(float)green B:(float)blue A:(float)alpha
{
    return [UIColor colorWithRed:red/255.00 green:green/255.00 blue:blue/255.00 alpha:alpha];
}
+ (UIColor *)colorWithR:(float)red G:(float)green B:(float)blue
{
    return [self colorWithR:red G:green B:blue A:1];
}

/**
 *  返回字号
 *
 *  @param size 大小
 *
 *  @return 返回字号
 */
+ (UIFont *)fontOfSize:(int)size
{
    return [UIFont systemFontOfSize:size];
}
+ (NSArray *)sortedDataWithArray:(NSArray *)sourceArray
                   keyForCompare:(NSString *)key
{
    return  [sourceArray sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *infoDic1, NSDictionary *infoDic2) {
        NSNumber *number1 = [infoDic1 valueForKey:key];
        NSNumber *number2 = [infoDic2 valueForKey:key];
        return [number1 compare:number2];
    }];
}

/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
+ (BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    
    if (name.length > 0)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = NO;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            
            if (!isValid)
            {
                break;
            }
        }
    }
    
    return isValid;
}


/* 创建UILabel */
+ (UILabel*)createLabelWithTitle:(NSString*)title fontSize:(UIFont *)fontSize textColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]init];
    label.font = fontSize;
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
    label.numberOfLines = 0;
    label.text = title;
    return label;
}
/* 创建UIButton */
+ (UIButton*)createButtonWithTitle:(NSString*)title image:(NSString *)image fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor target:(id)target sel:(SEL)sel
{
    UIButton * button = nil;
    if (image)
    {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        if (title)
        {
            [button setTitle:title forState:UIControlStateNormal];
            [button setTitleColor:textColor forState:UIControlStateNormal];
        }
        
    }
    else if (title)
    {
        button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        
    }
    button.titleLabel.font = fontSize;
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 5.0f;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

/* 创建UITextField */
+ (UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeholder fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor delegate:(id<UITextFieldDelegate>)delegate
{
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.textColor = textColor;
    textField.font = fontSize;
    textField.delegate = delegate;
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
    
}

@end
