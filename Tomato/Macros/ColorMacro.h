//
//  ColorMacro.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#ifndef BeYou_ColorMacro_h
#define BeYou_ColorMacro_h

//----------------------基础颜色方法---------------------------

//RGB
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

//RGBA
#define RGBACOLOR(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//HEX
#define HEXCOLOR(c)         ([UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f])

//----------------------基础颜色方法---------------------------


//----------------------项目颜色定义--------------------------------

//页面背景色
#define BACKGROUND_COLOR HEXCOLOR(0xf0eff5)

//局部背景色-颜色偏深
#define SUB_BACKGROUND_COLOR HEXCOLOR(0xfafafa)

//主题色
#define NavigationBg_Color HEXCOLOR(0xcb151d)

//按钮不可用背景色
#define ButtonBg_Disable_Color HEXCOLOR(0x9fa0a0)

//Tabbar颜色
#define TabbarBg_Color HEXCOLOR(0x1f1414)

//导航栏标题颜色
#define Navigation_Title_Color [UIColor whiteColor]

//导航栏左右按钮文字颜色
#define Navigation_Button_Title_Color [UIColor whiteColor]

//分割线
#define CellLine_Color HEXCOLOR(0xe6e6e6)

//浅色字体
#define Light_Text_Color HEXCOLOR(0x898989)

//简介颜色
#define Desc_Text_Color HEXCOLOR(0x595757)

//深色颜色
#define Dark_Text_Color HEXCOLOR(0x3e3a39)

//清除背景色
#define CLEARCOLOR [UIColor clearColor]


#endif
