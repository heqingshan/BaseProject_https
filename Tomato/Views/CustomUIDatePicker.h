//
//  customUIDatePicker.h
//  SuperManager
//
//  Created by qingshan on 15/3/21.
//  Copyright (c) 2015年 GaryOu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PickerViewHeight 210

@protocol CustomUIDatePickerDelegate;
@interface CustomUIDatePicker : UIView

@property (nonatomic,strong) UIDatePicker *pickerView;
@property (nonatomic,assign) id<CustomUIDatePickerDelegate> delegate;
@property (nonatomic,assign) BOOL isShowing;

-(void)show;
-(void)hide;

@end

@protocol CustomUIDatePickerDelegate <NSObject>

@optional
-(void)finishPicker:(CustomUIDatePicker*)picker;

@end
