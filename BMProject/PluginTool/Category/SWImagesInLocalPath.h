//
//  SWImagesInLocalPath.h
//  BJSubway
//
//  Created by Ming on 16/1/8.
//  Copyright © 2016年 Ming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWImagesInLocalPath : NSObject

+ (SWImagesInLocalPath *)sharedInstance;
- (NSArray *)saveImagesToLocalTempDirectory:(NSArray *)images;

@end
