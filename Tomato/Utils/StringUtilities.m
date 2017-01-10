//
//  StringValidate.m
//  App
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "StringUtilities.h"
#import "RegexKitLite.h"

NSString* const REG_EMAIL = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
NSString* const REG_MOBILE = @"^(14[0-9]|13[0-9]|15[0-9]|18[0-9])\\d{8}$";
NSString* const REG_PHONE = @"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})";
NSString* const REG_ENGLISH = @"^[A-Za-z0-9]+$";

@implementation StringUtilities

+(BOOL)isChineseValue:(NSString *)input
{
    BOOL bChinese = YES;
    for (int i=0; i<[(NSString *)input length]; i++) {
        int a = [(NSString *)input characterAtIndex:i];
        if (a >= 0x4e00&& a<= 0x9fa6) {
        }else{
            bChinese = NO;
            break;
        }
        
    }
    return bChinese;
}

+(BOOL)isEmail:(NSString *)input
{
    return [input isMatchedByRegex:REG_EMAIL];
}

+(BOOL)isPhoneNum:(NSString *)input
{
    return [input isMatchedByRegex:REG_PHONE];
}

+(BOOL)isMobileNum:(NSString *)input
{
    return [input isMatchedByRegex:REG_MOBILE];
}

+(BOOL)isPhoneOrMobileNum:(NSString *)input
{
    return [input isMatchedByRegex:REG_MOBILE] || [input isMatchedByRegex:REG_PHONE];
}

+(BOOL)isNumOrWord:(NSString *)input
{
    return [input isMatchedByRegex:REG_ENGLISH];
}

+(CGSize)sizeOfString:(NSString *)aString size:(float)aSize
{
    UIFont * font =[UIFont systemFontOfSize:aSize];
    UIColor * color = [UIColor clearColor];
    NSDictionary * attrs = [NSDictionary dictionaryWithObjectsAndKeys:font,
                            NSFontAttributeName,
                            color,
                            NSForegroundColorAttributeName,
                            nil];
    return [aString sizeWithAttributes:attrs];
}

+(BOOL)isEnglishValue:(NSString *)input
{
    BOOL bChinese = YES;
    for (int i = 0; i <= [(NSString *)input length]; i++) {
        int a = [(NSString *)input characterAtIndex:i];
        if ((65 <= a && a <= 90)||(97 <=a && a <= 122)) {
        }else{
            bChinese = NO;
            break;
        }
    }
    return bChinese;
}

+ (BOOL)isEnglishCharacters:(NSInteger)characterAtIndex {
    if((65 <= characterAtIndex  && characterAtIndex <= 90) ||
       (97 <= characterAtIndex  && characterAtIndex <= 122)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isSpace:(NSInteger)characterAtIndex {
    if (32 == characterAtIndex) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)iswhitespace:(NSInteger)characterAtIndex {
    if (20 == characterAtIndex) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isPunctuation:(NSInteger)characterAtIndex {
    if (44 == characterAtIndex ||
        46 == characterAtIndex ||
        33 == characterAtIndex ||
        63 == characterAtIndex ||
        39 == characterAtIndex) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isTextNoPunctuation:(NSString *)_text {
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        if ([self isChineseCharacters:a] ||
            [self isEnglishCharacters:a] ||
            [self isNum:a] ||
            [self isSpace:a]) {
        } else {
            return NO;
        }
    }
    return YES;
}

//判断字符串是否含有特殊字符（“（）”除外）
+ (BOOL)isTextNoPunctuationExceptBrackets:(NSString *)_text {
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        if ([self isChineseCharacters:a] ||
            [self isEnglishCharacters:a] ||
            [self isNum:a] ||
            [self isSpace:a] ||
            [self iswhitespace:a] ||
            a == 40 ||
            a == 41 ||
            a == 65288 ||
            a == 65289
            ) {
        } else {
            return NO;
        }
    }
    return YES;
}

//判断字符串是否含有空格
+ (BOOL)isTextHaswhitespace:(NSString *)_text {
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        if (
            [self isSpace:a] ||
            [self iswhitespace:a]
            )
        {
            
        }
        else {
            return NO;
        }
    }
    return YES;
}

+(BOOL)isNumberStr:(NSString *)_text{
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        if ([self isNum:a]) {
        } else {
            return NO;
        }
    }
    return YES;
}

+(BOOL)isPureFloat:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isNum:(NSInteger)characterAtIndex {
    if(48 <= characterAtIndex  && characterAtIndex <= 57) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isZeroNum:(NSInteger)characterAtIndex {
    if(48 == characterAtIndex ) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isChineseCharacters:(NSInteger)characterAtIndex {
    if(characterAtIndex >= 0x4e00 && characterAtIndex <= 0x9fa6) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)isTextHavePunctuation:(NSString *)_text {
    for(int i = 0; i < [(NSString *)_text length]; ++i) {
        int a = [(NSString *)_text characterAtIndex:i];
        if ([self isChineseCharacters:a] ||
            [self isEnglishCharacters:a] ||
            [self isNum:a] ||
            [self isSpace:a] ||
            [self isPunctuation:a]) {
        } else {
            return NO;
        }
    }
    return YES;
}

+(BOOL)isEmptyString:(NSString*)input {
    if (!input || ![input isKindOfClass:[NSNull class]] || ![input isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+(NSString*)getNoneNullStringWithString:(NSString*)input {
    if (!input || ![input isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
    return input;
}

+(NSString*)trim:(NSString*)input {
    return [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSMutableAttributedString*)getPriceAttributeString:(NSString*)sellPrice minFont:(UIFont*)minFont {
    NSArray *strArray = [sellPrice componentsSeparatedByString:@"."];
    NSString *suffix = @".00";
    if (strArray.count == 2) {
        suffix = [NSString stringWithFormat:@".%@", strArray[1]];
    }
    NSString *prefix = strArray[0];
    NSString *desStr = [NSString stringWithFormat:@"￥%@%@", prefix, suffix];
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc] initWithString:desStr];
    NSRange range = [desStr rangeOfString:suffix];
    [mulStr addAttributes:@{NSFontAttributeName:minFont} range:range];
    return mulStr;
}

+ (NSMutableAttributedString *)getAttributedString:(NSString*)sourceString subString:(NSString*)subString attribute:(NSDictionary*)attrs {
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc] initWithString:sourceString];
    if (subString.length == 0) {
        return mulStr;
    }
    NSRange range = [sourceString rangeOfString:subString];
    [mulStr addAttributes:attrs range:range];
    return mulStr;
}

@end
