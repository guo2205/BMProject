//
//  CodeScanVC.m
//  FamilyCircle
//

//

#import "CodeScanVC.h"

//#import "SmjgedViewController.h"

#import "DurgNameView.h"

@interface CodeScanVC ()<UIAlertViewDelegate,UIActionSheetDelegate,DurgNameDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

    NSMutableArray *_dataArray;
    UIImageView * imageView;
    
}

@property (nonatomic, strong) DurgNameView * durgNameView;

@end

@implementation CodeScanVC

- (DurgNameView *)durgNameView {
    if (_durgNameView == nil) {
        _durgNameView = [[DurgNameView alloc] init];
        _durgNameView.delegate = self;
    }
    return _durgNameView;
    
}

- (void)returnDurgNamecode:(NSString *)code {
    
    [_session stopRunning];
    [self sweepResult:code];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 背景图片
    [self.navigationController.navigationBar setBackgroundImage:image_color(color_rgb(249,249,249)) forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"Arial" size:17.0f], NSFontAttributeName,nil]];
    
    
    [_session startRunning];


    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



-(void)choiceXc{

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    // 设置挑选出的图片是否可编辑
    picker.allowsEditing = NO;
    
    [self presentViewController:picker animated:YES completion:nil];

}

- (void)viewDidLoad{
    [super viewDidLoad];
//    [MobClick event:@"QRCode"];
    self.navigationItem.title = @"扫描二维码";
    
   UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
   leftButton.frame = CGRectMake(15, 0, 24, 24);
   [leftButton setImage:[UIImage imageNamed:@"backnew"] forState:UIControlStateNormal];
   [leftButton addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
   UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
   self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *leftButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton2.frame = CGRectMake(-15, 0, 60, 24);
    [leftButton2 setTitle:@"我的相册" forState:UIControlStateNormal];
    [leftButton2.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftButton2 setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
    [leftButton2 addTarget:self action:@selector(choiceXc) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton2];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    _dddssaDic = [[NSDictionary alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"click" ofType:@"mp3"];
//    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);

    eheeeedd = 0;
    _dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    

    bgImage=[[UIImageView alloc]init];
    bgImage.userInteractionEnabled=YES;
    bgImage.frame=CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT);
    bgImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    bgImage.alpha = 0.8;
    [self.view addSubview:bgImage];

    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake((DEF_SCREEN_WIDTH-295)/2, 130-50, 295, 295)];
    imageView.clipsToBounds = YES;
    imageView.image = [UIImage imageNamed:@"bluesaomiaokuang"];
    [bgImage addSubview:imageView];
    
    labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake((DEF_SCREEN_WIDTH-278)/2, imageView.bottom + 10, 278, 70)];
    labIntroudction.numberOfLines=3;
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.textAlignment = 1;
    [labIntroudction setFont:[UIFont systemFontOfSize:13]];
    labIntroudction.text= @"将二维码放入框中，将自动扫描\n\n双击下放区域退出扫描";

    bgImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    singleTapGesture.numberOfTapsRequired =1; //点击次数
    singleTapGesture.numberOfTouchesRequired  =2;//手指指数
    [bgImage addGestureRecognizer:singleTapGesture];
    
    
    upOrdown = NO;
    num =0;
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(20, -208, 235, 10)];
    _line.image = [UIImage imageNamed:@"erweimazou"];
    [imageView addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.004 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
 
//    [self.navigationController.view addSubview:self.durgNameView];
    [self setupCamera];
}
//两个手势分别响应的方法
-(void)handleSingleTap:(UIGestureRecognizer *)sender{
    //chooseNum为手势响应的view的tag值
    [self dismissViewControllerAnimated:YES completion:nil];
}
//
-(void)gojiaochengclick{

}

//扫描动画
-(void)animation1
{
//    if (upOrdown == NO) {
//        num ++;
//        _line.frame = CGRectMake((KWIDTH-220)/2, 110+2*num, 220, 2);
//        if (2*num == 260) {
//            upOrdown = YES;
//        }
//    }
//    else {
//        num --;
//        _line.frame = CGRectMake((KWIDTH-220)/2, 110+2*num, 220, 2);
//        if (num == 0) {
//            upOrdown = NO;
//        }
//    }
    
    eheeeedd++;
    _line.frame = CGRectMake(20, -205+eheeeedd, 235, 10);
    
    if (eheeeedd>475) {
        eheeeedd=0;
    }
    

}

-(void)backTo{
    [timer invalidate];
    
    // 停止会话
    [_session stopRunning];
    _session = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}

- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
        UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"" message:@"您没有授权摄像头的使用权限" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self backTo];
        }];
        [alertC addAction:action];
        return;
    }
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    
    CGSize size = self.view.bounds.size;
    
//    (KWIDTH-265)/2, 110, 265, 265)
    CGRect cropRect = CGRectMake((DEF_SCREEN_WIDTH-295)/2, 100, 300, 300);
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.; //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        _output.rectOfInterest = CGRectMake((cropRect.origin.y + fixPadding)/fixHeight,
                                            cropRect.origin.x/size.width,
                                            cropRect.size.height/fixHeight,
                                            cropRect.size.width/size.width);
        
//        NSLog(@"%f-=-=%f-=-=-=%f-=-=-=%f",(cropRect.origin.y + fixPadding)/fixHeight,
//              cropRect.origin.x/size.width,
//              cropRect.size.height/fixHeight,
//              cropRect.size.width/size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        _output.rectOfInterest = CGRectMake(cropRect.origin.y/size.height,
                                            (cropRect.origin.x + fixPadding)/fixWidth,
                                            cropRect.size.height/size.height,
                                            cropRect.size.width/fixWidth);
        
//        NSLog(@"%f0000000000%f0000000%f-=-=-=%f",cropRect.origin.y/size.height,
//              (cropRect.origin.x + fixPadding)/fixWidth,
//              cropRect.size.height/size.height,
//              cropRect.size.width/fixWidth);
    }
    
   
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeQRCode,nil];//@[AVMetadataObjectTypeQRCode];
    
//    _output.rectOfInterest = CGRectMake(0, 0, 265, 265);
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.bounds;
//    _preview.frame =CGRectMake((KWIDTH-265)/2,100,265,260);
    [bgImage.layer insertSublayer:_preview atIndex:0];

    [self setOverView];
    
    // Start
    [_session startRunning];
}

#pragma mark - 添加模糊效果
- (void)setOverView {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    CGFloat x = CGRectGetMinX(imageView.frame);
    CGFloat y = CGRectGetMinY(imageView.frame);
    CGFloat w = CGRectGetWidth(imageView.frame);
    CGFloat h = CGRectGetHeight(imageView.frame);
    
    [self creatView:CGRectMake(0, 0, width, y)];
    [self creatView:CGRectMake(0, y, x, h)];
    [self creatView:CGRectMake(0, y + h, width, height - y - h)];
    [self creatView:CGRectMake(x + w, y, width - x - w, h)];
    
    [bgImage addSubview:labIntroudction];
}

- (void)creatView:(CGRect)rect {
    CGFloat alpha = 0.6;
    UIColor *backColor = [UIColor blackColor];
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    view.alpha = alpha;
    [bgImage addSubview:view ];

}

- (void) rightTopButtonClick:(UIButton *)sender {
    UIActionSheet * sheet;
    
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
//    if (device.torchMode == AVCaptureTorchModeOn) {
    
//        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"扫描教程", @"输入条形码", nil];
//        sheet.tag = 200;
//        
//    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"扫描教程", @"输入条形码", nil];
        sheet.tag = 200;
//    }
    
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (actionSheet.tag == 200) {
        switch (buttonIndex) {
            case 0:
            {
                [self gojiaochengclick];
                break;
            }
            case 1:
            {
                [self performSelector:@selector(showDurgViewView) withObject:nil afterDelay:0.5];
                
                
                break;
            }
//            case 2:
//            {
//                [self toggleFlashlight];
//                break;
//            }

            default:
            {
                break;
            }
        }
    }
    
    [actionSheet removeFromSuperview];
}

- (void) showDurgViewView {
    [self.durgNameView showDurgView];
}

-(void)playSound{
    
    AudioServicesPlaySystemSound (soundID);
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    [self playSound];

    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
//        if (stringValue.length == 0) {
        
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:stringValue delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alertView.tag = 100;
//            [alertView show];
            [_session stopRunning];
        [self smartURLForString:stringValue];
        
        
        
//        } else {
//            [_session stopRunning];
//            [self sweepResult:stringValue];
////            self.numBlock(stringValue);
////            [self.navigationController popViewControllerAnimated:YES];
//        }
    }
}

- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
//            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:trimmedStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            alertView.tag = 100;
//            [alertView show];
            [self dismissViewControllerAnimated:YES completion:nil];
            self.oneParamsBlock(str);
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                
                result = [NSURL URLWithString:trimmedStr];
                NSLog(@"哈哈哈");
                [self dismissViewControllerAnimated:YES completion:nil];
                self.oneParamsBlock(str);
                
//                SmjgedViewController *_smmed = [[SmjgedViewController alloc] init];
//                _smmed.urled = result;
//                [self.navigationController pushViewController:_smmed animated:YES];
                
            } else {
                result = [NSURL URLWithString:trimmedStr];
                self.quanjuUrl = result;
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"此链接会跳出app,可能会带来安全问题？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alertView.tag = 105;
                [alertView show];
                
            }
        }
    }
    
    return result;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (alertView.tag==100) {
//        [self backTo];
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
        if (buttonIndex==0) {
//            [[UIApplication sharedApplication] openURL:self.quanjuUrl];
//            [self backTo];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
        
//            [self backTo];
            [self dismissViewControllerAnimated:YES completion:nil];

        }
    
   
    }
    
    
}

-(void)loadDataedTwo:(NSString *)codedStr{


}

- (void) sweepResult:(NSString *)stringValue {
    switch (self.isFrom) {
        case ComeFrom_sy:
        {
            
            [self loadDataedTwo:stringValue];

            break;
        }
        case ComeFrom_yd:
        {
            [self loadData:stringValue];
            break;
        }
    }
}
-(void)loadData:(NSString *)codeStr{
  
}

#pragma mark 打开灯
- (void)toggleFlashlight
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device.torchMode == AVCaptureTorchModeOff)
    {
        
        // Create video output and add to current session
        AVCaptureVideoDataOutput *output = [[AVCaptureVideoDataOutput alloc] init];
        [_aVSession addOutput:output];
        
        // Start session configuration
        [_aVSession beginConfiguration];
        [device lockForConfiguration:nil];
        
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        [_aVSession commitConfiguration];
        
        [_aVSession startRunning];
    }
    else
    {
        
        [_aVSession beginConfiguration];
        [device lockForConfiguration:nil];
        
        // Set torch to on
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
        [_aVSession commitConfiguration];
        
        [_aVSession stopRunning];
    }
    
}

#pragma mark - 协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];


    //1. 初始化扫描仪，设置设别类型和识别质量
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];

    //2. 扫描获取的特征组
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (features.count<=0) {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"未能识别此二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.tag = 100;
        [alertView show];
    }else{
    //3. 获取扫描结果
        CIQRCodeFeature *feature = [features objectAtIndex:0];
        NSString *scannedResult = feature.messageString;
        
        [self smartURLForString:scannedResult];
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"" message:scannedResult delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        alertView.tag = 100;
//        [alertView show];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
