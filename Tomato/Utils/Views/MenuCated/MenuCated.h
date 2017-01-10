//
//  MenuCated.h
//  wyzc
//
//  Created by sunjun on 14-7-28.
//  Copyright (c) 2014年 北京我赢科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ClickBlock)(NSUInteger index);

typedef enum {
    MenuCated_vertical,  //垂直排列
    MenuCated_horizontally, //水平排列
}MenuCatedStyle;


@interface MenuItem:NSObject
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) UIColor  *textColor;
@property(nonatomic,strong) UIColor  *lineColor;
@property(nonatomic,strong) UIFont   *itemFont;
+(instancetype) createMenuItem:(UIImage *)image des:(NSString *)despath;
+(instancetype) createMenuItem:(UIImage *)image des:(NSString *)despath color:(UIColor *)txtColor;
+(instancetype) createMenuItem:(UIImage *)image des:(NSString *)despath color:(UIColor *)txtColor lineColor:(UIColor *)lineColor font:(UIFont*)font;
@end


@interface MenuCated : UIView
@property(nonatomic,strong) NSArray *dataSource;
@property(nonatomic,assign) CGFloat  itemHeight;
@property(nonatomic,assign) MenuCatedStyle style;
@property(nonatomic,copy) ClickBlock  clickButton;
@property(nonatomic,strong) id        userInfo;
-(instancetype) initWithFrameForDataSource:(CGRect)frame forDataSource:(NSArray *)dataSource;

-(void) setIndexTitle:(NSString *)title forIndex:(NSUInteger)index;
-(void) setIndexImage:(UIImage *)image forIndex:(NSUInteger)index;
@end
