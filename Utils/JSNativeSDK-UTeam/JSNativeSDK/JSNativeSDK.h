//
//  JSNativeSDK.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/4.
//  Copyright © 2015年 Mtime. All rights reserved.
//

//#import "CloseWindowData.h"
//#import "Data/BaseJSONData.h"
//#import "Data/ChooseImageArgData.h"
//#import "Data/ChooseImageResultData.h"
//#import "Data/CookieData.h"
//#import "Data/GoBackData.h"
//#import "Data/JumpTabbarArgData.h"
//#import "Data/LoginNotifyData.h"
//#import "Data/NewsInfoArgData.h"
//#import "Data/OpenNewWebArgData.h"
//#import "Data/PayCompleteData.h"
//#import "Data/ShareArgData.h"
//#import "Data/ShowNavBarArgData.h"
//#import "Data/ShowTabbarArgData.h"
//#import "Data/SupportPayTypeData.h"
//#import "Data/UploadArgData.h"
//#import "Data/UploadData.h"
//#import "Data/VersionData.h"
//#import "H5PayData.h"
//#import "PrintObject.h"
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@protocol JSNativeExport <JSExport>
JSExportAs(payWeChat, -(void)payWeChat : (NSString *)jsonData);
@end

@interface JSNativeSDK : NSObject <JSNativeExport>
// UIWebView
- (id)initWithWebView:(UIWebView *)uiWebView;

- (void)callH5:(NSString *)methodName args:(NSString *)json;

@property (weak, nonatomic) UIWebView *webView;
@property (strong, nonatomic) JSContext *context;

@property (copy) void (^payWeChatHandler)(NSString *json);

@end
