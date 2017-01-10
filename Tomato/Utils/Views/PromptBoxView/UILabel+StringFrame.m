//
//  UILabel+StringFrame.m
//  UTeam
//
//  Created by qingshan on 15/5/10.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)
- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGSize retSize;
    if (IOS7_LATER) {
       retSize = [self.text boundingRectWithSize:size
                                  options:\
           NSStringDrawingTruncatesLastVisibleLine |
           NSStringDrawingUsesLineFragmentOrigin |
           NSStringDrawingUsesFontLeading
                               attributes:attribute
                                  context:nil].size;

    }else{
        retSize = [self.text boundingRectWithSize:CGSizeMake(size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size;
        //[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
    }
    return retSize;
}
@end
