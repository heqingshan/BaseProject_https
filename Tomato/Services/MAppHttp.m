//
//  MAppHttp.m
//  MHTTPRequestTest
//
//  Created by HeQingshan on 15-05-05.
//  Copyright (c) 2015年 HeQingshan. All rights reserved.
//

#import "MAppHttp.h"
#import "OpenUDID.h"

#define openHttpsSSL NO

@implementation MAppHttpJson

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    return data;
}

@end

@interface MAppHttp()
{
    NSString *_uuid;
}

@end
@implementation MAppHttp

-(id) init
{
    self = [super init];
    if(self){
        _uuid = [OpenUDID value];
    }
    return self;
}

//异步Get方法
-(id) httpRequestAsynGet:(NSUInteger)type methodName:(NSString*)methodName data:(NSDictionary *)dic
{
    NSMutableString *strurl = [NSMutableString stringWithFormat:@"%@%@?",BASE_URL,methodName];
    NSMutableArray *array = [NSMutableArray array];
    if(dic){
        NSArray *arrkey = [dic allKeys];
        for (NSString *key in arrkey) {
            [strurl appendFormat:@"%@=%@&",key,[dic objectForKey:key]];
            [array addObject:[NSString stringWithFormat:@"%@=%@",key,[dic objectForKey:key]]];
        }
    }
    if (!STRISEMPTY(_uuid)) {
        [strurl appendFormat:@"%@=%@",@"device",_uuid];
        [array addObject:[NSString stringWithFormat:@"%@=%@",@"device",_uuid]];
    }
    if ([strurl hasSuffix:@"&"]) {
        strurl = [NSMutableString stringWithString:[strurl substringToIndex:strurl.length - 2]];
    }
    
    //加密参数
    [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1=(NSString *)obj1;
        NSString *str2=(NSString *)obj2;
        return [str1 compare:str2];
    }];
    NSMutableString *mulStr = [NSMutableString string];
    for (int i = 0; i < array.count; i++) {
        if (i == array.count - 1) {
            [mulStr appendFormat:@"%@",array[i]];
        }
        else {
            [mulStr appendFormat:@"%@&",array[i]];
        }
    }
    NSString *secretKey = [NSString stringWithFormat:@"%@%@",[mulStr md5],MD5SecretKey];
    DLog(@"First secretKey:%@", secretKey);
    [strurl appendFormat:@"&%@=%@",@"secretKey",[secretKey md5]];
    
    DLog(@"Get Request Url:%@", strurl);
    
    NSString *lastUrlStr = [strurl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL){
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }

    __block __strong MAppHttp *bSelf = self;
    CGFloat startTime = [[NSDate date] timeIntervalSince1970];
    CGFloat waitSecond = 0.5;
    AFHTTPRequestOperation *operation = [manager GET:lastUrlStr parameters:nil timeOut:TIMEOUT_Seconds success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [bSelf requestFinished:operation];
            });
        }
        else {
            [bSelf requestFinished:operation];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [bSelf requestFailed:operation];
            });
        }
        else {
            [bSelf requestFailed:operation];
        }
    }];
    operation.responseSerializer = [MAppHttpJson serializer];
    operation.tag = type;
    RequestID *rid = [RequestID requestIdWith:type object:operation andTag:_nextId++];
    [self addRequestId:rid];
    
    return rid;
}

//异步Post方法
-(id) httpRequestAsynPost:(NSUInteger)type methodName:(NSString*)methodName data:(NSDictionary *)dic
{
    __block __weak __typeof(self)weakSelf = self;
    NSString *strurl = [NSString stringWithFormat:@"%@%@",BASE_URL,methodName];
    DLog(@"Post Method Url:%@", strurl);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 加上这行代码，https ssl 验证。
    if(openHttpsSSL){
        [manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    CGFloat startTime = [[NSDate date] timeIntervalSince1970];
    CGFloat waitSecond = 0.5;
    AFHTTPRequestOperation *operation = [manager POST:strurl parameters:nil timeOut:TIMEOUT_Seconds + 15 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSMutableArray *array = [NSMutableArray array];
        if (dic) {
            NSArray *arr = [dic allKeys];
            for (NSString *key in arr) {
                id  value = [dic valueForKey:key];
                if ([value isKindOfClass:[NSData class]])
                {
                    [formData appendPartWithFileData:value name:key fileName:@"ap.png" mimeType:@"image/jpeg"];
                }
                else
                {
                    [formData appendPartWithFormData:[value dataUsingEncoding:NSUTF8StringEncoding] name:key];
                    [array addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
                }
            }
        }
        if (!STRISEMPTY(_uuid)) {
            [formData appendPartWithFormData:[_uuid dataUsingEncoding:NSUTF8StringEncoding] name:@"device"];
            [array addObject:[NSString stringWithFormat:@"%@=%@",@"device",_uuid]];
        }
        //加密参数
        [array sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString *str1=(NSString *)obj1;
            NSString *str2=(NSString *)obj2;
            return [str1 compare:str2];
        }];
        NSMutableString *mulStr = [NSMutableString string];
        for (int i = 0; i < array.count; i++) {
            if (i == array.count - 1) {
                [mulStr appendFormat:@"%@",array[i]];
            }
            else {
                [mulStr appendFormat:@"%@&",array[i]];
            }
        }
        NSString *secretKey = [NSString stringWithFormat:@"%@%@",[mulStr md5],MD5SecretKey];
        DLog(@"First secretKey:%@", secretKey);
        NSString *lastKey = [secretKey md5];
        [formData appendPartWithFormData:[lastKey dataUsingEncoding:NSUTF8StringEncoding] name:@"secretKey"];
        
        DLog(@"Post Method Params:%@&secretKey=%@", mulStr, lastKey);
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf requestFinished:operation];
            });
        }
        else {
            [weakSelf requestFinished:operation];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CGFloat endTime = [[NSDate date] timeIntervalSince1970];
        if (endTime - startTime < waitSecond) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((waitSecond - (endTime - startTime)) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf requestFailed:operation];
            });
        }
        else {
            [weakSelf requestFailed:operation];
        }
    }];
    operation.responseSerializer = [MAppHttpJson serializer];
    operation.tag = type;
    RequestID *rid = [RequestID requestIdWith:type object:operation andTag:_nextId++];
    [self addRequestId:rid];
    
    return rid;
}

// Https SSL证书适配
- (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ssl" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}

//数据结构解析
-(id) analyProtocol:(NSDictionary *)dic type:(NSUInteger)type
{
    @autoreleasepool {
        Class c = [[HttpMethod sharedMethod] typeClass:(HTTPTYPE)type];
        id obj = nil;
        if(c){
            switch (type) {
                case HTTP_BEGIN:
                {
                    obj =  [[c alloc] initWithDictionary:dic];
                }
                    break;
                default:{
                    id data = [dic objectForKey:@"Data"];
                    if (data != [NSNull null] && [data isKindOfClass:[NSDictionary class]]) {
                        obj =  [[c alloc] initWithDictionary:data];
                    }
                    break;
                }
                break;
            }
        }
        if(obj)
        {
            return obj;
        }
        return dic;
    }
}

-(void)requestAsynGet:(NSString*)methodName params:(NSDictionary*)dict type:(HTTPTYPE)type success:(SuccessBlock)success error:(FailureBlock)error {
    self.sucBlock = success;
    self.failBlock = error;
    [self httpRequestAsynGet:type methodName:methodName data:dict];
}

-(void)requestAsynPost:(NSString*)methodName params:(NSDictionary*)dict type:(HTTPTYPE)type success:(SuccessBlock)success error:(FailureBlock)error {
    self.sucBlock = success;
    self.failBlock = error;
    [self httpRequestAsynPost:type methodName:methodName data:dict];
}

@end
