//
//  NSString+Extensions.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/17.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

- (NSString *)lowercaseFirstCharacter;
- (NSString *)uppercaseFirstCharacter;
- (NSString *)trim;
- (NSString *)trimTheExtraSpaces;
- (NSString *)escapeHTML;
- (NSString *)md5;
- (NSString *)md5ForUTF16;
- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (NSMutableArray *)tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts;
- (NSString *)languageForString;
- (NSMutableArray *)analyseTextOfSentences;


@end

@interface NSString (ParseCategory)
- (NSMutableDictionary *)explodeToDictionaryInnerGlue:(NSString *)innerGlue
                                           outterGlue:(NSString *)outterGlue;
@end
