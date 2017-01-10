//
//  HttpInfo.m
//  GFMusic
//
//  Created by HeQingshan on 15-05-05.
//  Copyright (c) 2015年 HeQingshan. All rights reserved.
//

#import "HttpInfo.h"

#define http_info(c,t)  [[HttpInfo alloc] initWithInfo:c type:t]
#define httpinfo_if(c,t) if(type==t){info = http_info(c,t);}
#define httpinfo_ele_if(c,t) else if(type==t){info = http_info(c,t);}

@implementation HttpInfo

-(id) initWithInfo:(NSString *)cn type:(HTTPTYPE)htype;
{
    self = [super init];
    if (self) {    
        self.className = STRISEMPTY(cn)?nil:cn;
        self.httpType = (htype==HTTP_BEGIN)?[NSNumber numberWithInteger:HTTP_BEGIN]:[NSNumber numberWithInteger:htype];
    }
    return self;
}

-(NSString *) dicKey
{
    return [NSString stringWithFormat:@"khttp%@",self.httpType];
}

@end


@interface HttpMethod()

@property(nonatomic,strong) NSMutableDictionary *dicInfos;

@end

@implementation HttpMethod

+(HttpMethod *) sharedMethod
{
    static HttpMethod *g_httinf = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_httinf = [[HttpMethod alloc] init];
    });
    return g_httinf;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.dicInfos = [[NSMutableDictionary alloc] init];
        for (HTTPTYPE type = HTTP_BEGIN; type < HTTPTYPE_END; type++) {
            HttpInfo *info = nil;
            //登录相关
            //httpinfo_if(nil,Http_GetAuthCode);
            if(info){
                NSString *key = [info dicKey];
                NSDictionary *dic = [info toDictionary];
                [self.dicInfos setObject:dic forKey:key];
            }
        }
    }
    return self;
}

-(Class) typeClass:(HTTPTYPE )type
{
    NSString *key = [NSString stringWithFormat:@"khttp%d",type];
    NSDictionary *dic = [self.dicInfos objectForKey:key];
    if(dic){
        HttpInfo *info = [[HttpInfo alloc] initWithDictionary:dic];
        return NSClassFromString(info.className);
    }
    return nil;
}

@end
