//
//  FontMacro.h
//  Tomato
//
//  Created by HeQingshan－Air on 15/2/8.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#ifndef BeYou_FontMacro_h
#define BeYou_FontMacro_h

//通用系统字体
#define GAP_NUM     (IS_IPHONE_4_OR_LESS?0:(IS_IPHONE_5?0.5:(IS_IPHONE_6?1.5:2.5)))

#define K_Font_8    [UIFont systemFontOfSize:8.0 + GAP_NUM]
#define K_Font_10   [UIFont systemFontOfSize:10.0 + GAP_NUM]
#define K_Font_11   [UIFont systemFontOfSize:11.0 + GAP_NUM]
#define K_Font_12   [UIFont systemFontOfSize:12.0 + GAP_NUM]
#define K_Font_13   [UIFont systemFontOfSize:13.0 + GAP_NUM]
#define K_Font_14   [UIFont systemFontOfSize:14.0 + GAP_NUM]
#define K_Font_15   [UIFont systemFontOfSize:15.0 + GAP_NUM]
#define K_Font_16   [UIFont systemFontOfSize:16.0 + GAP_NUM]
#define K_Font_17   [UIFont systemFontOfSize:17.0 + GAP_NUM]
#define K_Font_18   [UIFont systemFontOfSize:18.0 + GAP_NUM]
#define K_Font_20   [UIFont systemFontOfSize:20.0 + GAP_NUM]
#define K_Font_24   [UIFont systemFontOfSize:24.0 + GAP_NUM]

//上导航字体
#define Navigation_Font K_Font_17

//下导航字体
#define Tabbar_Font K_Font_12

//SegmentControl字体大小
#define SegmentControl_Font K_Font_13

#endif
