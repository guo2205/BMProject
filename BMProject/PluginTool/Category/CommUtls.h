//
//  CommUtls.h
//  SDHBusiness
//
//  Created by wangjing on 15/8/12.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>


@interface CommUtls : NSObject


/**
 *  获取文件大小用KB MB G 显示
 *
 *  @param number 文件数字大小
 *
 *  @return 返回例如12KB
 */
+ (NSString *)getSize:(NSNumber *)number;

/**
 *  获取磁盘剩余空间
 *
 *  @return 剩余多少
 */
+ (NSNumber *)freeDiskSpace;

/**
 *  获取磁盘总大小
 *
 *  @return NSNumber
 */
+ (NSNumber *)totalDiskSpace;

/**
 *  获取随即数
 *
 *  @param min 最小值
 *  @param max 最大值
 *
 *  @return NSInteger
 */
+ (NSInteger)getRandomNumber:(NSInteger)min maxNumber:(NSInteger)max;

/**
 *  获取颜色值
 *
 *  @param stringToConvert
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *  图片压缩
 *
 *  @param image
 *  @param viewsize
 *
 *  @return UIImage
 */
+ (UIImage *)image:(UIImage *)image fitInsize:(CGSize)viewsize;

/**
 *  获取当前时间
 *
 *  @param format
 *
 *  @return NSString
 */
+ (NSString *)systemTime:(NSString *)format;

/**
 *  过滤xml
 *
 *  @param str
 *
 *  @return NSString
 */
+ (NSString *)specialCharForXML:(NSString *)str;

//根据info属性名赋值
+ (NSObject *)initPropertyWithClass:(NSObject *)infoObject fromDic:(NSDictionary *)jsonDic;


/**
 *  计算文本的大小
 *
 *  @return size
 */
+ (CGSize)getContentSize:(NSString *)content font:(UIFont *)font size:(CGSize)size;

/**
 *  获取软件显示版本号
 *
 *  @return NSString
 */
+ (NSString *)getSoftShowVersion;

/**
 *  获取软件内部版本号
 *
 *  @return NSString
 */
+ (NSString *)getSoftBuildVersion;

/**
 *  获取访问域名IP
 *
 *  @param host 域名
 *
 *  @return NSString
 */
+ (NSString *)getDomainIP:(NSString *)host;



//+ (NSString *)md5EncryptWithParams:(NSArray *)params;

/**
 *  根据text字段排序
 *
 *  @param array 数据源
 *  @param text  排序字段
 *  @param desc  是否降序
 *
 *  @return 排列后的数据
 */
+ (NSArray*)sequenceArray:(NSArray*)array text:(NSString*)text desc:(BOOL)desc;

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
+ (NSArray*)packageArray:(NSArray*)fromArray text:(NSString*)text forArray:(NSArray*)toArray key:(NSString*)key;

/**
 *	@brief	mac地址
 *
 *	@return	返回地址
 */
+ (NSString *)macAddress;


+ (NSInteger)getFloatPointNumbers:(double)floatValue;
/**
 *  RGB颜色
 *
 *  @param alpha 透明度
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithR:(float)red G:(float)green B:(float)blue A:(float)alpha;
+ (UIColor *)colorWithR:(float)red G:(float)green B:(float)blue;
/**
 *  返回字号
 *
 *  @param size 大小
 *
 *  @return 返回字号
 */
+ (UIFont *)fontOfSize:(int)size;


/**
 *  依据整型数排序数组
 *
 *  @param sourceArray 原始顺序数组（内部是字典）
 *  @param key         排序依据key
 *
 *  @return 按照升序排序
 */
+ (NSArray *)sortedDataWithArray:(NSArray *)sourceArray
                   keyForCompare:(NSString *)key;


/** 判断名称是否合法 */
+ (BOOL)isNameValid:(NSString *)name;


/* 重写label */
+ (UILabel*)createLabelWithTitle:(NSString*)title fontSize:(UIFont *)fontSize textColor:(UIColor *)color;

/* 重写button */
+ (UIButton*)createButtonWithTitle:(NSString*)title image:(NSString *)name fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor target:(id)target sel:(SEL)sel;

/* 重写textField */
+ (UITextField *)creatTextFieldWithPlaceHolder:(NSString *)placeholder fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor delegate:(id<UITextFieldDelegate>)delegate;

@end
