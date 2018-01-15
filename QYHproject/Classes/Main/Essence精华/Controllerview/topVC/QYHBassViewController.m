//
//  QYHBassViewController.m
//  NewProject
//
//  Created by hao on 2017/12/1.
//  Copyright © 2017年 hao. Bass rights reserved.
//


#import "QYHBassViewController.h"
#import "QYHCustomTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

@interface QYHBassViewController ()<UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, strong) UITableView *tableview;
/*网络请求*/
@property (nonatomic,strong) AFHTTPSessionManager *mgr;
@property (nonatomic, strong) NSMutableArray<QYHModel *> *tableData;
-(QYHTopicType)type;
@end
static NSString *const cellIdentifier = @"qyhcellID";
@implementation QYHBassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYHCustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];

    __weak typeof (self) KweakSelf = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [KweakSelf requestDownData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [KweakSelf requestUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
//    self.navigationController.hidesBarsOnSwipe = YES;
}
-(AFHTTPSessionManager *)mgr
{
    if (_mgr == nil) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}
#pragma mark - 数据处理
- (QYHTopicType)type
{
    return QYHTopicTypePicture;
}
-(void)requestUpData
{
    NSLog(@"%s",__FUNCTION__);

    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    [self.mgr GET:QYHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
-(void)requestDownData
{

    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    [self.mgr GET:QYHCommonURL parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"--%@--",responseObject);
        self.tableData = [QYHModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
-(void)viewDidLayoutSubviews
{

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [SVProgressHUD dismiss];
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tableData[indexPath.row].cellHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYHCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.QYHModel = self.tableData[indexPath.row];
    return cell;
}
#pragma mark scrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",scrollView.contentOffset.y);
//    CGFloat lastcontentOffsetY = -99;
//    if (scrollView.contentOffset.y -lastcontentOffsetY > NavBarHeight) {
////        self.navigationController.navigationBar.hidden = YES;
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [[NSNotificationCenter defaultCenter]postNotificationName:@"setupFrame" object:nil];
//        
//    }else{
////        self.navigationController.navigationBar.hidden = NO;
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupFrameCancel" object:nil];
//    }
//    
}

@end
