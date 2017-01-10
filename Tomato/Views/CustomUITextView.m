//
//  CustomUITextView.m
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/18.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "CustomUITextView.h"

@implementation CustomUITextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIToolbar * toolbar = [[UIToolbar  alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FULL_SCREEN, kHeightToolbar)];
        UIBarButtonItem * fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIButton * finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishBtn setImage:[UIImage imageNamed:IMG_Hide_KeyBoard] forState:UIControlStateNormal];
        [finishBtn setImage:[UIImage imageNamed:IMG_Hide_KeyBoard] forState:UIControlStateHighlighted];
        [finishBtn setFrame:CGRectMake(0, 0, 40,25)];
        [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *finish = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
        toolbar.items = [NSArray arrayWithObjects:fix,finish, nil];
        if (IOS7_LATER){
            [finish setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
            [toolbar setTranslucent:NO];
        }
        self.inputAccessoryView = toolbar;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)finish
{
    [self resignFirstResponder];
}

@end
