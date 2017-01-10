//
//  H5PayData.h
//  JSNativeSDK
//
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "H5PayArgData.h"
@interface H5PayData : NSObject
@property (nonatomic,strong)NSString*tokenKey;
@property (nonatomic,strong)NSString*callbackName;
@property (nonatomic,strong)H5PayArgData * argData;
@end
