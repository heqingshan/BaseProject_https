//
//  RadioCheckButton+ButtonImage.m
//  wyzc
//
//  Created by YXY on 15/4/16.
//  Copyright (c) 2015年 北京我赢科技有限公司. All rights reserved.
//

#import "RadioCheckButton+ButtonImage.h"

@implementation RadioCheckButton (ButtonImage)

- (void)resetNormalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedIamge
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setImage:normalImage forState:UIControlStateNormal];
            [button setImage:selectedIamge forState:UIControlStateSelected];
        }
    }
}

@end
