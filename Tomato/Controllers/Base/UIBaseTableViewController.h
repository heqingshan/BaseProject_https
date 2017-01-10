//
//  UIBaseTableViewController.h
//  UTeam
//
//  Created by qingshan on 15/5/9.
//  Copyright (c) 2015年 HQS. All rights reserved.
//

#import "UIBaseViewController.h"

@interface UIBaseTableViewController : UIBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,assign) UITableViewStyle tableStyle;//指定表格样式

- (void)reloadTableView;
//添加空页面
- (void)addEmptyViewWithImage:(NSString*)imageName title:(NSString*)title desc:(NSString*)desc;

//更新view和tableView的frame
- (void)updateFrame:(CGRect)rect;

@end
