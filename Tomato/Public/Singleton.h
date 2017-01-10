//
//  Singleton.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/17.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>
#import "DataCentre.h"
#import "MAppHttp.h"

@class UIBaseViewController;
@interface Singleton : NSObject {
    MAppHttp *http;
}

@property (nonatomic,strong) UserInfo *user;//用户对象

/**
 *  Singleton对象
 *
 *  @return Singleton对象
 */
+(Singleton*)shareInstance;

/*
 desc:是否已登录
 */
-(BOOL)isLogin;

//保存登录信息
-(void)saveLoginInfo:(UserInfo*)info;

/*
 desc:清空用户数据
 */
- (void)clearUserData;

//网络监测
+ (BOOL) IsEnableWIFI;      //Wifi是否可用
+ (BOOL) IsEnable3G;        //3G网络是否可用
+ (BOOL) NetworkNotEnable;  //当前是否没有网络

//页面跳转
- (BOOL)jumpPage:(UIBaseViewController*)parentController jumpStr:(NSString*)jumpStr;

@end
