//
//  NSDate+Category.m
//  MHTTPRequestTest
//
//  Created by sunjun on 13-6-11.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (category)

-(NSString *) toString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:self];
}
-(NSString *) toString:(NSString *)frame
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:frame];
    return [dateFormatter stringFromDate:self];
}

+(NSDate *) StringToDate:(NSString *)strDate
{
    //NSString *myDateString = @"2010-12-08";
    //拿到原先的日期格式
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:@"yyyy-MM-dd"]; //2010-12-08 06:53:43
    
    //将NSString转换为NSDate
    NSDate *theDate  = [inputFormat dateFromString:strDate];
    return theDate;
    
}


+(NSDate *) StringToDate:(NSString *)strDate Formatte:(NSString *)format
{
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setDateFormat:format]; //2010-12-08 06:53:43
    
    //将NSString转换为NSDate
    NSDate *theDate  = [inputFormat dateFromString:strDate];
    return theDate;
}

@end
