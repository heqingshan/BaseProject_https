//
//  DataCentre.h
//  wyzc
//
//  Created by HeQingshan on 15-05-05.
//  Copyright (c) 2015年 HeQingshan. All rights reserved.
//

/*此处需要修改*/
#import "Jastor.h"

//通用接口的顶层参数结构
@interface DataCentre : Jastor
/* Success
 1 成功
 0 失败
 -2	用户被禁用
 -100	店铺不存在
 -101	店铺被禁用
 -102	店铺申请被拒绝
 -1001  订单被取消
 */
@property(nonatomic,strong) NSNumber *Success;  //获取结果参数
@property(nonatomic,strong) NSString *Message;  //结果提示参数
@end

@interface UserInfo : Jastor
@property(nonatomic,strong) NSString *token;
@end
