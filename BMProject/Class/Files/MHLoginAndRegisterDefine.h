//
//  MHLoginAndRegisterDefine.h
//  BMProject
//
//  Created by 赵利杰 on 15/10/13.
//  Copyright © 2015年 MengHuan. All rights reserved.
//

#ifndef MHLoginAndRegisterDefine_h
#define MHLoginAndRegisterDefine_h

//Java和PHP接口的判断,若后台为Java，把PHP给注释了
//#define USEPHPAPI

//是否已经登录
#define USER_SAVE_LOGIN  @"haveLoggedIn";

//警告框
#define UIALERTVIEW(message) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];\
[alert show]

//登录注册接口
//php接口
#ifdef USE_JAVA_API
#define BASE_URL @"http://172.51.96.109:8201/api"
#else
#define JAVA_URL @"http://172.51.97.111:8000/nodo/api/cas/"
#endif


#endif /* MHLoginAndRegisterDefine_h */
