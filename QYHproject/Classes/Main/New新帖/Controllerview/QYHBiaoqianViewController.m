//
//  QYHBiaoqianViewController.m
//  QYHproject
//
//  Created by hao on 2018/1/3.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "QYHBiaoqianViewController.h"
#import "QYHCustomTabBar.h"
#import "QYHTagItem.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

@interface QYHBiaoqianViewController ()
/*
 数据模型数组
 */
@property (nonatomic,strong) NSArray *SubTag;
/*
 
 */
@property (nonatomic,weak) AFHTTPSessionManager *mgr;
@end

static NSString *const cellID = @"cellID";
@implementation QYHBiaoqianViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    for (UIView *vc in self.tabBarController.view.subviews) {
        if ([vc isKindOfClass:[QYHCustomTabBar class]]) {
            vc.hidden = YES;
            //            [vc removeFromSuperview];
        }
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];

    [self loadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYHTagTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:220/256.0 green:220/256.0 blue:221/256.0 alpha:1.0];
    
//    self.tableView.bounces = NO;
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [SVProgressHUD dismiss];
    
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
}
-(void)loadData
{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    _mgr = mgr;
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters [@"a"] = @"tag_recommend";
    parameters [@"action"] = @"sub";
    parameters [@"c"] = @"topic";
    NSLog(@"parameters:%@",parameters);
    [mgr GET:QYHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        _SubTag = [QYHTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        [SVProgressHUD dismiss];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}
-(void)setNavBar
{
    self.title = @"推荐标签";

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back)];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.SubTag.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYHTagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.itme = (QYHTagItem *)self.SubTag[indexPath.row];
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
