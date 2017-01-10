//
//  SMAlertView.m
//  Tomato
//
//  Created by qingshan on 15/4/12.
//  Copyright (c) 2015年 GaryOu. All rights reserved.
//

#import "SMAlertView.h"

@implementation SMAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message callBack:(AlertViewCallBack)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.")
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        callBack = block;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (callBack) {
        callBack(buttonIndex);
    }
}

@end
