//
//  NSDate+Category.h
//  MHTTPRequestTest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (category)
-(NSString *) toString;
-(NSString *) toString:(NSString *)frame;
+(NSDate *) StringToDate:(NSString *)strDate;
+(NSDate *) StringToDate:(NSString *)strDate Formatte:(NSString *)format;
@end
