//
//  MyNavigationController.m
//  Tomato
//
//  Created by qingshan on 2017/1/10.
//  Copyright © 2017年 HQS. All rights reserved.
//

#import "MyNavigationController.h"

@interface MyNavigationController ()<UINavigationControllerDelegate>

@end

@implementation MyNavigationController

+ (void)initialize {
    // 设置UIUINavigationBar的主题
    // 通过appearance对象能修改整个项目中所有UIBarbuttonItem的样式
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置文字
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    att[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [appearance setTitleTextAttributes:att];
    
    appearance.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -5;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}

@end
