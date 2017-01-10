//
//  PosterShareView.h
//  wyzc
//
//  Created by WYZC on 15/11/11.
//  Copyright © 2015年 北京我赢科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , ShareType){
    ShareType_Wechat = 0,       //微信
    ShareType_WechatTimeline,   //朋友圈
    ShareType_QQ,               //QQ好友
    ShareType_QQZone,           //QQ空间
    ShareType_sina,             //新浪微博
    ShareType_message,          //短信
    ShareType_email,            //邮件
    ShareType_TententWB,        //腾讯微博
    ShareType_Copy,             //复制
    ShareType_None,
};
typedef void(^ShareType_block)(ShareType);

@interface PosterShareView : UIView

@property (strong, nonatomic) dispatch_block_t disMissBlock;
@property (strong, nonatomic) ShareType_block share_block;
-(instancetype)initWithFrame:(CGRect)frame Title:(NSArray *)titleArray Image:(NSArray*)imagesArray;
@end
