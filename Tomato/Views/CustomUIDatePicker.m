//
//  customUIDatePicker.m
//  SuperManager
//
//  Created by qingshan on 15/3/21.
//  Copyright (c) 2015年 GaryOu. All rights reserved.
//

#import "CustomUIDatePicker.h"

@implementation CustomUIDatePicker

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIToolbar * toolbar = [[UIToolbar  alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FULL_SCREEN, kHeightToolbar)];
        UIBarButtonItem * fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIColor *color = CellLine_Color;
        UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishBtn setTitleColor:color forState:UIControlStateNormal];
        finishBtn.layer.cornerRadius = 4;
        finishBtn.layer.borderWidth = 1;
        finishBtn.layer.borderColor = color.CGColor;
        [finishBtn setBackgroundColor:[UIColor clearColor]];
        finishBtn.titleLabel.font = K_Font_12;
        [finishBtn setFrame:CGRectMake(0, 0, 40,25)];
        [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
        toolbar.items = [NSArray arrayWithObjects:fix,finish, nil];
        if (IOS7_LATER){
            [finish setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
            [toolbar setTranslucent:NO];
        }
        //toolbar.backgroundColor = NavigationBg_Color;
        
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kHeightToolbar, WIDTH_FULL_SCREEN, PickerViewHeight)];
        _pickerView.datePickerMode = UIDatePickerModeDate;
        _pickerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickerView];
        [self addSubview:toolbar];
    }
    
    return self;
}

-(void)finish
{
    if (_delegate && [_delegate respondsToSelector:@selector(finishPicker:)]) {
        [_delegate finishPicker:self];
    }
    [self hide];
}

-(void)show
{
    if (self.isShowing) {
        return;
    }
    [UIView animateWithDuration:0.33 animations:^{
        CGRect rect = self.frame;
        UIView *view = self.superview;
        rect.origin.y = view.frame.size.height - self.frame.size.height;
        self.frame = rect;
    } completion:^(BOOL finished) {
        self.isShowing = YES;
    }];
}

-(void)hide
{
    if (!self.isShowing) {
        return;
    }
    [UIView animateWithDuration:0.33 animations:^{
        CGRect rect = self.frame;
        UIView *view = self.superview;
        rect.origin.y = view.frame.size.height;
        self.frame = rect;
    } completion:^(BOOL finished) {
        self.isShowing = NO;
        self.tag = 100;
    }];
}

@end
