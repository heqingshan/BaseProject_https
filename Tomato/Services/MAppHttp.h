//
//  MAppHttp.h
//  MHTTPRequestTest
//
//  Created by HeQingshan on 15-05-05.
//  Copyright (c) 2015年 HeQingshan. All rights reserved.
//
/*此处需要修改*/
#import <UIKit/UIKit.h>
#import "IHttpRequest.h"
#import "HttpInfo.h"

#if TEST_APP

#define BASE_URL @"http://tapi.uteamclub.com" //测试环境

#else

#define BASE_URL @"http://mwa.uteamclub.com"  //正式地址

#endif

#define TIMEOUT_Seconds  35.f

@interface MAppHttpJson : AFHTTPResponseSerializer

@end


@interface MAppHttp : IHttpRequest

-(void)requestAsynGet:(NSString*)methodName params:(NSDictionary*)dict type:(HTTPTYPE)type success:(SuccessBlock)success error:(FailureBlock)error;

-(void)requestAsynPost:(NSString*)methodName params:(NSDictionary*)dict type:(HTTPTYPE)type success:(SuccessBlock)success error:(FailureBlock)error;

@end





























