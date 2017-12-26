//
//  QYHvodieViewController.m
//  NewProject
//
//  Created by hao on 2017/12/1.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHvodieViewController.h"
#import "QYH.h"
@interface QYHvodieViewController ()

@end

@implementation QYHvodieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor =[UIColor redColor];
    
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)viewDidLayoutSubviews
{
    CGFloat y = 0;
    self.view.qyh_y = y;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"qyhcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",self.class,indexPath.row];
    return cell;
}
@end
