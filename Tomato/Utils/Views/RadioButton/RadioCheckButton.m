//
//  RadioCheckButton.m
//  RadioButton
//
//  Created by sunjun on 13-7-16.
//
//

#import "RadioCheckButton.h"

@implementation RadioNode
@synthesize button=_button,label=_label;
- (id)initWithButton:(UIButton *)pbutton andLabel:(UILabel *)pLabel
{
    self = [super init];
    if (self) {
        self.button = pbutton;
        self.label = pLabel;
    }
    return self;
}

@end

@implementation RadioCheckButton

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
            button.frame = CGRectMake(x, y,buttonWidth, buttonHeight);
            button.adjustsImageWhenHighlighted = NO;
            button.tag = 100 + i;
            [button setImage:[UIImage imageNamed:@"gou_n"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"gou_sel"] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
           UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x+buttonWidth+2.f, y, frame.size.width-(x+buttonWidth+2.f), buttonHeight)];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor blackColor];
            label.font = [UIFont systemFontOfSize:13.f];
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

-(void) setCheckIndex:(NSUInteger) index check:(BOOL) checked
{
    if(index >= radioNodes.count){
        return;
    }
    RadioNode *node = [radioNodes objectAtIndex:index];
    UIButton *button = node.button;
    [button setSelected:checked];
    selectIndex = index;
}

-(CGRect) setIndexFrame:(CGRect)frame index:(NSUInteger)index
{
    if(index >= radioNodes.count){
        return CGRectZero;
    }
    RadioNode *node = [radioNodes objectAtIndex:index];
    node.button.frame = CGRectMake(frame.origin.x, frame.origin.y, 22.f, 22.f);
    CGSize size = [node.label.text sizeWithAttributes:nil];
    //[node.label.text sizeWithFont:node.label.font];
    node.label.frame = CGRectMake(frame.origin.x+22, frame.origin.y, size.width, 22.f);

    return CGRectMake(frame.origin.x, frame.origin.y, node.button.frame.size.width+node.label.frame.size.width, 22.f);
}

-(void)setButtonImage:(NSString*)normalImage selImage:(NSString *)selImage {
    for (RadioNode *node in radioNodes) {
        [node.button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
        [node.button setImage:[UIImage imageNamed:selImage] forState:UIControlStateSelected];
    }
}

-(void) setRoadionEnabled:(NSUInteger) index enabled:(BOOL) enabled
{
    if(index >= radioNodes.count){
        return;
    }
    RadioNode *node = [radioNodes objectAtIndex:index];
    UIButton *button = node.button;
    button.enabled = enabled;
    UILabel *label = node.label;
    UIColor *color = (enabled)?[UIColor blackColor]:[UIColor grayColor];
    label.textColor = color;
    
}

-(void) setIndexTitle:(NSString *)title index:(NSUInteger)index
{
    if(index >= radioNodes.count){
        return;
    }
    RadioNode *node = [radioNodes objectAtIndex:index];
    UILabel *label = node.label;
    label.text = title;
}

-(NSUInteger) checkIndex
{
    return selectIndex;
}

-(void) handleButtonTap:(UIButton *)button
{
    [button setSelected:YES];
    NSUInteger index = 0;
    NSUInteger count = radioNodes.count;
    for (NSUInteger i = 0; i < count; i++) {
        RadioNode *node = [radioNodes objectAtIndex:i];
        UIButton *curButton = node.button;
        if(curButton==button){
            index = i;
        }else{
            [curButton setSelected:NO];
        }
    }
    selectIndex = index;
    if(_delegate && [_delegate respondsToSelector:@selector(radioButtonSelectedAtIndex:andIndex:)])
    {
        [_delegate radioButtonSelectedAtIndex:self andIndex:selectIndex];
    }
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
