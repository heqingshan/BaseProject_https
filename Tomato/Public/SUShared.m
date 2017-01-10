//
//  SUShared.m
//  wyzc
//
//  Created by sunjun on 14-8-21.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//
//
//#import "SUShared.h"
//#import "WeiboSDK.h"
//
//@implementation SUShared
//
//+(void) regist_apiKey:(NSString *)strKey
//{
//    [ShareSDK registerApp:strKey
//          activePlatforms:@[
//                            @(SSDKPlatformTypeWechat),
//                            @(SSDKPlatformTypeQQ),
//                            @(SSDKPlatformTypeSinaWeibo)]
//    onImport:^(SSDKPlatformType platformType){
//        switch (platformType)
//        {
//            case SSDKPlatformTypeWechat:
//                [ShareSDKConnector connectWeChat:[WXApi class]];
//                break;
//            case SSDKPlatformTypeQQ:
//                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                break;
//            case SSDKPlatformTypeSinaWeibo:
//                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                break;
//            default:
//                break;
//        }
//    }
//    onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//        switch (platformType)
//        {
//            case SSDKPlatformTypeWechat:
//                [appInfo SSDKSetupWeChatByAppId:WechatAppId appSecret:WechatAppSecret];
//                break;
//            case SSDKPlatformTypeQQ:
//                [appInfo SSDKSetupQQByAppId:QQAppId
//                                     appKey:QQAppKey
//                                   authType:SSDKAuthTypeBoth];
//                break;
//            case SSDKPlatformTypeSinaWeibo:
//                [appInfo SSDKSetupSinaWeiboByAppKey:SinaWeiboAppKey
//                                          appSecret:SinaWeiboSecret
//                                        redirectUri:SinaWeiboRedirectUri
//                                           authType:SSDKAuthTypeBoth];
//                break;
//            default:
//                break;
//        }
//    }];
//}
//
//+(void)addShare_contentPlatform:(SSDKPlatformType)platform PosterItem:(ShareItem*)item
//{
//    if (item == nil) {
//        PromptBoxViewWithMessage *message = [[PromptBoxViewWithMessage alloc] init];
//        [message  showMessage:@"缺少分享参数"];
//        return;
//    }
//    NSMutableDictionary * shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:item.content
//                                     images:@[item.miniimgurl]
//                                        url:[NSURL URLWithString:item.contenturl]
//                                      title:item.title
//                                       type:item.shareType];
//    [ShareSDK share:platform
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
//    {
//        NSInteger status = 0;
//         switch (state) {
//             case SSDKResponseStateSuccess:
//             {
//                 /*
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                  */
//                 status = 1;
//                 break;
//             }
//             case SSDKResponseStateFail:
//             {
//                  /*
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                     message:[NSString stringWithFormat:@"%@", error]
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                  */
//                 status = 0;
//                 break;
//             }
//             case SSDKResponseStateCancel:
//             {
//                 /*
//                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                     message:nil
//                                                                    delegate:nil
//                                                           cancelButtonTitle:@"确定"
//                                                           otherButtonTitles:nil];
//                 [alertView show];
//                  */
//                 status = 0;
//                 break;
//             }
//             default:
//             {
//                 status = -1;
//                 break;
//             }
//         }
//        if (status >= 0) {
//            [[Singleton shareInstance] requestShareResult:status item:item block:^(BOOL flag, ShareItem *shareInfo) {
//                DLog(@"Share result: %@", (status == 1 ? @"成功" : @"失败"));
//            }];
//        }
//        else {
//            DLog(@"Share result: 未知错误");
//        }
//     }];
//}
//
//@end

