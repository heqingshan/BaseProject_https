//
//  ImageUploadResultData.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/10.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUploadResultData : NSObject
@property (nonatomic,strong)NSString* uploadImage;
@property (nonatomic)int uploadStatus;//上传状态,1成功,2失败
@end
