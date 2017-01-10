//
//  LeveyTabBar.m
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 SlyFairy. All rights reserved.
//

#import "LeveyTabBar.h"

#define K_Selected_Color [UIColor blackColor]
#define K_UnSelected_Color [UIColor whiteColor]

@implementation LeveyTabBar
@synthesize backgroundView = _backgroundView;
@synthesize delegate = _delegate;
@synthesize buttons = _buttons;
@synthesize animatedView = _animatedView;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titles:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = TabbarBg_Color;
        self.alpha = 0.85f;
        _backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:_backgroundView];
        
        self.buttons = [NSMutableArray arrayWithCapacity:[imageArray count]];
        self.titleLabels = [NSMutableArray arrayWithCapacity:[imageArray count]];
        UIButton *btn;
        UILabel *label;
        CGFloat width = [UIScreen mainScreen].bounds.size.width / [imageArray count];
        for (int i = 0; i < [imageArray count]; i++)
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.showsTouchWhenHighlighted = YES;
            btn.tag = i;
            btn.frame = CGRectMake(width * i, 0, width, frame.size.height);
            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Default"] forState:UIControlStateNormal];
            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
            [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Selected"] forState:UIControlStateSelected];
            if ([[imageArray objectAtIndex:i] objectForKey:@"Selected|Highlighted"]) {
                [btn setImage:[[imageArray objectAtIndex:i] objectForKey:@"Selected|Highlighted"] forState:UIControlStateSelected | UIControlStateHighlighted];
            }
            btn.imageEdgeInsets = UIEdgeInsetsMake(-14, 0, 0, 0);
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn addTarget:self action:@selector(tabBarButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
            [btn addTarget:self action:@selector(tabBarButtonDragInside:) forControlEvents:UIControlEventTouchDragInside];
            [btn addTarget:self action:@selector(tabBarButtonDragOutside:) forControlEvents:UIControlEventTouchDragOutside];
            
            [self.buttons addObject:btn];
            [self addSubview:btn];
            
            label = [[UILabel alloc] init];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = K_UnSelected_Color;
            label.font = K_Font_10;
            label.textAlignment = NSTextAlignmentCenter;
            CGFloat titleHeight = 20;
            label.frame = CGRectMake(btn.frame.origin.x, frame.size.height - titleHeight, btn.frame.size.width, titleHeight);
            if (titleArray[i]) {
                label.text = titleArray[i];
            }
            [self.titleLabels addObject:label];
            [self addSubview:label];
        }
        
        //增加一条线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
        line.backgroundColor = CellLine_Color;
        [self addSubview:line];
    }
    return self;
}

- (void)setBackgroundImage:(UIImage *)img
{
    [_backgroundView setImage:img];
}

- (void)setBackgroundPatternImage:(UIImage *)patternImg circleImage:(UIImage *)circleImg
{
    UIImageView *leftBgImageView = [[UIImageView alloc] init];
    UIImageView *rightBgImageView = [[UIImageView alloc] init];
    UIImageView *centerBgImageView = [[UIImageView alloc] init];
    leftBgImageView.backgroundColor = [UIColor colorWithPatternImage:patternImg];
    rightBgImageView.backgroundColor = [UIColor colorWithPatternImage:patternImg];
    centerBgImageView.image = circleImg;
    leftBgImageView.frame = CGRectMake(0, -ABS(patternImg.size.height - self.frame.size.height), (self.frame.size.width - circleImg.size.width)/2, patternImg.size.height);
    centerBgImageView.frame = CGRectMake((self.frame.size.width - circleImg.size.width)/2,
                                         -ABS(patternImg.size.height - self.frame.size.height),
                                         circleImg.size.width,
                                         circleImg.size.height);
    rightBgImageView.frame = CGRectMake(CGRectGetMaxX(centerBgImageView.frame), CGRectGetMinY(leftBgImageView.frame), CGRectGetWidth(leftBgImageView.frame), CGRectGetHeight(leftBgImageView.frame));
    DLog(@"centerBgImageView %@",NSStringFromCGRect(centerBgImageView.frame));
    [_backgroundView addSubview:leftBgImageView];
    [_backgroundView addSubview:centerBgImageView];
    [_backgroundView addSubview:rightBgImageView];
}

- (void)setAnimatedView:(UIImageView *)animatedView
{
    _animatedView = animatedView;
    [self addSubview:animatedView];
}

- (void)tabBarButtonClicked:(id)sender
{
    UIButton *btn = sender;
    NSInteger index = btn.tag;
    if ([_delegate respondsToSelector:@selector(tabBar:shouldSelectIndex:)])
    {
        if (![_delegate tabBar:self shouldSelectIndex:index])
        {
            return;
        }
    }
    [self selectTabAtIndex:index];
}

- (void)tabBarButtonTouchDown:(id)sender
{
    UIButton *btn = sender;
    NSInteger index = btn.tag;
    UILabel *label = [self.titleLabels objectAtIndex:index];
    if (btn.selected) {
        label.textColor = K_Selected_Color;
    }else{
        label.textColor = K_UnSelected_Color;
    }
}

- (void)tabBarButtonDragInside:(id)sender
{
    UIButton *btn = sender;
    NSInteger index = btn.tag;
    UILabel *label = [self.titleLabels objectAtIndex:index];
    if (btn.selected) {
        label.textColor = K_Selected_Color;
    }else{
        label.textColor = K_UnSelected_Color;
    }
}

- (void)layoutSubviews
{
    DLog(@"&&& background Frame %@",NSStringFromCGRect(self.backgroundView.frame));
}

- (void)tabBarButtonDragOutside:(id)sender
{
    UIButton *btn = sender;
    NSInteger index = btn.tag;
    UILabel *label = [self.titleLabels objectAtIndex:index];
    if (btn.selected) {
        label.textColor = K_Selected_Color;
    }else{
        label.textColor = K_UnSelected_Color;
    }
}

- (void)selectTabAtIndex:(NSInteger)index
{
    for (int i = 0; i < [self.buttons count]; i++)
    {
        UIButton *b = [self.buttons objectAtIndex:i];
        UILabel *label = [self.titleLabels objectAtIndex:i];
        label.textColor = K_UnSelected_Color;
        b.selected = NO;
    }
    UIButton *btn = [self.buttons objectAtIndex:index];
    btn.selected = YES;
    UILabel *label = [self.titleLabels objectAtIndex:index];
    label.textColor = K_Selected_Color;
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [_delegate tabBar:self didSelectIndex:btn.tag];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        _animatedView.frame = CGRectMake(btn.frame.origin.x, _animatedView.frame.origin.y, _animatedView.frame.size.width, _animatedView.frame.size.height);
    }];
    
    DLog(@"Select index: %ld",(long)btn.tag);
}

- (void)removeTabAtIndex:(NSInteger)index
{
    // Remove button
    [(UIButton *)[self.buttons objectAtIndex:index] removeFromSuperview];
    [self.buttons removeObjectAtIndex:index];
    
    // Re-index the buttons
    CGFloat width = [UIScreen mainScreen].bounds.size.width / [self.buttons count];
    for (UIButton *btn in self.buttons)
    {
        if (btn.tag > index)
        {
            btn.tag --;
        }
        btn.frame = CGRectMake(width * btn.tag, 0, width, self.frame.size.height);
    }
}

- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    // Re-index the buttons
    CGFloat width = [UIScreen mainScreen].bounds.size.width / ([self.buttons count] + 1);
    for (UIButton *b in self.buttons)
    {
        if (b.tag >= index)
        {
            b.tag ++;
        }
        b.frame = CGRectMake(width * b.tag, 0, width, self.frame.size.height);
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.showsTouchWhenHighlighted = YES;
    btn.tag = index;
    btn.frame = CGRectMake(width * index, 0, width, self.frame.size.height);
    [btn setImage:[dict objectForKey:@"Default"] forState:UIControlStateNormal];
    [btn setImage:[dict objectForKey:@"Highlighted"] forState:UIControlStateHighlighted];
    [btn setImage:[dict objectForKey:@"Selected"] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttons insertObject:btn atIndex:index];
    [self addSubview:btn];
}


@end
