//
//  JSNativeSDK.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/4.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "Data/BaseJSONData.h"
#import "Data/ChooseImageArgData.h"
#import "Data/UploadArgData.h"
#import "Data/ShowTabbarArgData.h"
#import "Data/ShareArgData.h"
#import "Data/OpenNewWebArgData.h"
#import "Data/NewsInfoArgData.h"
#import "Data/JumpTabbarArgData.h"
#import "Data/VersionData.h"
#import "Data/UploadData.h"
#import "Data/ChooseImageResultData.h"
#import "Data/ShowNavBarArgData.h"
#import "Data/LoginNotifyData.h"
#import "Data/CookieData.h"
#import "Data/GoBackData.h"
#import "Data/PayCompleteData.h"
#import "Data/SupportPayTypeData.h"
#import "PrintObject.h"
#import "CloseWindowData.h"
#import "H5PayData.h"


@protocol JSNativeExport <JSExport>
//选择图片
JSExportAs(chooseImage ,-(void)chooseImage:(NSString*)jsonData);
//debug标志位
JSExportAs(config, -(void)configJSSDK:(NSString*)jsonData);
//上传一张图片
//JSExportAs(uploadImage, -(NSString *)uploadImage:(NSString*)jsonData);
//显示/隐藏Tabbar
JSExportAs(showTabBar, -(void)showTabBar:(NSString*) jsonData);
//显示/隐藏Navbar
JSExportAs(showNavBar, -(void)showNavBar:(NSString*) jsonData);
//调用分享
JSExportAs(share, -(void)shareTo:(NSString*)jsonData);
//打开新的WebView
JSExportAs(openNewWebView, -(void)openNewWebView:(NSString*)jsonData);
//打开资讯页
JSExportAs(newsInfo, -(void)newsInfo:(NSString*)jsonData);
//跳转到Tabbar对应的地方
JSExportAs(jumpTabBar, -(void)jumpTabBar:(NSString*)jsonData);
//登录成功/失败通知
JSExportAs(loginNotify, -(void)loginNotify:(NSString*)jsonData);
//H5设置cookie给Native
JSExportAs(setCookie, -(void)setCookie:(NSString*)jsonData);
//检查版本
JSExportAs(updateVersion, -(void)updateVersion:(NSString*)jsonData);
//打开QR扫描
JSExportAs(openQR, -(void) openQR:(NSString*)jsonData);
//关闭页面
JSExportAs(closeWindow, -(void) closeWindow:(NSString*) jsonData);
//获取JSNative的版本号
JSExportAs(getJSSDKVersion, -(NSString*) getJSSDKVersion:(NSString*)jsonData);
//获取App版本
JSExportAs(getAppVersion, -(NSString*) getAppVersion:(NSString*)jsonData);
//返回上一级页面
JSExportAs(goBack, -(void)goBack:(NSString*)jsonData);
//返回到页面堆栈的根元素
JSExportAs(goBackToRoot, -(void)goBackToRoot:(NSString*)jsonData);
//调用native拨号
JSExportAs(dialNumber, -(void)dialNumber:(NSString*)jsonData);
//H5调用native支付功能
JSExportAs(h5Pay, -(void)h5Pay:(NSString*)jsonData);

JSExportAs(supportPayType, -(NSString*) supportPayType:(NSString* )jsonData);

//通知js，页面已经加载完成
-(void) webviewIsLoaded;

//选择图片后的回调函数
-(void)chooseImageComplate:(ChooseImageResultData *) chooiceResult;
//H5支付功能回调函数
-(void)payComplete:(PayCompleteData *) payComplete;

-(NSDictionary *) getJsonDicitionary:(NSString*) jsonData;

-(NSString*) objToJson:(BaseJSONData*)baseData data:(NSObject*)data success:(BOOL)success errMsg:(NSString*)errMsg;

-(NSString*) objToJson:(BaseJSONData*)baseData data:(NSObject*)data success:(BOOL)success errMsg:(NSString*)errMsg
             token:(NSString*)token callbackName:(NSString*) callbackName;
@end

@interface JSNativeSDK : NSObject<JSNativeExport>

-(id)initWithWebView:(UIWebView*) uiWebView;

@property (weak,nonatomic) UIWebView * webView;

@property (strong, nonatomic) JSContext *context;

@property (copy) void(^exceptionHandler)(JSContext *context, JSValue *exception);

@property (copy) void(^chooseImageHandler)(ChooseImageArgData * chooiceData);

@property (copy) void (^checkVerHandler)();

@property (copy) void (^openQRScanHandler)();

@property (copy) void (^closeHandler)(CloseWindowData * closeWindow);

@property (copy) void (^showTabbarHandler)(ShowTabbarArgData* showTabbar);

@property (copy) void (^showNavbarHandler)(ShowNavBarArgData* showNavbar);

@property (copy) void (^shareHandler)(ShareArgData * shareArgData);

@property (copy) void (^openNewWebViewHandler)(OpenNewWebArgData * openNewArg);

@property (copy) void (^newsInfoHandler)(NewsInfoArgData * newsInfoArg);

@property (copy) void (^jumpTabBarHandler)(JumpTabbarArgData* jumpTabbarArg);

@property (copy) void (^loginNotifyHandler)(LoginNotifyData *loginArg);

@property (copy) void (^cookieNotifyHandler)(CookieData *cookie);

@property (copy) void (^goBackHandler)(GoBackData* goBack);

@property (copy) void (^goBackToRootHandler)();

@property (copy) void (^h5payHandler)(H5PayArgData *argData);

@property (copy) int (^supportPayTypeHandler)();

@property (nonatomic)BOOL debug;

@property (nonatomic,strong) NSString* jsonData;

@property (nonatomic,strong)H5PayData *payData;

@end
