//
//  Singleton.m
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/17.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "Singleton.h"
#import "Reachability.h"

//跳转对象引入
#import "AppDelegate.h"
#import "UIBaseViewController.h"

static Singleton * instance = nil;

@implementation Singleton
@synthesize user;

- (id)init {
    self = [super init];
    if (self) {
        if ([self isLogin]) {
            NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfo];
            user = [[UserInfo alloc] initWithDictionary:dict];
        }
        else {
            user = [[UserInfo alloc] init];
        }
    }
    return self;
}

+(Singleton*)shareInstance
{
    if(instance == nil)
    {
        instance = [[super allocWithZone:nil] init];
    }
    return instance;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [Singleton shareInstance];
}

- (void)setUser:(UserInfo *)aUser
{
    user = aUser;
}

- (UserInfo*)user {
    if (user == nil) {
        user = [[UserInfo alloc] init];
    }
    return user;
}

-(BOOL)isLogin
{
    NSString * _sid = [[NSUserDefaults standardUserDefaults] objectForKey:kToken];
    if (!_sid || [_sid isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

-(void)saveLoginInfo:(UserInfo*)_info
{
    NSMutableDictionary * infoDic = [_info toDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:_info.token forKey:kToken];
    [[NSUserDefaults standardUserDefaults] setObject:infoDic forKey:kUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //设置当前用户信息
    user = _info;
}

- (void)clearUserData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    user = nil;
}

+ (BOOL) IsEnableWIFI {
    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
}

+ (BOOL) IsEnable3G {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}

+ (BOOL) NetworkNotEnable {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable &&
            [[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == NotReachable);
}

- (NSString *)getParamValue:(NSInteger)index sourceStr:(NSString *)sourceStr {
    NSArray *strArray = [sourceStr componentsSeparatedByString:@";"];
    if (strArray.count > index) {
        return [strArray objectAtIndex:index];
    }
    return nil;
}

- (NSDictionary *)getParams:(NSString*)str {
    NSMutableDictionary *mulDict = [NSMutableDictionary dictionary];
    NSArray *strArray = [str componentsSeparatedByString:@"&"];
    for (NSString *itemStr in strArray) {
        NSArray *subItemArray = [itemStr componentsSeparatedByString:@"="];
        if (subItemArray.count != 2) {
            continue;
        }
        [mulDict setObject:subItemArray[1] forKey:subItemArray[0]];
    }
    return mulDict;
}

- (BOOL)jumpPage:(UIBaseViewController*)parentController jumpStr:(NSString*)aJumpStr {
#if 0
    //测试代码
    NSInteger index = labs(random()%6);
    NSString *str = @"";
    switch (index) {
        case 0://场馆体验，跳到对应的场馆体验详情界面
            str = @"jumpPage;myExperienceCont;ProductID=1&diamonds=1&expericeDate=1";
            break;
        case 1://比如家园，跳到比如减员的签到页面
            str = @"jumpPage;htmlUrl;http://user.beyou.cn/template.index.html";
            break;
        default:
            break;
    }
    aJumpStr = str;
    //以上为测试代码
#endif
    NSString *jumpStr = [aJumpStr lowercaseString];
    if ([jumpStr hasPrefix:@"jumppage"] == NO) {
        return NO;
    }
    NSString *classStr = [self getParamValue:1 sourceStr:jumpStr];
    if (STRISEMPTY(classStr)) {
        return NO;
    }
    //NSString *paramStr = [self getParamValue:2 sourceStr:jumpStr];
    if ([classStr isEqualToString:@"myexperiencecont"]) {
        //场馆体验
        /*
        NSDictionary *paramDict = [self getParams:paramStr];
        CommonObjectItem *item = [[CommonObjectItem alloc] init];
        item.ProductID = [paramDict objectForKey:@"productid"];
        item.diamonds = [paramDict objectForKey:@"diamonds"];
        item.expericeDate = [paramDict objectForKey:@"expericedate"];
        MyFacilityDetailViewController *ctrl = [[MyFacilityDetailViewController alloc] init];
        ctrl.pData = item;
        [parentController.navigationController pushViewController:ctrl animated:YES];
         */
    }
    else {
        return NO;
    }
    return YES;
}

@end
