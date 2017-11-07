//
//  UserInfo.m
//  BMProject
//
//  Created by 赵利杰 on 15/9/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "UserInfo.h"
#import "AFNetworking.h"
#import "NSString+BMExtension.h"
#import "MHLoginAndRegisterDefine.h"

static NSString *kUserInfoKey = @"kUserInfoKey";
@implementation UserInfo
+ (instancetype)currentUser
{
    static UserInfo *sharedUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    sharedUser = [[[self class] alloc] init];
    });
    return sharedUser;
}

-(id)init {
    if (self = [super init]) {
        _passwordType = Undefined;
        _haveLoggedIn = NO;
    }
    return self;
}

//用户名注册
- (void)registerWithUserName:(NSString *)userName andPassword:(NSString *)password {
#ifdef USEPHPAPI
    NSDictionary *parameters = @{@"app":@"Cas",@"class":@"Signup",@"sign":[SIGN_STRING(@"Cas", @"Signup") md5String],@"simple":@"1", @"username":userName, @"password" : password,@"repassword":password};
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
            [manager POST:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dic = (NSDictionary *)responseObject;
                NSLog(@"JSON:%@",responseObject);
                NSString *status = responseObject[@"status"];
                if ([status intValue] == 0) {
                     NSLog(@"%@",responseObject[@"msg"]);
                } else {
                    NSString *message = [dic objectForKey:@"msg"];
                    UIALERTVIEW(message);
                }
            }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      NSLog(@"Error:%@",error);
                  }];
#else
        NSDictionary *dic = @{@"simple":@"1", @"username":userName, @"password" : password,@"repassword":password, @"code":@""};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:[NSString stringWithFormat:@"%@signup",JAVA_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"JSON:%@",responseObject);
            NSString *status = responseObject[@"status"];
            if ([status intValue] == 0) {
                 NSLog(@"%@",responseObject[@"msg"]);
            } else {
                NSString *message = [dic objectForKey:@"msg"];
                UIALERTVIEW(message);
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
#endif
}

//邮箱注册
- (void)registerWithEmail:(NSString *)userName andPassword:(NSString *)password {
#ifdef USEPHPAPI
    NSDictionary *parameters = @{@"app":@"Cas",@"class":@"Signup",@"sign":[SIGN_STRING(@"Cas", @"Signup") md5String],@"simple":@"9", @"username":userName, @"password" : password,@"repassword":password};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
    [manager POST:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSLog(@"JSON:%@",responseObject);
        NSString *status = responseObject[@"status"];
        if ([status intValue] == 0) {
            NSLog(@"%@",responseObject[@"msg"]);
        } else {
            NSString *message = [dic objectForKey:@"msg"];
            UIALERTVIEW(message);
        }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Error:%@",error);
          }];
#else
        NSDictionary *dic = @{@"simple":@"9", @"username":userName, @"password":password, @"repassword":password , @"code":@""};
        NSLog(@"%@",dic);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:[NSString stringWithFormat:@"%@signup",JAVA_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"JSON:%@",responseObject);
            NSString *status = responseObject[@"status"];
            if ([status intValue] == 0) {
                 NSLog(@"%@",responseObject[@"msg"]);
            } else {
                NSString *message = [dic objectForKey:@"msg"];
                UIALERTVIEW(message);
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
#endif
}

//手机号注册
- (void)registerWithPhoneNum:(NSString *)phoneNum andPassword:(NSString *)password  andCode:(NSString *)code {
#ifdef USEPHPAPI
    NSDictionary *parameters = @{@"app":@"Cas",@"class":@"Signup",@"sign":[SIGN_STRING(@"Cas", @"Signup") md5String],@"simple":@"2", @"username":phoneNum, @"password" : password,@"code":code};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON:%@",responseObject);
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
#else
        NSDictionary *dic = @{@"simple":@"2", @"username":phoneNum, @"password":password, @"repassword" : password, @"code":code};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:[NSString stringWithFormat:@"%@signup",JAVA_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSLog(@"JSON:%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
#endif
}
//用户名加密码登录
- (void)loginWithUserName:(NSString *)userName andPassword:(NSString*)password
{
    _passwordType = UserNameAndPassword;
#ifdef USEPHPAPI
    NSDictionary *parameters = @{@"app":@"Cas",@"class":@"Login",@"sign":[SIGN_STRING(@"Cas", @"Login") md5String], @"username":userName, @"password" : password};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"JSON:%@",responseObject);
            self.haveLoggedIn = YES;
            NSString *status = responseObject[@"status"];
            if ([status intValue] == 0) {
                _haveLoggedIn = YES;
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:self];
            } else {
                NSString *message = [dic objectForKey:@"msg"];
                UIALERTVIEW(message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error:%@",error);
        }];
#else
        NSDictionary *dic = @{ @"username":userName, @"password":password};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:[NSString stringWithFormat:@"%@login",JAVA_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"JSON:%@",responseObject);
            NSString *status = responseObject[@"status"];
            if ([status intValue] == 0) {
                _haveLoggedIn = YES;
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:self];
            } else {
                NSString *message = [dic objectForKey:@"msg"];
                UIALERTVIEW(message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
#endif
}

//手机号加验证码登录
- (void)loginWithTelephoneNumber:(NSString *)phone andCode:(NSString *)code {
    _passwordType = UserNameAndRandomCode;
#ifdef USEPHPAPI
    NSDictionary *parameters = @{@"app":@"Cas",@"class":@"Login",@"sign":[SIGN_STRING(@"Cas", @"Login") md5String],@"username":phone, @"code" : code};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:BASE_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSLog(@"JSON:%@",responseObject);
            NSString *status = responseObject[@"status"];
            if ([status intValue] == 0) {
                _haveLoggedIn = YES;
                [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:self];
            } else {
                NSString *message = [dic objectForKey:@"msg"];
                UIALERTVIEW(message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error:%@",error);
              }];
#else
        NSDictionary *dic = @{@"username":phone, @"password":@"", @"code":code};
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", nil];
        [manager POST:[NSString stringWithFormat:@"%@login",JAVA_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON:%@",responseObject);
            NSDictionary *dic = (NSDictionary *)responseObject;
            NSString *status = responseObject[@"status"];
            if ([status intValue] == 0) {
                _haveLoggedIn = YES;
                [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"username"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLoginNotification object:self];
            } else {
                NSString *message = [dic objectForKey:@"msg"];
                UIALERTVIEW(message);
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@",error);
        }];
#endif
}

//登录
-(void)login {
    if (_passwordType == UserNameAndPassword) {
        [[UserInfo currentUser]loginWithUserName:_userName andPassword:_password];
    } else if(_passwordType == UserNameAndRandomCode) {
        [[UserInfo currentUser]loginWithTelephoneNumber:_userName andCode:_code];
    }
}

//自动登录
- (BOOL)autoLogin {
//    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"tokenid"]) {
//        
//    }
    return NO;
}

//改变用户信息操作
- (void)updateProfile:(NSDictionary *)profile {
    
}

//注销
- (void)logout {
   
}

@end
