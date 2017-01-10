//
//  PromptBoxViewWithMessage.h
//  UTeam
//
//  Created by qingshan on 15/5/10.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface PromptBoxViewWithMessage : UIView
{
    UIWindow * keyWindow;
}
@property(nonatomic,assign)NSInteger second;
-(void)showMessage:(NSString *)msg;
- (void)showMessage1:(NSAttributedString *)msg;
- (void)showRewardMessage:(NSString *)msg;
@end
