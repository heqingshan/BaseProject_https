//
//  MenuCated.m
//  wyzc
//
//  Created by sunjun on 14-7-28.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import "MenuCated.h"

@interface MenuItem ()
{
    
}
@end


@implementation MenuItem

+(instancetype) createMenuItem:(UIImage *)image des:(NSString *)despath
{
    MenuItem *item = [[MenuItem alloc] init];
    item.image = image;
    item.text = despath;
    item.textColor = [UIColor whiteColor];
    item.lineColor = [UIColor darkGrayColor];
    return item;
}
+(instancetype) createMenuItem:(UIImage *)image des:(NSString *)despath color:(UIColor *)txtColor
{
    MenuItem *item = [MenuItem createMenuItem:image des:despath];
    item.textColor = txtColor;
    return item;
}
+(instancetype) createMenuItem:(UIImage *)image des:(NSString *)despath color:(UIColor *)txtColor lineColor:(UIColor *)lineColor font:(UIFont*)font
{
    MenuItem *item = [[MenuItem alloc] init];
    item.image = image;
    item.text = despath;
    item.textColor = txtColor;
    item.lineColor = lineColor;
    item.itemFont = font;
    return item;
}

@end

@interface MenuCated ()
{
    NSMutableArray *_buttons;
    NSMutableArray *_lineViews;
}
@end

@implementation MenuCated

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(instancetype) initWithFrameForDataSource:(CGRect)frame forDataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataSource;
        [self stup];
    }
    return self;

}


-(void) stup
{
    _buttons = [[NSMutableArray alloc] init];
    _lineViews = [NSMutableArray array];
    NSUInteger count = self.dataSource.count;
    for (NSUInteger i = 0; i < count; i++) {
        MenuItem *item = [self.dataSource objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (item.image) {
            [button setImage:item.image forState:UIControlStateNormal];
        }
        if (item.text && item.text.length > 0) {
            [button setTitle:item.text forState:UIControlStateNormal];
            [button setTitleColor:item.textColor forState:UIControlStateNormal];
        }
        if (item.itemFont) {
            [button.titleLabel setFont:item.itemFont];
        }
        [button setShowsTouchWhenHighlighted:YES];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttons addObject:button];
        if (i < count-1) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = item.lineColor;
            [_lineViews addObject:view];
            [self addSubview:view];
        }
        [self addSubview:button];
    }
}

-(void) setStyle:(MenuCatedStyle)style
{
    _style = style;
    [self layoutIfNeeded];
}

-(void) layoutSubviews
{
    NSUInteger count = _buttons.count;
    CGFloat x = 0.f,y = 0.f,width = self.frame.size.width/count,height = _itemHeight;
    CGFloat vx = 0.f,vy = 0.f,vwidth = 0.f,vheight = 0.f;
    //垂直
    if(_style == MenuCated_vertical){
        width = self.frame.size.width;
        height = (self.frame.size.height - _lineViews.count*1)/count;
        vwidth = self.frame.size.width;
        vheight = 1.f;
    }else{
        width = (self.frame.size.width - _lineViews.count*1)/count;
        height = self.frame.size.height;
        
        vwidth = 1.f; vheight = self.frame.size.height;
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button =  [_buttons objectAtIndex:i];
        [button setFrame:CGRectMake(x, y, width, height)];
        if(_style == MenuCated_vertical){
            vy += height;
            y += (height+1);
            
        }else{
            vx += width;
            x += (width +1);
        }
        if (i < count-1){
            UIView *view = [_lineViews objectAtIndex:i];
            view.frame = CGRectMake(vx, vy, vwidth, vheight);
        }
    }
}

-(void) buttonClick:(id) sender
{
    if(_clickButton){
        _clickButton([_buttons indexOfObject:sender]);
    }
}

-(void) setIndexTitle:(NSString *)title forIndex:(NSUInteger)index
{
    if (_buttons.count > index) {
        UIButton *button = [_buttons objectAtIndex:index];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

-(void) setIndexImage:(UIImage *)image forIndex:(NSUInteger)index
{
    if (_buttons.count > index) {
        UIButton *button = [_buttons objectAtIndex:index];
        [button setImage:image forState:UIControlStateNormal];
    }
}

@end
