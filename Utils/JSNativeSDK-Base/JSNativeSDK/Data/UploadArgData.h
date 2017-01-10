//
//  UploadArgData.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/9.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadArgData : NSObject
@property (nonatomic) int localId;
@property (nonatomic) BOOL isShowProgressTips;
@property (nonatomic,strong) NSString* uploadTag;
@end
