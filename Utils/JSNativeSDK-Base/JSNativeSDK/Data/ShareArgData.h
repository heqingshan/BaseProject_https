//
//  ShareArgData.h
//  JSNativeSDK
//
//  Created by Mtime on 15/11/9.
//  Copyright © 2015年 Mtime. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareArgData : NSObject
@property (nonatomic,strong)NSString* shareTitle;
@property (nonatomic,strong)NSString* shareMessage;
@property (nonatomic,strong)NSString* shareImageUrl;
@property (nonatomic,strong)NSString* shareUrl;
@property (nonatomic,strong)NSString* shareVideoUrl;

/// 微博类型，里面包含“#”字符和“更多详情”Url
@property (nonatomic, strong) NSString *shareMessageWeiBo;
/// QQ、SNS和Email类型，里面包含“下载Url和来自时光网”
@property (nonatomic, strong) NSString *shareMessageQQ;

@end
