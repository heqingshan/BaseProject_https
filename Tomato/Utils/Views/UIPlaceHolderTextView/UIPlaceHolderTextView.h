//
//  UIPlaceHolderTextView.h
//  App
//
//  Created by HeQingshan－Air on 15/1/21.
//  Copyright (c) 2015年 Sunmay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomUITextView.h"

//带有placeholder的UITextView
@interface UIPlaceHolderTextView : CustomUITextView {
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
