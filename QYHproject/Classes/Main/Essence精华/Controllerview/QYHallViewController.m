//
//  QYHallViewController.m
//  NewProject
//
//  Created by hao on 2017/12/1.
//  Copyright © 2017年 hao. All rights reserved.
//
#import "QYH.h"
#import "QYHallViewController.h"

@interface QYHallViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *tableData;
@end

@implementation QYHallViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self setupTableView];
}
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"%@",self.view.bounds);
}
-(void)setupTableView
{
    
    UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    table.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    
    table.contentInset = UIEdgeInsetsMake(TitleBarHeight, 0, TabBarHeight, 0);
    
    self.tableview = table;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"qyhcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",self.class,self.tableData[indexPath.row]];
    return cell;
}


@end
