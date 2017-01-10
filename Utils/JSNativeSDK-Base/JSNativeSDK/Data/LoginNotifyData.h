//
//  LoginNotifyData.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/13.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginNotifyData : NSObject
@property (nonatomic,strong)NSString *userName;
@property (nonatomic,strong)NSString *loginToken;
@property (nonatomic) BOOL isLogin;
@end
