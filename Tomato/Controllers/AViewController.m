//
//  AViewController.m
//  Tomato
//
//  Created by qingshan on 2017/1/10.
//  Copyright © 2017年 HQS. All rights reserved.
//

#import "AViewController.h"
#import "BViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我是A页面";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickAction:(id)sender {
    BViewController *ctrl = [[BViewController alloc] initWithNibName:@"BViewController" bundle:nil];
    [self.navigationController pushViewController:ctrl animated:YES];
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
