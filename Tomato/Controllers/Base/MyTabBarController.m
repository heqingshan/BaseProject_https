//
//  MyTabBarController.m
//  Tomato
//
//  Created by qingshan on 2017/1/10.
//  Copyright © 2017年 HQS. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyNavigationController.h"
#import "AViewController.h"
#import "BViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

+ (void)initialize {
    // 设置tabbarItem的普通文字
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [[UIColor alloc]initWithRed:113/255.0 green:109/255.0 blue:104/255.0 alpha:1];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    //设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.backgroundImage = [[UIImage alloc] imageWithColor:TabbarBg_Color];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self addAllChildVc];
    // 隐藏 tabBar 上方分隔线的做法 － 现在有些应用程序的自定义 TabBar 会遇到，分享一下 :D
    self.tabBar.shadowImage = [[UIImage alloc] init];
}

#pragma mark - 设置子控制器
/**
 *  添加所有的子控制器
 */
- (void)addAllChildVc {
    // 添加初始化子控制器 BXHomeViewController
    AViewController *orderCtrl = [[AViewController alloc] initWithNibName:@"AViewController" bundle:nil];
    [self addOneChildVC:orderCtrl title:@"A" imageName:@"tab_home_normal" selectedImageName:@"fanqie"];
    
    BViewController *productCtrl = [[BViewController alloc] initWithNibName:@"BViewController" bundle:nil];
    [self addOneChildVC:productCtrl title:@"B" imageName:@"tab_home_normal" selectedImageName:@"fanqie"];
}


/**
 *  添加一个自控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */

- (void)addOneChildVC:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题
    childVc.tabBarItem.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 不要渲染
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    MyNavigationController *nav = [[MyNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

@end
