//
//  JSNativeSDK.m
//  JSNativeSDK
//
//  Created by Mtime on 15/11/4.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import "JSNativeSDK.h"

@implementation JSNativeSDK
@synthesize webView, payWeChatHandler;

- (id)initWithWebView:(UIWebView *)uiWebView {
    if (self = [super init]) {
        self.webView = uiWebView;
        self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.context[@"uteam"] = self;
    }
    return self;
}

- (void)payWeChat:(NSString *)jsonData {
    if (payWeChatHandler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            payWeChatHandler(jsonData);
        });
    }
}

- (void)callH5:(NSString *)methodName args:(NSString *)json {
    if (self.webView != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调函数格式为函数名和参数,参数为String,格式为Json
            NSString *jsMethod = [NSString stringWithFormat:@"%@(%@);", methodName, json];
            [webView stringByEvaluatingJavaScriptFromString:jsMethod];
        });
    }
}

@end
