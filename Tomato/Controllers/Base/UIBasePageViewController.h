//
//  UIBasePageViewController.h
//  BeYou
//
//  Created by qingshan on 16/3/25.
//  Copyright © 2016年 HQS. All rights reserved.
//

#import "UIBaseTableViewController.h"

//带翻页的基类
@interface UIBasePageViewController : UIBaseTableViewController

@property(nonatomic,assign) NSInteger totalPageCount;
@property(nonatomic,assign) NSInteger currentPageCount;
@property(nonatomic,assign) NSInteger pageSize;
@property(nonatomic,assign) BOOL isLoadMore;
@property(nonatomic,assign) BOOL hasMoreData;

//控制是否显示下拉刷新和上拉加载组件。默认都为NO
@property(nonatomic,assign) BOOL showHeaderControl;
@property(nonatomic,assign) BOOL showFooterControl;

//加载服务器数据
- (void)requestDataFromServer:(void (^)(BOOL flag))block;

//结束加载操作
- (void)finishTableViewLoading;

//刷新头部和尾部
- (void)hairRefreshHeader;
- (void)hairLoadMoreData;

@end
