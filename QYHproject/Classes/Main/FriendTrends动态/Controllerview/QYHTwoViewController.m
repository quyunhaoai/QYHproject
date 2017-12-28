//
//  QYHTwoViewController.m
//  TabBarDemo
//
//  Created by hao on 17/9/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHTwoViewController.h"
#import "QYHLongInViewController.h"
@interface QYHTwoViewController ()

@end

@implementation QYHTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.5 blue:0.3 alpha:1.0];

    [self setupNavBar];
    
}
-(void)setupNavBar
{
    self.title = @"我的朋友";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friends)];
}
- (IBAction)login:(id)sender {
    QYHLongInViewController *longInVc = [[QYHLongInViewController alloc]initWithNibName:@"QYHLongInViewController" bundle:nil];
    [self presentViewController:longInVc animated:YES completion:nil];
}
-(void)friends{
    
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
