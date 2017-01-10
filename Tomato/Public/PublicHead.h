//
//  PublicHead.h
//  UTeam
//
//  Created by qingshan on 15/5/9.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicHead : NSObject
{
    NSNumber * platform;  //客户端设备平台，1:IOS,2:Android
    NSString * clientVersion;//客户端版本号 如：1.0.0
    NSString * token;    //已登录用户的Token,用于验证用户登录状态，非空则用户已登录
    NSString * device;    //设备唯一表示
}

@property (nonatomic,strong)NSNumber * platform;  //客户端设备平台，1:IOS,2:Android
@property (nonatomic,strong)NSString * clientVersion;//客户端版本号 如：1.0.0
@property (nonatomic,strong)NSString * token;    //已登录用户的Token,用于验证用户登录状态，非空则用户已登录
@property (nonatomic,strong)NSString * device;    //设备唯一表示

@end
