//
//  JSNativeSDK.m
//  JSNativeSDK
//
//  Created by Mtime on 15/11/4.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import "JSNativeSDK.h"

@implementation JSNativeSDK
@synthesize webView,context,exceptionHandler,chooseImageHandler,
            debug,checkVerHandler,openQRScanHandler,closeHandler,
            showTabbarHandler,shareHandler,showNavbarHandler,
            openNewWebViewHandler,newsInfoHandler,jumpTabBarHandler,
            loginNotifyHandler,cookieNotifyHandler,goBackHandler,goBackToRootHandler,
            payData,h5payHandler,supportPayTypeHandler;

-(id)initWithWebView:(UIWebView*) uiWebView
{
    if (self=[super init])
    {
        self.webView = uiWebView;
        self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.context[@"mtime"] = self;
    }
    return self;
}
#pragma mark 开启调试模式,输出日志
-(void)configJSSDK:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        NSString* isDebugStr = [paramers objectForKey:@"debug"];
        self.debug = [isDebugStr boolValue];
    }
}
#pragma mark 获取JSSDK版本
-(NSString*) getJSSDKVersion:(NSString*)jsonData
{
    BaseJSONData * baseData = [[BaseJSONData alloc]init];
    VersionData* verData = [[VersionData alloc]init];
//    NSString * ver = [MTBTool getAppVersion];
    NSString * ver =@"1.0.0";
    verData.version=ver;
    return [self objToJson:baseData data:verData success:YES errMsg:nil];
}

#pragma mark 获取App版本
-(NSString*) getAppVersion:(NSString*)jsonData
{
    BaseJSONData * baseData = [[BaseJSONData alloc]init];
    VersionData* verData = [[VersionData alloc]init];
    NSString * ver = [NSString stringWithFormat:@"v%@",
                      [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    verData.version=ver;
    return [self objToJson:baseData data:verData success:YES errMsg:nil];
}
#pragma mark 打开二维码扫描
-(void) openQR:(NSString*)jsonData
{
    if (openQRScanHandler!=nil)
    {
        /// 放到 主线程 中实现
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           openQRScanHandler();
                       });
    }
}
#pragma mark 关闭页面
-(void) closeWindow:(NSString*) jsonData
{
    CloseWindowData * data =  [[CloseWindowData alloc]init];
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        NSString* refreshWindowStr = [paramers objectForKey:@"refreshWindow"];
        if (refreshWindowStr!=nil)
        {
            data.refreshWindow = [refreshWindowStr boolValue];
        }
        if (closeHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               closeHandler(data);
                           });
        }
    }
}
#pragma mark 检查版本更新
-(void) updateVersion:(NSString*)jsonData
{
    if (checkVerHandler!=nil)
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           checkVerHandler();
                       });
    }
}

#pragma mark 选择图片
-(void)chooseImage:(NSString*)jsonData
{
    //解析json字符串,生成对象
    self.jsonData = jsonData;
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    ChooseImageArgData* chooseImageArgData = [[ChooseImageArgData alloc]init];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        NSString* countStr = [paramers objectForKey:@"count"] ;
        NSString* uploadTypeStr = [paramers objectForKey:@"uploadType"];
        NSString* imageFileTypeStr = [paramers objectForKey:@"imageFileType"];
        if (chooseImageHandler != nil)
        {
            if (countStr!=nil)
            {
                chooseImageArgData.count=[countStr intValue];
            }
            if (uploadTypeStr!=nil)
            {
                chooseImageArgData.uploadType =[uploadTypeStr intValue];
            }
            chooseImageArgData.imageFileType = imageFileTypeStr;
            
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               chooseImageHandler(chooseImageArgData);
                           });
        }
    }
}
#pragma mark 选择图片的回调函数
-(void)chooseImageComplate:(ChooseImageResultData *) chooseResult
{
    if (self.jsonData!=nil)
    {
        NSDictionary *jsonDictionary = [self getJsonDicitionary:self.jsonData];
        BaseJSONData * baseData = [[BaseJSONData alloc]init];
        NSString* tokenStr = [jsonDictionary objectForKey:@"tokenKey"];
        NSString* callbackNameStr = [jsonDictionary objectForKey:@"callbackName"];
        NSString* result = [self objToJson:baseData data:chooseResult success:YES errMsg:nil token:tokenStr callbackName:callbackNameStr];
        if (self.webView!=nil)
        {
            //回调函数格式为函数名和参数,参数为String,格式为Json
            NSString *jsMethod  = [NSString stringWithFormat:@"%@(%@);", callbackNameStr,result];
            [webView stringByEvaluatingJavaScriptFromString:jsMethod];
        }
    }
}

#pragma mark 显示/隐藏Tabbar
-(void)showTabBar:(NSString*) jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        ShowTabbarArgData * tabbarArgData =[[ShowTabbarArgData alloc]init];
        NSString* showTabBarStr = [paramers objectForKey:@"isShowTabBar"];
        if (showTabBarStr!=nil)
        {
            tabbarArgData.isShowTabBar = [showTabBarStr boolValue];
        }
        if (showTabbarHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               showTabbarHandler(tabbarArgData);
                           });
        }
    }
}

#pragma mark 登录成功/失败通知
-(void)loginNotify:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        LoginNotifyData *loginNotify = [[LoginNotifyData alloc]init];
        loginNotify.userName = [paramers objectForKey:@"userName"];
        loginNotify.loginToken = [paramers objectForKey:@"loginToken"];
        loginNotify.isLogin = [[paramers objectForKey:@"isLogin"] boolValue];
        if (loginNotifyHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               loginNotifyHandler(loginNotify);
                           });
        }
    }
}

#pragma mark 传递Cookie给Native
-(void)setCookie:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        CookieData * cookieData =[[CookieData alloc]init];
        cookieData.cookie = [paramers objectForKey:@"cookie"];
        if (cookieNotifyHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               cookieNotifyHandler(cookieData);
                           });
        }
    }
}
#pragma mark 当页面加载完成的时候调用h5，通知页面已经加载完成
-(void) webviewIsLoaded
{
    if (webView!=nil)
    {
        [webView stringByEvaluatingJavaScriptFromString:@"window.mtimeJSSDKReady && window.mtimeJSSDKReady();"];
    }
}

#pragma mark 显示/隐藏Navbar
-(void)showNavBar:(NSString*) jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        ShowNavBarArgData * navbarArgData = [[ShowNavBarArgData alloc]init];
        NSString *showNavBarStr =  [paramers objectForKey:@"isShowNavBar"];
        if (showNavBarStr!=nil)
        {
            navbarArgData.isShowNavBar=[showNavBarStr boolValue];
        }
        if (showNavbarHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               showNavbarHandler(navbarArgData);
                           });
        }
    }
}
#pragma mark 分享
-(void)shareTo:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        ShareArgData * shareArgs = [[ShareArgData alloc]init];
        shareArgs.shareTitle = [paramers objectForKey:@"shareTitle"];
        shareArgs.shareUrl = [paramers objectForKey:@"shareUrl"];
        shareArgs.shareMessage = [paramers objectForKey:@"shareMessage"];
        shareArgs.shareImageUrl = [paramers objectForKey:@"shareImageUrl"];
        shareArgs.shareMessageWeiBo = [paramers objectForKey:@"shareMessageWeiBo"];
        shareArgs.shareMessageQQ = [paramers objectForKey:@"shareMessageQQ"];
        shareArgs.shareVideoUrl = [paramers objectForKey:@"shareVideoUrl"];
        if (shareHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               shareHandler(shareArgs);
                           });
        }
    }
}

#pragma mark 返回上一页
-(void)goBack:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        GoBackData * goBack = [[GoBackData alloc]init];
        goBack.isCloseWindow =  [[paramers objectForKey:@"isCloseWindow"] boolValue];
        goBack.refreshWindow = [[paramers objectForKey:@"refreshWindow"] boolValue];
        if (goBackHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                goBackHandler(goBack);
            });
        }
    }
}

#pragma mark 打开新的分享页面
-(void)openNewWebView:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        OpenNewWebArgData *webArg = [[OpenNewWebArgData alloc]init];
        webArg.webUrl = [paramers objectForKey:@"newUrl"];
        webArg.isShowNavBar = [[paramers objectForKey:@"isShowNavBar"] boolValue];
        webArg.isRefreshWindow = [[paramers objectForKey:@"isRefreshWindow"] boolValue];
        if (openNewWebViewHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               openNewWebViewHandler(webArg);
                           });
        }
    }
}

#pragma mark 打开新闻页面
-(void)newsInfo:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        NSString* newsIdStr = [paramers objectForKey:@"newsId"];
        NewsInfoArgData * newsInfoData = [[NewsInfoArgData alloc]init];
        if (newsIdStr!=nil)
        {
            newsInfoData.newsId =  [newsIdStr intValue];
        }
        if (newsInfoHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               newsInfoHandler(newsInfoData);
                           });
        }
    }
}

#pragma mark 返回到根页面
-(void)goBackToRoot:(NSString*)jsonData
{
    if (goBackToRootHandler!=nil)
    {
        goBackToRootHandler();
    }
}

#pragma mark 跳转到Tab页面
-(void)jumpTabBar:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        NSString* tabBarIndexStr = [paramers objectForKey:@"tabBarName"];
        NSString* webUrlStr = [paramers objectForKey:@"newUrl"];
        JumpTabbarArgData* jumpData = [[JumpTabbarArgData alloc]init];
        if (tabBarIndexStr!=nil)
        {
            jumpData.tabBarName = tabBarIndexStr;
        }
        jumpData.webUrl = webUrlStr;
        jumpData.isClose = [[paramers objectForKey:@"isClose"] boolValue];
        if (jumpTabBarHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               jumpTabBarHandler(jumpData);
                           });
        }
    }
}

#pragma mark 调用natvie的拨号
-(void)dialNumber:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (paramers!=nil)
    {
        NSString  *phoneNum  = [paramers objectForKey:@"phoneNumber"];
        if (phoneNum!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               NSString *telNumber = [NSString stringWithFormat:@"telprompt://%@",phoneNum ];
                               NSURL * openUrl = [NSURL URLWithString:telNumber];
                               [[UIApplication sharedApplication] openURL:openUrl];
                           });
        }
    }
}

#pragma mark H5调用native支付方法
-(void)h5Pay:(NSString*)jsonData
{
    NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
    NSDictionary * paramers = [jsonDictionary objectForKey:@"businessParameters"];
    if (payData==nil)
    {
        payData = [[H5PayData alloc]init];
    }
    payData.tokenKey =  [jsonDictionary objectForKey:@"tokenKey"];
    payData.callbackName = [jsonDictionary objectForKey:@"callbackName"];
    
    if (paramers!=nil)
    {
        H5PayArgData *argData =  [[H5PayArgData alloc]init];
        int payType =  [[paramers objectForKey:@"payType"] intValue];
        argData.payType=payType;
        argData.orderString= [paramers objectForKey:@"orderString"];
        if (h5payHandler!=nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                                    h5payHandler(argData);
                           });
        }
    }
}


#pragma  mark H5支付回调方法
-(void)payComplete:(PayCompleteData *) payComplete
{
    BaseJSONData * baseData = [[BaseJSONData alloc]init];
    NSString* result = nil;
    if (payComplete!=nil&&payData!=nil)
    {
        payComplete.payType= payData.argData.payType;
        result = [self objToJson:baseData data:payComplete success:YES errMsg:nil token:payData.tokenKey callbackName:payData.callbackName];
    }
    else
    {
        result = [self objToJson:baseData data:payComplete success:NO errMsg:nil token:payData.tokenKey callbackName:payData.callbackName];
    }
    if (self.webView!=nil&&payData.callbackName!=nil)
    {
        //回调函数格式为函数名和参数,参数为String,格式为Json
        NSString *jsMethod  = [NSString stringWithFormat:@"%@(%@);", payData.callbackName,result];
        [webView stringByEvaluatingJavaScriptFromString:jsMethod];
    }
}

#pragma  mark 获取native支持的支付类型
-(NSString*) supportPayType:(NSString* )jsonData
{
     BaseJSONData * baseData = [[BaseJSONData alloc]init];
    if (jsonData!=nil)
    {
        NSDictionary *jsonDictionary = [self getJsonDicitionary:jsonData];
        baseData.tokenKey = [jsonDictionary objectForKey:@"tokenKey"];
        baseData.callbackName= [jsonDictionary objectForKey:@"callbackName"];
    }
   
    SupportPayTypeData * supportData = [[SupportPayTypeData alloc]init];
    if (supportPayTypeHandler!=nil)
    {
        supportData.supportPayType = supportPayTypeHandler();//0 为没有支付，1.微信，2.支付宝，后续可以扩展
    }
    baseData.success=true;
    baseData.data = supportData;
    
    NSData *jsonResultData =[PrintObject getJSON:baseData options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonResultData encoding:NSUTF8StringEncoding];
}

#pragma mark 解析json
-(NSDictionary *) getJsonDicitionary:(NSString*) jsonData
{
    NSError *error;
    NSData* json = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:&error];
    return jsonDictionary;
}

#pragma mark 将对象转成json
-(NSString*) objToJson:(BaseJSONData*)baseData data:(NSObject*)data success:(BOOL)success errMsg:(NSString*)errMsg token:(NSString*)token callbackName:(NSString*) callbackName
{
    baseData.tokenKey = token;
    baseData.callbackName = callbackName;
    return [self objToJson:baseData data:data success:success errMsg:errMsg];
}
#pragma mark 将对象转成json
-(NSString*) objToJson:(BaseJSONData*)baseData data:(NSObject*)data success:(BOOL)success errMsg:(NSString*)errMsg
{
    baseData.errMsg=errMsg;
    baseData.success=success;
    baseData.data=data;
    NSData *jsonResultData =[PrintObject getJSON:baseData options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc]initWithData:jsonResultData encoding:NSUTF8StringEncoding];
}

@end
