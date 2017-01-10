//
//  PosterShareView.m
//  wyzc
//
//  Created by WYZC on 15/11/11.
//  Copyright © 2015年 北京我赢科技有限公司. All rights reserved.
//

#import "PosterShareView.h"

#define wSpace WIDTH_FULL_SCREEN / 4
#define ySpace 80.5f
#define concelBtnH 50.f

@interface PosterShareView ()
{
    NSArray * titlesA;
    NSArray * imagesA;
    NSInteger rowCount;
    UIButton * coverBtn;
}
@end

@implementation PosterShareView
-(instancetype)initWithFrame:(CGRect)frame Title:(NSArray *)titleArray Image:(NSArray *)imagesArray{
    self = [super initWithFrame:frame];
    titlesA = titleArray;
    imagesA = imagesArray;
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        rowCount = titlesA.count / 4 + (titlesA.count == 4?0:1);
        [self createCverView];
        [self ctreateBtns];
    }
    return self;
}
-(void)createCverView {
    //遮罩层
    coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    coverBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    coverBtn.frame = CGRectMake(0, 0, WIDTH_FULL_SCREEN, HEIGHT_FULL_SCREEN - rowCount*ySpace - concelBtnH);
    [coverBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:coverBtn];
}
-(void)tap{
    if (_disMissBlock) {
        _disMissBlock();
    }
}
-(void)ctreateBtns {
    CGFloat iconW = 30.f;
    CGFloat yOffset = 35;
    CGFloat buttonsViewHeight = rowCount*ySpace + yOffset + 5;
    UIView * btnsView = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_FULL_SCREEN - buttonsViewHeight - concelBtnH, WIDTH_FULL_SCREEN, buttonsViewHeight)];
    btnsView.backgroundColor = HEXCOLOR(0xffffff);
    [self addSubview:btnsView];
    //添加“分享到”
    UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH_FULL_SCREEN - 20, yOffset)];
    titleLb.backgroundColor = [UIColor clearColor];
    titleLb.text = @"分享到";
    titleLb.textColor = Dark_Text_Color;
    titleLb.font = K_Font_13;
    [btnsView addSubview:titleLb];
    //添加按钮
    for (NSInteger i = 0;i < titlesA.count;i++){
        NSInteger x = i%4;
        NSInteger y = i/4;
        UIView * v1 = [[UIView alloc]init];
        v1.frame = CGRectMake(wSpace*x,ySpace*y+yOffset, wSpace, ySpace);
        v1.backgroundColor = [UIColor clearColor];
        [btnsView addSubview:v1];
        
        UIControl * control = [[UIControl alloc]initWithFrame:v1.bounds];
        [control addTarget:self action:@selector(tapTitle:) forControlEvents:UIControlEventTouchUpInside];
        control.tag = [self marryTag:titlesA[i]];
        control.backgroundColor = [UIColor clearColor];
        [v1 addSubview:control];
        [v1 bringSubviewToFront:control];
        
        UIImageView * imgV = [[UIImageView alloc]init];
        imgV.frame = (CGRect){(v1.frame.size.width-iconW)/2,13.f,iconW,iconW};
        imgV.image = [UIImage imageNamed:imagesA[i]];
        imgV.clipsToBounds = YES;
        imgV.backgroundColor = [UIColor clearColor];
        [v1 addSubview:imgV];
        UILabel * nameL = [[UILabel alloc]initWithFrame:CGRectMake(0, imgV.bottom, v1.frame.size.width, ySpace-imgV.bottom - 5)];
        nameL.font = [UIFont systemFontOfSize:10];
        nameL.textAlignment = NSTextAlignmentCenter;
        nameL.textColor = Desc_Text_Color;
        nameL.text = titlesA[i];
        nameL.backgroundColor = [UIColor clearColor];
        [v1 addSubview:nameL];
    }
    UIButton * concleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    concleBtn.backgroundColor = [UIColor whiteColor];
    [concleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [concleBtn setTitleColor:Dark_Text_Color forState:UIControlStateNormal];
    concleBtn.frame = CGRectMake(0, HEIGHT_FULL_SCREEN-concelBtnH, WIDTH_FULL_SCREEN, concelBtnH);
    [concleBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:concleBtn];
    
    //添加分割线
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, concleBtn.top, WIDTH_FULL_SCREEN, 0.5)];
    line.backgroundColor = CellLine_Color;
    [self addSubview:line];
}

-(ShareType)marryTag:(NSString *)title{
    if ([title isEqualToString:@"微信好友"]) {
        return ShareType_Wechat;
    }else if ([title isEqualToString:@"朋友圈"]){
        return ShareType_WechatTimeline;
    }else if ([title isEqualToString:@"QQ好友"]){
        return ShareType_QQ;
    }else if ([title isEqualToString:@"QQ空间"]){
        return ShareType_QQZone;
    }else if ([title isEqualToString:@"新浪微博"]){
        return ShareType_sina;
    }else if ([title isEqualToString:@"短信"]){
        return ShareType_message;
    }else if ([title isEqualToString:@"邮箱"]){
        return ShareType_email;
    }else if ([title isEqualToString:@"腾讯微博"]){
        return ShareType_TententWB;
    }else if ([title isEqualToString:@"复制链接"]){
        return ShareType_Copy;
    }
    return ShareType_None;
}
-(void)tapTitle:(UIControl *)sender{
    if (_share_block) {
        _share_block(sender.tag);
    }
}

@end
