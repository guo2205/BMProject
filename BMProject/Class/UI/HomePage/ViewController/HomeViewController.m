//
//  HomeViewController.m
//  BMProject
//
//  Created by MengHuan on 15/4/19.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewController+Test.h"
#import "NSString+BMExtension.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CodeScanVC.h"

@interface HomeViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)JSContext *jsContext;
@property (nonatomic, strong)UIWebView *webview;

@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 接口请求，通常是写在这里
    // ...

    //开始测试
//    [self startSelectedGearTest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 构建界面
    [self uiHUD];
}

- (void)uiHUD
{
    // 1，背景图
    self.webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webview.delegate = self;
    [self.view addSubview:self.webview];
    self.webview.backgroundColor = [UIColor whiteColor];

    _webview.scrollView.bounces = NO;

    
//    // Do any additional setup after loading the view, typically from a nib.
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
//    //NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
//    NSURL *url = [NSURL fileURLWithPath:path];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
//    self.webview.delegate = self;
//    self.webview.backgroundColor = [UIColor redColor];
//    [self.view addSubview:self.webview];
//    [self.webview loadRequest:request];
    
    //    将html文件加入工程，
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//

//
//    [self.webview loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    //NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
    
    
    
    
    //        NSString* path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    //        NSURL* url = [NSURL fileURLWithPath:path];//[NSURL URLWithString:[NSString stringWithFormat:@"%@/p49.html",API_HOSTH5]]
    //        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    //        [self.webview loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    /*
         禁止弹出复制、粘贴功能
     */
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    self.webview.backgroundColor = [UIColor colorWithRed:0 green:154/255.0 blue:255/255.0 alpha:1];
    NSString *stringedd = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    NSLog(@"当前页面title：%@",stringedd);
    
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //        self.jsContext[@"saomiao"] = self;
    //        self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
    //            context.exception = exceptionValue;
    //            NSLog(@"异常信息：%@", exceptionValue);
    //        };
    __weak __typeof(self) _self = self;
    _self.jsContext[@"saomiao"] = ^(id obj) {
        CodeScanVC *vc = [[CodeScanVC alloc] init];
//        [_self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:nil];
        vc.oneParamsBlock = ^(NSString *str) {
            NSLog(@"传回来的值=%@",str);
            //传值到JS [self.webView stringByEvaluatingJavaScriptFromString:@”方法名(%@)",参数]];
            NSString *strCall = [_webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"result('%@')",str]];
            NSLog(@"JS返回值：%@",strCall);

        };
    };
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    NSLog(@"-->>%@",url.absoluteString);
    NSLog(@"-=-=-=-=-=-=-=%@",[url scheme]);
    NSLog(@"-=-=-=-=-=-=-=%@",[url query]);
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
