//
//  UIImage.m
//  BMProject
//
//  Created by yndfcd on 15/10/20.
//  Copyright © 2015年 MengHuan. All rights reserved.
//

#import "UIImage+BMExtension.h"

@implementation UIImage(BMExtension)

+(UIImage*)screenShot
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = window.bounds;
    CGSize size;
    size.width = CGRectGetWidth(rect);
    size.height = CGRectGetHeight(rect);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage*)imageWithImage:(UIImage*)image andCropRect:(CGRect)rect
{
    
    return [[UIImage alloc] initWithImage:image andCropRect:rect];
}

+(UIImage*)imageWithImage:(UIImage*)image andScale:(CGSize)scale
{
    return [[UIImage alloc] initWithImage:image andScale:scale];
}

-(id)initWithImage:(UIImage*)image andCropRect:(CGRect)rect
{
    CGImageRef ref = image.CGImage;
    CGImageRef imageRect = CGImageCreateWithImageInRect(ref, rect);
    
    self = [self initWithCGImage:imageRect];
    
    CGImageRelease(imageRect);
    
    return self;
}

-(id)initWithImage:(UIImage *)image andScale:(CGSize)scale
{
    CGSize newSize = {image.size.width*scale.width, image.size.height*scale.height};
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self = [self initWithCGImage:newImage.CGImage];
    
    return self;
}

@end
