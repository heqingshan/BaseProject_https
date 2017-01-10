//
//  RadioCheckButton.h
//  RadioButton
//
//  Created by sunjun on 13-7-16.
//
//

#import <UIKit/UIKit.h>

@interface RadioNode : NSObject
{
}
@property(nonatomic,retain) UIButton *button;
@property(nonatomic,retain) UILabel  *label;

- (id)initWithButton:(UIButton *)pbutton andLabel:(UILabel *)pLabel;
@end


@protocol RadioCheckButtonDelegate;
@interface RadioCheckButton : UIView
{
    NSMutableArray *radioNodes;
    NSInteger     selectIndex;

}
+(id) radionChecks:(CGRect)frame titles:(NSArray *)titles;
- (id)initWithTitlesFrame:(CGRect)frame titles:(NSArray *)titles;
-(void) setCheckIndex:(NSUInteger) index check:(BOOL) checked;
-(void) setRoadionEnabled:(NSUInteger) index enabled:(BOOL) enabled;
-(void) setIndexTitle:(NSString *)title index:(NSUInteger)index;
-(NSUInteger) checkIndex;
-(CGRect) setIndexFrame:(CGRect)frame index:(NSUInteger)index;
-(void)setButtonImage:(NSString*)normalImage selImage:(NSString *)selImage;
@property(nonatomic,assign) id<RadioCheckButtonDelegate> delegate;
@property(nonatomic,strong) id userInfo;
@end


@protocol RadioCheckButtonDelegate <NSObject>
-(void)radioButtonSelectedAtIndex:(RadioCheckButton *) checkButton andIndex:(NSUInteger)index;
@end