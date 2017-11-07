//
//  CodeScanVC.h
//  FamilyCircle
//
//  Created by spotatoman on 14-6-6.
//  Copyright (c) 2014年 Ecpalm. All rights reserved.
//

//#import "BaseViewController.h"
//#import "ZBarSDK.h"
//@interface CodeScanVC : BaseViewController<ZBarReaderViewDelegate>
//{
//    UIImageView *_moveImageView;
//    UIImageView *_bkImage;
//}
//@property (nonatomic,retain)ZBarReaderView *readerView;
//@end


#import "BaseViewController.h"
//#import "ZBarSDK.h"
#import<AudioToolbox/AudioToolbox.h> 

#import <AVFoundation/AVFoundation.h>

typedef void (^MyBlock)(NSString *detailStr);

typedef NS_ENUM(NSInteger, ComeFrom) {
    /**
     *  来自首页
     */
    ComeFrom_sy,
    /**
     *  来自异地报销
     */
    ComeFrom_yd
};

@interface CodeScanVC : BaseViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    UIImageView *_moveImageView;
    UIImageView *_bkImage;
    
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    
    UIImageView *bgImage;
    
    NSInteger eheeeedd;
    UILabel *labIntroudction;
    
    SystemSoundID soundID;
    
    NSDictionary *_dddssaDic;
    
    
}

@property (nonatomic,assign) ComeFrom isFrom;//来自与那个界面
@property (nonatomic, strong) NSURL *quanjuUrl;
//@property (nonatomic,strong) MyBlock numBlock;//传回回调的数值

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) AVCaptureSession *aVSession;
@property (nonatomic, retain) UIImageView * line;
@property (nonatomic, strong) NSString *yiyuanId;
@property (nonatomic, strong) NSString *canbaoCity;
//  带一个参数
@property (nonatomic, copy) void (^oneParamsBlock)(NSString *str);
@end

