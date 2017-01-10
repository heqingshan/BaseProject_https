//
//  ViewController.m
//  JSNativeSDK
//
//  Created by Mtime on 15/11/4.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import "ViewController.h"
#import "JSNativeSDK.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize webView,nativeSDK;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)onClick:(id)sender
{
    [nativeSDK webviewIsLoaded];
}

- (void)initWebView
{
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
//    NSString * filePath =@"http://192.168.20.166:18080/passport/registerSuccess";
//    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURL * url  = [NSURL URLWithString:@"http://192.168.216.96:8080/user/myaccount"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.view addSubview:webView];

    nativeSDK = [[JSNativeSDK alloc] initWithWebView:webView];

    nativeSDK.chooseImageHandler=^(ChooseImageArgData * args)
    {
        NSLog(@"chooice image handler called");
        ChooseImageResultData *resultData = [[ChooseImageResultData alloc]init];
//        NSMutableArray<ImageUploadResultData*> *data = [[NSMutableArray alloc]init];
        
        ImageUploadResultData * data = [[ImageUploadResultData alloc]init];
        data.uploadImage = @"http://www.baidu.com";
        data.uploadStatus =1;
        resultData.resultChooseImage = data;
        [nativeSDK chooseImageComplate:resultData];
    };
      
//    nativeSDK.uploadImageHandler = ^(UploadArgData * args)
//    {
//        NSString* result  =@"ID_OF_IMG";
//        //someting todo
//        return result;
//    };

    nativeSDK.showNavbarHandler = ^(ShowNavBarArgData* showNavbar)
    {
        
    };
    
    nativeSDK.showTabbarHandler =^(ShowTabbarArgData* showTabbar)
    {
        if(showTabbar.isShowTabBar==YES)
        {
            NSLog(@"YES");
        }
        else
        {
            NSLog(@"NO");
        }
    };
    
    nativeSDK.checkVerHandler =^()
    {
        NSLog(@"Check verson is called");
    };
    
    nativeSDK.shareHandler=^(ShareArgData * shareArgData)
    {
        NSLog(@"\r\nshareTitle = %@\r\n ,shareMessage = %@\r\n ,shareImageUrl = %@\r\n ,shareUrl = %@\r\n",shareArgData.shareTitle,shareArgData.shareMessage,shareArgData.shareImageUrl,shareArgData.shareUrl);
    };
    
    nativeSDK.openNewWebViewHandler = ^(OpenNewWebArgData * openNewArg)
    {
        NSLog(@"openNewArg.webUrl= %@",openNewArg.webUrl);
    };
    
    nativeSDK.newsInfoHandler =^(NewsInfoArgData * newsInfoArg)
    {
        NSLog(@"newsID = %d",newsInfoArg.newsId);
    };
    
    nativeSDK.jumpTabBarHandler = ^(JumpTabbarArgData* jumpTabbarArg)
    {
        NSLog(@"tabBarIndex = %@ , webUrl = %@",jumpTabbarArg.tabBarName,jumpTabbarArg.webUrl);
    };
    
    nativeSDK.closeHandler=^(CloseWindowData* data)
    {
        NSLog(@"close is called");
    };
    
    nativeSDK.loginNotifyHandler = ^(LoginNotifyData *loginArg)
    {
        
    };
    
    nativeSDK.cookieNotifyHandler=^(CookieData *cookie)
    {
    };
    nativeSDK.checkVerHandler=^()
    {
    };
    nativeSDK.closeHandler=^(CloseWindowData * closeWindow)
    {
    };
    nativeSDK.goBackHandler=^(GoBackData* goback)
    {
    };
    nativeSDK.goBackToRootHandler=^()
    {
    };
    nativeSDK.h5payHandler=^(H5PayArgData *argData)
    {
    };
    nativeSDK.supportPayTypeHandler=^()
    {
        return 1;//1.支持微信支付，2.支持支付宝
    };
    nativeSDK.openQRScanHandler = ^()
    {
        NSLog(@"openQRScan is called");
    };
    
    [webView stringByEvaluatingJavaScriptFromString:@"updateVersion({});"];
    
    [webView loadRequest:request];
    
}
-(void)dealloc
{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
