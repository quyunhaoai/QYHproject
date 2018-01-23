//
//  QYHallViewController.m
//  NewProject
//
//  Created by hao on 2017/12/1.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHModel.h"
#import "QYHallViewController.h"
#import "QYHCustomTableViewCell.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

@interface QYHallViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
//@property (nonatomic, strong) UITableView *tableview;
/*网络请求*/
@property (nonatomic,strong) AFHTTPSessionManager *mgr;
@property (nonatomic, strong) NSMutableArray<QYHModel *> *tableData;
-(QYHTopicType)type;
@end
static NSString *const cellIdentifier = @"qyhcellID";
@implementation QYHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYHCustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];

    __weak typeof (self) KweakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [KweakSelf requestDownData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [KweakSelf requestUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    self.navigationController.hidesBarsOnSwipe = YES;
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
    return QYHTopicTypeAll;
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

        self.tableData = [QYHModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        
        [self.tableView.mj_header endRefreshing];
    }];
}
      /**
-(NSMutableArray *)tableData
{
    if (_tableData == nil) {
        _tableData = [NSMutableArray array];
  
        for (int i = 0; i < 20; i ++) {
            [_tableData addObject:[NSString stringWithFormat:@"%d",i]];
        }

    }
    return _tableData;
}
               **/
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"tableview%@",NSStringFromCGRect(self.tableView.frame));
//    CGFloat y = 0;
//    self.view.qyh_y = y;
//    self.tableView.qyh_y = y;
}
-(void)viewDidLayoutSubviews
{
//    CGFloat y = 0;
//    self.view.qyh_y = y;
//    self.tableView.qyh_y = y;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [SVProgressHUD dismiss];
    [self.mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}
-(void)setupTableView
{
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    
    table.contentInset = UIEdgeInsetsMake(TitleBarHeight, 0, TabBarHeight, 0);
    
//    self.tableview = table;
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
    /*
        //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
        UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
        //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
        CGFloat velocity = [pan velocityInView:scrollView].y;
        if (velocity <- 5) {
            //向上拖动，隐藏导航栏
            [self.navigationController setNavigationBarHidden:YES animated:YES];

        }else if (velocity > 5) {
            //向下拖动，显示导航栏
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }else if(velocity == 0){
            //停止拖拽
        }

    CGFloat lastcontentOffsetY = -99;
    if (scrollView.contentOffset.y -lastcontentOffsetY > NavBarHeight) {
        //        self.navigationController.navigationBar.hidden = YES;
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"setupFrame" object:nil];
        
    }else{
        
        //        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupFrameCancel" object:nil];
    }
     */
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}
@end
