//
//  UIBaseTableViewController.m
//  UTeam
//
//  Created by qingshan on 15/5/9.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "UIBaseTableViewController.h"

@interface UIBaseTableViewController (){
    UIView *emptyView;
}

@end

@implementation UIBaseTableViewController
@synthesize myTableView,tableStyle;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FULL_SCREEN, HEIGHT_FULL_VIEW) style:tableStyle];
    myTableView.backgroundColor = BACKGROUND_COLOR;
    myTableView.dataSource = self;
    myTableView.delegate = self;
    if (IOS7_LATER) {
        myTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        myTableView.separatorInset = UIEdgeInsetsZero;
    }
    myTableView.separatorColor = CellLine_Color;
    myTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:myTableView];
}

- (void)reloadTableView {
    [self.myTableView reloadData];
}

- (void)addEmptyViewWithImage:(NSString*)imageName title:(NSString*)title desc:(NSString*)desc
{
    if (emptyView == nil) {
        emptyView = [self emptyViewWithFrame:CGRectMake(0, 0, WIDTH_FULL_SCREEN, self.myTableView.height * 0.8f) image:imageName title:title desc:desc];
    }
    else {
        [emptyView removeFromSuperview];
    }
    if (self.dataSource.count <= 0) {
        [self.myTableView addSubview:emptyView];
    }
}

- (void)updateFrame:(CGRect)rect {
    self.view.frame = rect;
    self.myTableView.frame = self.view.bounds;
    DLog(@"self.view.frame:%@", NSStringFromCGRect(self.view.frame));
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CommonCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
