//
//  PublicMacro.h
//  BeYou
//
//  Created by qingshan on 16/3/4.
//  Copyright © 2016年 HQS. All rights reserved.
//

#ifndef PublicMacro_h
#define PublicMacro_h

//设置是否是测试环境,1:测试环境，0：正式环境
#define TEST_APP 1

//加密Key
#define MD5SecretKey @""

//百度统计Key
#define BaiduMobStatKey @""

//百度推送ApiKey
#define BaiduPushApiKey @""

//视图分段控件高度
#define CommonSegmentHeight (IS_IPHONE_5_OR_LESS?44:48)

//通用Cell的高度
#define CommonCellHeight (IS_IPHONE_5_OR_LESS?44:48)

//图片压缩质量比
#define ImageCompressionQuality 0.7

//输入字数限制
//#define ShopNameMinLength 2         //店铺名称最短字符数量


//支付宝支付返回APP标记
#define AlipayBeyou @""

//百度推送Api Key
#define BPushApiKey @""

//用户宏定义
#define kUserInfo @"kUserInfo"
#define kToken @"token"

///========================================================================================================
//以下罗列枚举数据
//按钮上图片和文字显示方式
typedef enum : NSUInteger {
    ButtonStyleNone,        //没有要求
    ButtonStyleVertical,    //图文上下排列
    ButtonStyleLeft,        //图片居左，文字居右
    ButtonStyleRight,       //图片居右，文字居左
} ButtonStyle;

#endif /* PublicMacro_h */
