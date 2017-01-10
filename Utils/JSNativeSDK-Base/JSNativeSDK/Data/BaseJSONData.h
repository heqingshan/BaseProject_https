//
//  BaseJSONData.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/6.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseJSONData : NSObject
@property (nonatomic,strong)NSString *errMsg;
@property (nonatomic) BOOL success;
@property (nonatomic,strong) NSObject* data;
@property (nonatomic) NSString* tokenKey;
@property (nonatomic,strong) NSString* callbackName;
//{token:String , errMsg:"",success:true,callbackName:"",data:{}}
@end
