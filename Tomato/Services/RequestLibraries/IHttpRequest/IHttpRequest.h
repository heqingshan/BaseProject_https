//
//  IHttpRequest.h
//  IHttpRequest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestID.h"
#import "RequestID.h"
#import "AFNetworking.h"
#import "RSA.h"

@class IHttpRequest;
//成功回调
typedef void(^SuccessBlock)(IHttpRequest *requestObject,RequestID *requestId,id sucMsg);
//失败回调
typedef void(^FailureBlock)(IHttpRequest *requestObject,RequestID *requestId,NSError *error);


@interface IHttpRequest : NSObject
{
    NSInteger   _nextId;
}

@property(nonatomic,strong) SuccessBlock sucBlock;
@property(nonatomic,strong) FailureBlock failBlock;

@property(nonatomic,strong) NSDictionary *userInfo;

-(RequestID *) fineRequestId:(AFHTTPRequestOperation *)request;
-(void) analysisResponse:(AFHTTPRequestOperation *)request requestId:(RequestID *)requestId;
-(void) notifySuccess:(id) sucMsg requestId:(RequestID *)requestId;
-(void) notifyError:(NSError *) error requestId:(RequestID *)requestId;

-(id) init;
-(void) cancel:(RequestID *) requestId;
-(void) cancelAll;
-(void) addRequestId:(RequestID *) requestId;
-(RequestID *) currentRequestId;
-(id) analyProtocol:(NSDictionary *)dic type:(NSUInteger)type;
-(id) checkIsSuccess:(NSDictionary *)dic type:(NSUInteger)type status:(NSInteger)status;
-(id) httpRequestAsynPost:(NSUInteger)type methodName:(NSString*)methodName data:(NSDictionary *)dic;
-(id) httpRequestAsynGet:(NSUInteger)type methodName:(NSString*)methodName data:(NSDictionary *)dic;


- (void)requestFinished:(AFHTTPRequestOperation *)requestObject;
- (void)requestFailed:(AFHTTPRequestOperation *)requestObject;
@end
