//
//  NSString+Extensions.m
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/17.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "NSString+Extensions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extensions)

#pragma mark - 转换string大小写

- (NSString *)lowercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)uppercaseFirstCharacter {
    NSRange range = NSMakeRange(0,1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}

#pragma mark - trim string

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimTheExtraSpaces{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    return [filteredArray componentsJoinedByString:@" "];
}

//替换HTML代码
- (NSString *)escapeHTML {
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    [result replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

//普通的MD5加密
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

//UTF16的MD5加密
- (NSString *)md5ForUTF16{
    NSData *temp = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    UInt8 *cStr = (UInt8 *)[temp bytes];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)[temp length], result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

//自适应文字大小
- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGFloat fontSize = [font pointSize];
    CGFloat height = [self boundingRectWithSize:CGSizeMake(size.width,FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height;
    //[self sizeWithFont:font constrainedToSize:CGSizeMake(size.width,FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    UIFont *newFont = font;
    
    //Reduce font size while too large, break if no height (empty string)
    while (height > size.height && height != 0) {
        fontSize--;
        newFont = [UIFont fontWithName:font.fontName size:fontSize];
        height = [self boundingRectWithSize:CGSizeMake(size.width,FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height;
        //[self sizeWithFont:newFont constrainedToSize:CGSizeMake(size.width,FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    };
    return fontSize;
}

#pragma mark - tokeniztion string

/**
 根据设定参数进行字符串拆分
 NSStringEnumerationByComposedCharacterSequences,根据字母
 NSStringEnumerationByWords，根据单词
 NSStringEnumerationBySentences，根据句子
 这3个比较常用
 */
- (NSMutableArray *)tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts{
    NSMutableArray *splitArray = [NSMutableArray array];
    NSRange range = NSMakeRange(0, [self length]);
    [self enumerateSubstringsInRange:range options:opts usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [splitArray addObject:substring];
    }];
    
    return splitArray;
}

//detect string language，对于句子相对准确，单词不是很准确
- (NSString *)languageForString{
    return (__bridge NSString *)CFStringTokenizerCopyBestStringLanguage((CFStringRef)self, CFRangeMake(0, MIN(self.length,400)));
}

//分析句中单词的词性
- (NSMutableArray *)analyseTextOfSentences{
    NSMutableArray *analyseArray = [NSMutableArray array];
    
    // This range contains the entire string, since we want to parse it completely
    NSRange stringRange = NSMakeRange(0, self.length);
    
    //第一种方式
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSArray arrayWithObject:NSLinguisticTagSchemeNameTypeOrLexicalClass] options:0];
    [tagger setString:self];
    [tagger enumerateTagsInRange:stringRange
                          scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass
                         options:NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation
                      usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
                          [analyseArray addObject:@{@"word":[self substringWithRange:tokenRange],@"tag" : tag}];
                      }];
    return analyseArray;
}


@end

@implementation NSString (ParseCategory)

- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue
{
    NSArray *firstExplode = [self componentsSeparatedByString:outterGlue];
    NSArray *secondExplode;
    
    NSInteger count = [firstExplode count];
    NSMutableDictionary* returnDictionary = [NSMutableDictionary dictionaryWithCapacity:count];
    
    for (NSInteger i = 0; i < count; i++)
    {
        secondExplode =
        [(NSString*)[firstExplode objectAtIndex:i] componentsSeparatedByString:innerGlue];
        if ([secondExplode count] == 2)
        {
            [returnDictionary setObject:[secondExplode objectAtIndex:1]
                                 forKey:[secondExplode objectAtIndex:0]];
        }
    }
    return returnDictionary;
}


@end
