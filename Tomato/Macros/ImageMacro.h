//
//  ImageMacro.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#ifndef BeYou_ImageMacro_h
#define BeYou_ImageMacro_h


//----------------------基本图片方法----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(imageName) [UIImage imageNamed:imageName]

//----------------------基本图片方法----------------------------
#define IMG_Hide_KeyBoard @"arrow_down_cerification_pc"

//----------------------项目图片资源----------------------------



//----------------------项目图片资源----------------------------


#endif
