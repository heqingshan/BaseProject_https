//
//  UIBasePageViewController.m
//  BeYou
//
//  Created by qingshan on 16/3/25.
//  Copyright © 2016年 HQS. All rights reserved.
//

#import "UIBasePageViewController.h"

@interface UIBasePageViewController ()

@end

@implementation UIBasePageViewController
@synthesize currentPageCount,isLoadMore,hasMoreData,totalPageCount,pageSize;
@synthesize showFooterControl,showHeaderControl;

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPageCount = 1;
    pageSize = 20;
    isLoadMore = NO;
    hasMoreData = YES;
    //添加表格头部和尾部
    self.showHeaderControl = NO;
    self.showFooterControl = NO;
}

- (void)setShowHeaderControl:(BOOL)aShowHeaderControl {
    showHeaderControl = aShowHeaderControl;
    if (showHeaderControl) {
        self.myTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(hairRefreshHeader)];
    }
    else {
        self.myTableView.header = nil;
    }
}

- (void)setShowFooterControl:(BOOL)aShowFooterControl {
    showFooterControl = aShowFooterControl;
    if (showFooterControl) {
        self.myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(hairLoadMoreData)];
    }
    else {
        self.myTableView.footer = nil;
    }
}

- (void)requestDataFromServer:(void (^)(BOOL flag))block {
    
}

- (void)finishTableViewLoading {
    if (self.isLoadMore) {
        [self.myTableView.footer endRefreshing];
    }
    else {
        [self.myTableView.header endRefreshing];
    }
}

#pragma mark - 下拉刷新视图
- (void)hairRefreshHeader
{
    currentPageCount = 1;
    hasMoreData = YES;
    isLoadMore = NO;
    [self requestDataFromServer:nil];
    [self.myTableView.footer resetNoMoreData];
}

#pragma mark - 上拉加载视图
- (void)hairLoadMoreData
{
    if (currentPageCount < totalPageCount) {
        currentPageCount += 1;
        isLoadMore = YES;
        [self requestDataFromServer:nil];
    }else{
        [self.myTableView.footer noticeNoMoreData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
