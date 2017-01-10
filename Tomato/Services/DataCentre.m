//
//  DataCentre.m
//  wyzc
//
//  Created by HeQingshan on 15-05-05.
//  Copyright (c) 2015年 HeQingshan. All rights reserved.
//

#import "DataCentre.h"

#define cmd_name(proNmame,key,dic)\
{NSString *cvalue = [dic objectForKey:key];\
if (!STRISEMPTY(cvalue)) {\
self.proNmame = cvalue;\
}else{\
self.proNmame = @"";\
}}

@implementation DataCentre

@end

@implementation UserInfo

@end
