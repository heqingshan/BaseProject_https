//
//  HttpInfo.h
//  GFMusic
//
//  Created by HeQingshan on 15-05-05.
//  Copyright (c) 2015年 HeQingshan. All rights reserved.
//
/*此处需要修改*/
#import "Jastor.h"

//登录相关
//#define Request_GetAuthCode         @"/common/getauthcode"              //获取手机验证码

typedef enum {
    HTTP_BEGIN = -1,
    
    HTTPTYPE_END,
}HTTPTYPE;



@interface HttpInfo : Jastor
@property(nonatomic,strong) NSString *className;
@property(nonatomic,strong) NSNumber *httpType;
-(id) initWithInfo:(NSString *)cn type:(HTTPTYPE)htype;
@end

@interface HttpMethod : NSObject
+(HttpMethod *) sharedMethod;
-(Class) typeClass:(HTTPTYPE )type;
@end
