//
//  LeveyTabBar.h
//  LeveyTabBarController
//
//  Created by Levey Zhu on 12/15/10.
//  Copyright 2010 SlyFairy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeveyTabBarDelegate;

@interface LeveyTabBar : UIView
{
    UIImageView *_backgroundView;
    id<LeveyTabBarDelegate> __weak _delegate;
    NSMutableArray *_buttons;
    NSMutableArray *_titleLabels;
}
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, weak) id<LeveyTabBarDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) UIImageView *animatedView;

- (id)initWithFrame:(CGRect)frame buttonImages:(NSArray *)imageArray titles:(NSArray *)titleArray;
- (void)selectTabAtIndex:(NSInteger)index;
- (void)removeTabAtIndex:(NSInteger)index;
- (void)insertTabWithImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index;
- (void)setBackgroundImage:(UIImage *)img;
- (void)setBackgroundPatternImage:(UIImage *)patternImg circleImage:(UIImage *)circleImg;

@end
@protocol LeveyTabBarDelegate<NSObject>
@optional
- (BOOL)tabBar:(LeveyTabBar *)tabBar shouldSelectIndex:(NSInteger)index;
- (void)tabBar:(LeveyTabBar *)tabBar didSelectIndex:(NSInteger)index;
@end
