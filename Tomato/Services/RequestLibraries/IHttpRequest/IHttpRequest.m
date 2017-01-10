//
//  IHttpRequest.m
//  IHttpRequest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "IHttpRequest.h"
#import "HttpInfo.h"
#import "MAppHttp.h"
#import "RSA.h"
#import "AppDelegate.h"
#import "Singleton.h"

#define NET_TIMEOUT       NSLocalizedString(@"网络异常,请检查您的网络!", nil)

@interface IHttpRequest()
{
    NSMutableArray *_requestObjs;
    NSLock         *_reLock;
    dispatch_queue_t  _queue;
}

@end

@implementation IHttpRequest
#pragma maket request moneth

- (void)dealloc
{
    [self cancelAll];
    if(_queue){
        _queue=nil;
    }
}
-(void) addRequestId:(RequestID *) requestId
{
    [_reLock lock];
    [_requestObjs addObject:requestId];
    [_reLock unlock];
}


-(RequestID *) currentRequestId
{
    RequestID *rid = nil;
    [_reLock lock];
    if(_requestObjs.count > 0)
    {
        rid = [_requestObjs lastObject];
    }
    [_reLock unlock];
    return rid;
}

-(id) init
{
    self = [super init];
    if(self){
        _nextId = 0;
        _requestObjs = [[NSMutableArray alloc] init];
        _reLock = [[NSLock alloc] init];
    }
    return self;
}

-(void) cancel:(RequestID *) requestId
{
    if(requestId==nil) return;
    [_reLock lock];
    AFHTTPRequestOperation *afrequest = requestId.object;
    [afrequest setCompletionBlockWithSuccess:nil failure:nil];
    [afrequest cancel];
    [_requestObjs removeObject:requestId];
    [_reLock unlock];
}

-(RequestID *) fineRequestId:(AFHTTPRequestOperation *)request
{
    for (RequestID *rid in _requestObjs) {
        AFHTTPRequestOperation *asi = rid.object;
        if([asi isEqual:request] || request.tag == rid.type){
            return rid;
        }
    }
    return nil;
}

-(void) cancelAll
{
    [_reLock lock];
    for (RequestID *rid in _requestObjs) {
        AFHTTPRequestOperation *afrequest = rid.object;
        [afrequest setCompletionBlockWithSuccess:nil failure:nil];
        [afrequest cancel];
    }
    [_requestObjs removeAllObjects];
    [_reLock unlock];
}

-(id) httpRequestAsynPost:(NSUInteger)type methodName:(NSString*)methodName data:(NSDictionary *)dic
{
    return dic;
}

-(id) httpRequestAsynGet:(NSUInteger)type methodName:(NSString*)methodName data:(NSDictionary *)dic
{
    return dic;
}

- (void)requestFinished:(AFHTTPRequestOperation *)requestObject
{
    if(_queue == nil){
        _queue = dispatch_queue_create("httpQueue", nil);
    }
    
    RequestID *rid = [self fineRequestId:requestObject];
    __block __strong  IHttpRequest *bself = self;
    dispatch_async(_queue, ^{
        [bself analysisResponse:requestObject requestId:rid];
    });
    [self cancel:rid];
}

- (void)requestFailed:(AFHTTPRequestOperation *)requestObject
{
    NSInteger statusCode = requestObject.response.statusCode;
    DLog(@"requestFailed status code:%ld",(long)statusCode);
    RequestID *rid = [self fineRequestId:requestObject];
    if (self.failBlock) {
        self.failBlock(self, rid, nil);
    }
    [self cancel:rid];
}

- (void)requestStarted:(AFHTTPRequestOperation *)requestObject
{
    //
}

-(void) analysisResponse:(AFHTTPRequestOperation *)request requestId:(RequestID *)requestId
{
    NSString *strValue = [request responseString];
    NSInteger statusCode = request.response.statusCode;
    DLog(@"status code:%ld",(long)statusCode);
    if (strValue) {
        NSData* data = [strValue dataUsingEncoding:request.responseStringEncoding];
        if (!data) {
            data = [NSData data];
        }
        id dict = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSError *err = [self checkIsSuccess:dict type:requestId.type status:statusCode];
        if(nil == err){
            id result = [self analyProtocol:dict type:requestId.type];
            NSLog(@"接收消息---json = \n%@", result);
            [self notifySuccess:result requestId:requestId];
        }else{
            NSLog(@"接收消息---json--Error = \n%@", strValue);
            [self notifyError:err requestId:requestId];
        }
    }
    else {
        NSLog(@"接收消息---json--Error--NoData = \n%@", strValue);
        [self notifyError:[NSError errorWithDomain:@"返回数据为空！" code:0 userInfo:nil] requestId:requestId];
    }
}

-(void) notifySuccess:(id) sucMsg requestId:(RequestID *)requestId
{
    __block __weak  IHttpRequest *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.sucBlock) {
            self.sucBlock(weakSelf, requestId, sucMsg);
        }
    });
}

-(void) notifyError:(NSError *) error requestId:(RequestID *)requestId
{
    __block __weak  IHttpRequest *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.failBlock) {
            if(error.code==1 || error.code==2){
                NSError *arr = [[NSError alloc] initWithDomain:NET_TIMEOUT code:error.code userInfo:nil];
                self.failBlock(weakSelf, requestId, arr);
            }else{
                self.failBlock(weakSelf, requestId, error);
            }
        }
    });
}

#define NET_ERROR   NSLocalizedString(@"数据解析失败!",nil)

-(id) analyProtocol:(NSDictionary *)dic type:(NSUInteger)type
{
    return dic;
}

/*此处需要修改*/
-(id) checkIsSuccess:(NSDictionary *)dic type:(NSUInteger)type status:(NSInteger)status
{
    if(dic == nil) {
        return [NSError errorWithDomain:[NSString stringWithFormat:@"%@status code:%ld", NET_ERROR, (long)status] code:0 userInfo:nil];
    }
    NSNumber *code = [dic objectForKey:@"Success"];
    if ([code integerValue] != 1) {
        return [NSError errorWithDomain:[dic objectForKey:@"Message"] code:[code integerValue] userInfo:nil];
    }
    return nil;
}


@end
