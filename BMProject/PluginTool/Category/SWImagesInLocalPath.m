//
//  SWImagesInLocalPath.m
//  BJSubway
//
//  Created by Ming on 16/1/8.
//  Copyright © 2016年 Ming. All rights reserved.
//

#import "SWImagesInLocalPath.h"
//#import "NSString+UUID.h"

@implementation SWImagesInLocalPath

+ (SWImagesInLocalPath *)sharedInstance
{
    static SWImagesInLocalPath *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [SWImagesInLocalPath new];
        [instance clearTempDirectory];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *tmpDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/TempUploadFiles/"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:tmpDirectory])
        {
            [fileManager createDirectoryAtPath:tmpDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return self;
}

- (NSArray *)saveImagesToLocalTempDirectory:(NSArray *)images
{
    NSString *tmpDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/TempUploadFiles"];
 
    NSMutableArray *dirs = [NSMutableArray array];
    
    for (UIImage *image in images)
    {
        NSString *imageName = [NSString stringWithFormat:@"temp_%d.jpg", arc4random()];
        
        NSString *imageFilePath = [NSString stringWithFormat:@"%@/%@", tmpDirectory, imageName];
        
        NSData *imgData = UIImageJPEGRepresentation(image, 1);
        if (!imgData)
        {
            imgData = UIImagePNGRepresentation(image);
        }
        
        [[NSFileManager defaultManager] createFileAtPath:imageFilePath contents:imgData attributes:nil];

        [dirs addObject:imageFilePath];
    }
    
    return [dirs copy];
}

- (void)clearTempDirectory
{
    NSString *tmpDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches/TempUploadFiles"];
    
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:tmpDirectory];
    NSString *fileName;
    while (fileName= [dirEnum nextObject]) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", tmpDirectory, fileName] error:nil];
    }
}

@end
