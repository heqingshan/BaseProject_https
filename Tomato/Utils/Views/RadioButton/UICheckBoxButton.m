//
//  UICheckBoxButton.m
//  MiniSales
//
//  Created by sunjun on 13-8-5.
//  Copyright (c) 2013年 sunjun. All rights reserved.
//

#import "UICheckBoxButton.h"

@implementation UICheckBoxButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(id) radionChecks:(CGRect)frame titles:(NSArray *)titles
{
    return [[[self class] alloc] initWithTitlesFrame:frame titles:titles];
}

- (id)initWithTitlesFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        radioNodes = [[NSMutableArray alloc] init];
        selectIndex = -1;  //未选中
        CGFloat x = 0.f,y=0.f,buttonWidth=22.f,buttonHeight=22.f;
        NSUInteger count = titles.count;
        for (NSUInteger i = 0;  i < count; i++) {
            NSString *title = [titles objectAtIndex:i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame = CGRectMake(x, y,20, 20);
            button.adjustsImageWhenHighlighted = NO;
            [button setImage:[UIImage imageNamed:@"gou_n"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"gou_sel"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x+buttonWidth+2.f, y, frame.size.width-(x+buttonWidth+2.f), buttonHeight)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:14.f];
            label.textAlignment = NSTextAlignmentLeft;
            label.text = title;
            label.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tickLabel:)];
            [label addGestureRecognizer:singleTap];
            
            [self addSubview:label];
            y+= buttonHeight;
            RadioNode *node = [[RadioNode alloc] initWithButton:button andLabel:label];
            [radioNodes addObject:node];
            
        }
    }
    return self;
}

- (void)tickLabel:(UITapGestureRecognizer *)tapGesture
{
    UILabel *label = (UILabel *)tapGesture.view;
    UIButton *button = nil;
    for (RadioNode *node in radioNodes) {
        if(node.label == label){
            button = node.button;
            break;
        }
    }
    if(button){
        [self handleButtonTap:button];
    }
}

-(void) handleButtonTap:(UIButton *)button
{
    //[button setSelected:!button.selected];
    NSUInteger index = 0;
    NSUInteger count = radioNodes.count;
    for (NSUInteger i = 0; i < count; i++) {
        RadioNode *node = [radioNodes objectAtIndex:i];
        UIButton *curButton = node.button;
        if(curButton==button){
            index = i;
            [button setSelected:YES];
        }else{
            [button setSelected:NO];
        }
    }
    selectIndex = index;
    if(self.delegate && [self.delegate respondsToSelector:@selector(radioButtonSelectedAtIndex:andIndex:)])
    {
        [self.delegate radioButtonSelectedAtIndex:self andIndex:selectIndex];
    }
}

-(BOOL) checked:(NSUInteger) index
{
    if(index >= radioNodes.count){
        return NO;
    }
    RadioNode *node = [radioNodes objectAtIndex:index];
    UIButton *button = node.button;
    return button.selected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
