//
//  QYHFiveViewController.m
//  TabBarDemo
//
//  Created by hao on 17/9/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHFiveViewController.h"
#import "QYHBiaoqianViewController.h"
@interface QYHFiveViewController ()

@end

@implementation QYHFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.3 alpha:1.0];
    [self setupNavBar];
}
-(void)setupNavBar{
    self.title = @"新帖";

    
    // 左边按钮
    // 把UIButton包装成UIBarButtonItem.就导致按钮点击区域扩大
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagClick)];
    
    
}

#pragma mark - 点击订阅标签调用
- (void)tagClick
{
    // 进入推荐标签界面
   
    QYHBiaoqianViewController *TagVC = [[QYHBiaoqianViewController alloc]init];
    TagVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:TagVC animated:YES];
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
