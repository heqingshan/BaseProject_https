//
//  StringValidate.h
//  App
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const REG_EMAIL;
extern NSString* const REG_PHONE;
extern NSString* const REG_MOBILE;
extern NSString* const REG_ENGLISH;
extern NSString* const REG_CHINESE;

@interface StringUtilities : NSObject

+(BOOL)isNumberStr:(NSString *)_text;
+(BOOL)isPureFloat:(NSString*)string;
+(BOOL)isZeroNum:(NSInteger)characterAtIndex;
+(BOOL)isChineseValue:(NSString *)input;
+(BOOL)isEmail:(NSString *)input;
+(BOOL)isPhoneNum:(NSString *)input;
+(BOOL)isMobileNum:(NSString *)input;
+(BOOL)isEnglishValue:(NSString *)input;
+(BOOL)isPhoneOrMobileNum:(NSString*)input;
+(BOOL)isNumOrWord:(NSString *)input;
+(CGSize)sizeOfString:(NSString*)aString size:(float)aSize;
// 判断是否有特殊字符（无标点）
+ (BOOL)isTextNoPunctuation:(NSString *)_text;
// 判断是否有特殊字符（有标点）
+ (BOOL)isTextHavePunctuation:(NSString *)_text;
//出去含括号的特殊字符
+ (BOOL)isTextNoPunctuationExceptBrackets:(NSString *)_text;
//包含空格
+ (BOOL)isTextHaswhitespace:(NSString *)_text;

+ (BOOL)isChineseCharacters:(NSInteger)characterAtIndex;
+ (BOOL)isNum:(NSInteger)characterAtIndex;
//是否是空字符串
+(BOOL)isEmptyString:(NSString*)input;
//获得一个非空字符串
+(NSString*)getNoneNullStringWithString:(NSString*)input;
//去除前后空格
+(NSString*)trim:(NSString*)input;
//通用组装富文本字符串
+ (NSMutableAttributedString*)getPriceAttributeString:(NSString*)sellPrice minFont:(UIFont*)minFont;
//通用性的获取富文本
+ (NSMutableAttributedString *)getAttributedString:(NSString*)sourceString subString:(NSString*)subString attribute:(NSDictionary*)attrs;
@end
