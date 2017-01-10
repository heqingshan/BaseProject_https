//
//  SMAlertView.h
//  Tomato
//
//  Created by qingshan on 15/4/12.
//  Copyright (c) 2015年 GaryOu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AlertViewCallBack)(NSInteger index);
@interface SMAlertView : UIAlertView<UIAlertViewDelegate> {
    AlertViewCallBack callBack;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message callBack:(AlertViewCallBack)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION NS_EXTENSION_UNAVAILABLE_IOS("Use UIAlertController instead.");

@end
