//
//  UserInfo.h
//  BMProject
//
//  Created by 赵利杰 on 15/9/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserDidLoginNotification     @"UserDidLoginNotification"
#define UserDidLogoutNotification    @"UserDidLogoutNotification"
#define UserDidChangeInfoNotification   @"UserDidChangeInfoNotification"

enum PasswordType{ Undefined = -1, UserNameAndPassword = 0, UserNameAndRandomCode};

@interface UserInfo : NSObject
@property(nonatomic,assign) int passwordType;
@property(nonatomic,strong) NSString* userName;
@property(nonatomic,strong) NSString* password;
@property(nonatomic,strong) NSString* code;
@property(nonatomic, assign) BOOL haveLoggedIn;//是否已经登录

+ (instancetype)currentUser;


//用户名注册
- (void)registerWithUserName:(NSString *)userName andPassword:(NSString *)password;

//邮箱注册
- (void)registerWithEmail:(NSString *)userName andPassword:(NSString *)password;

//手机号注册
- (void)registerWithPhoneNum:(NSString *)phoneNum andPassword:(NSString *)password andCode:(NSString *)code;

//登录
- (void)login;

//用户名密码登录
- (void)loginWithUserName:(NSString *)userName andPassword:(NSString *)password;

//手机号验证码登录
- (void)loginWithTelephoneNumber:(NSString *)phone andCode:(NSString *)code;

//自动登录
- (BOOL)autoLogin;

//改变用户信息
- (void)updateProfile:(NSDictionary *)profile;

//注销
- (void)logout;


@end
