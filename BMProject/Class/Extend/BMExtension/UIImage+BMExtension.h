//
//  UIImage.h
//  BMProject
//
//  Created by yndfcd on 15/10/20.
//  Copyright © 2015年 MengHuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage(BMExtension)

+(UIImage*)screenShot;

+(UIImage*)imageWithImage:(UIImage*)image andCropRect:(CGRect)rect;

+(UIImage*)imageWithImage:(UIImage*)image andScale:(CGSize)scale;

-(id)initWithImage:(UIImage*)image andCropRect:(CGRect)rect;

-(id)initWithImage:(UIImage *)image andScale:(CGSize)scale;

@end
