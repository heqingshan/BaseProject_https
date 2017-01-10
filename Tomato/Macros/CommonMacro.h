//
//  CommonMacro.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#ifndef BeYou_CommonMacro_h
#define BeYou_CommonMacro_h

//通用的带一个Data数据的代码块方法声明
typedef void(^CommonDataActionBlock)(id);

//通用的带两个参数的代码块
typedef void(^CommonTwoDataActionBlock)(id,id);

//返回通用延迟时间
#define BackTimeGap 0.8

//字符串是否为空
#define STRISEMPTY(str) (str==nil || [str isEqualToString:@""])
#define ObjectIsEmpty(o) (o==nil || [o isKindOfClass:[NSNull class]])

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT    64

//自定义工具栏的高度
#define kHeightToolbar 30.0f

//TabBarHeight高度
#define TabBarHeight  48

//视图的宽度
#define WIDTH_FULL_SCREEN       ([UIScreen mainScreen].bounds.size.width)

//视图的高度
#define HEIGHT_FULL_SCREEN      ([UIScreen mainScreen].bounds.size.height)

//除导航栏和状态栏外的视图的高度
#define HEIGHT_FULL_VIEW      (([UIScreen mainScreen].bounds.size.height) - NavigationBar_HEIGHT)

//获取当前屏幕的高度
#define MainScreenHeight [UIScreen mainScreen].applicationFrame.size.height

//获取当前屏幕的宽度
#define MainScreenWidth  [UIScreen mainScreen].applicationFrame.size.width

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//----------------------系统----------------------------

// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 是否iPhone
#define isPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

//设备判断
#define IS_IPHONE_4_OR_LESS (isPhone && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (isPhone && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (isPhone && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (isPhone && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_5_OR_LESS (isPhone && SCREEN_MAX_LENGTH < 667.0)
//判断设备的操做系统是不是ios7
#define IOS7_LATER   ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)

//获取给定字符串和字体的size(单行)
#define STR_FONT_SIZE(str,font) \
(IS_IOS7)?[str sizeWithAttributes: @{NSFontAttributeName:font}\
]:[str sizeWithFont:font]

//主要单例模式
#define UserDefaults            [NSUserDefaults standardUserDefaults]
#define NotificationCenter      [NSNotificationCenter defaultCenter]
#define SharedApplication       [UIApplication sharedApplication]
#define Bundle                  [NSBundle mainBundle]
#define MainScreen              [UIScreen mainScreen]

//Application delegate
#define ApplicationDelegate     ((AppDelegate *)[[UIApplication sharedApplication] delegate]

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif
//---------------------打印日志--------------------------

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//-------------------获取设备大小-------------------------

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//Document路径
#define Document_path [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

//创建Document文件夹
#define Create_docmentPath(path) {\
NSString *documentsDirectory = Document_path;\
NSFileManager *fileManager = [NSFileManager defaultManager];\
NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:path];\
[fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil]\
}

