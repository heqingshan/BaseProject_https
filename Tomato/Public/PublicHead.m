//
//  PublicHead.m
//  UTeam
//
//  Created by qingshan on 15/5/9.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "PublicHead.h"
#import "Singleton.h"
#import "OpenUDID.h"
#import "sys/utsname.h"

@implementation PublicHead
@synthesize platform,clientVersion,token,device;

-(id)init
{
    self = [super init];
    if (self) {
        platform = @(1);
        clientVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        NSString * _token = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
        if (!_token) {
            _token = @"";
        }
        token  = _token;//@"d3c77814188800d56698ef818cec3324";//
        device = [OpenUDID value];
    }
    return self;
}

@end
