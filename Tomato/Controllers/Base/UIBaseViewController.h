//
//  UIBaseViewController.h
//  BeYou
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMAlertView.h"
#import "MAppHttp.h"
#import "DataCentre.h"

typedef void(^ControllerCallback)(void);

//所有新建Controller类的基类
@interface UIBaseViewController : UIViewController {
    MAppHttp        *_http;
    MBProgressHUD   *_mbProgressHud;
    SMAlertView     *_alarmMessage;
}
@property(nonatomic,assign) BOOL isPush;  //是否push 进来的
@property(nonatomic,strong) NSMutableArray *dataSource;
@property(nonatomic,strong) UIViewController *parentController;
@property(nonatomic,strong) id activity;
@property(nonatomic,assign) ControllerCallback callback;//可用于子类设置类似此种通用回调

- (NSString *)getLastViewController;

/*创建一个空页面，调用页面自行释放
 frame:非空
 image：展示图片，可空
 title：显示的空主题，可空
 desc：具体描述，可空
 */
-(UIView*)emptyViewWithFrame:(CGRect)frame image:(NSString *)imageName title:(NSString*)title desc:(NSString*)desc;

//导航栏左按钮的设置
- (void)setLeftBarButtonItemWithTitle:(NSString *)_btnTitle target:(SEL)target;
- (void)setLeftBarButtonItemWithImage:(NSString *)imageStr highlight:(NSString *)highlightImageStr target:(SEL)target;

//创建右导航栏按钮
- (void)setRightBarButtionItemWithTitle:(NSString *)_btnTitle target:(SEL)target;
- (void)setRightBarButtionItemWithImage:(NSString *)imageStr highlight:(NSString *)highlightImageStr target:(SEL)target;

//即将返回按钮事件处理，可被重写
-(void)backAction:(id)sender;
-(void)willBack;

//获取Http请求对象
-(MAppHttp *)getHttpObject;

//网络请求加载动画的现实和关闭
-(void)hudShow:(UIView *)inView msg:(NSString *)msgText;
-(void)hudClose;

//弹出非选择提醒
- (void)showString:(NSString *)String;

//指定颜色，生成对应的图片
-(UIImage *)imageWithColor:(UIColor *)color;

//关闭键盘
-(void) closeAllKeyBoard;

//创建通用按钮
- (UIButton*)createButtonWithTitle:(NSString*)title image:(UIImage*)img target:(SEL)action frame:(CGRect)rect style:(ButtonStyle)type;

@end
