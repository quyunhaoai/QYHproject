//
//  MeTableViewController.m
//  UIstoryboadyLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "MeTableViewController.h"
#import "CustomCollectionViewCell.h"
#import "person.h"
#import "QyhAlterView.h"
#import "QYHSettingTableViewController.h"
#import "QYHCustomTabBar.h"
static NSString *const ID = @"cellid";
@interface MeTableViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *CollectionData;
@end

@implementation MeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条
    [self setupNavBar];
    //设置footView
    [self setupFootView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));

}
-(void)setupNavBar
{
    self.title = @"我";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setViewControllers)];
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] highImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night)];
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
}
-(void)setViewControllers{
    QYHSettingTableViewController *setVC = [[QYHSettingTableViewController alloc]init];
    setVC.hidesBottomBarWhenPushed = YES;
//    for (UIView *vc in self.tabBarController.view.subviews) {
//        if ([vc isKindOfClass:[QYHCustomTabBar class]]) {
//            vc.hidden = YES;
//        }
//    }
    [self.navigationController pushViewController:setVC animated:YES];
}
-(void)night{
    
}
#pragma mark TableView-Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableCellRowHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
    [QyhAlterView showAlterViewStatue:AlterViewStatueNORMALSTYLE message:@"开发中" topImageUrl:@"header_cry_icon" cancelButtonTitle:@"Cancel" otherButtonTitle:@"Done" times:5 onDismiss:^(NSInteger buttonIndex) {
        
    } onCancel:^{
        
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)setupFootView
{
    /*
     1.初始化要设置流水布局
     2.cell必须要注册
     3.cell必须自定义
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    NSInteger number = 4;
    CGFloat margin = 1;
    CGFloat itmesWH = ([UIScreen mainScreen].bounds.size.width - (number - margin))/number;

    layout.itemSize = CGSizeMake(itmesWH, itmesWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 350) collectionViewLayout:layout];

    collectionview.backgroundColor = self.tableView.backgroundColor;
    
    self.tableView.tableFooterView = collectionview;
    
    collectionview.delegate = self;
    collectionview.dataSource = self;
    collectionview.scrollEnabled = NO;

    [collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ID];
    
    _CollectionData = [NSMutableArray array];
    for (int i = 0; i < 12; i ++) {
        person *head = [[person alloc] init];
        head.iconUrl = @"defaultUserIcon";
        head.name = [NSString stringWithFormat:@"qyh%d",i];
        [_CollectionData addObject:head];
    }
    
}
- (IBAction)returnTopController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UIcollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.CollectionData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.Head = self.CollectionData[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__FUNCTION__);
    [QyhAlterView showAlterViewStatue:AlterViewStatueNORMALSTYLE message:@"开发中" topImageUrl:@"header_cry_icon" cancelButtonTitle:@"Cancel" otherButtonTitle:@"Done" times:5  onDismiss:^(NSInteger buttonIndex) {
        
    } onCancel:^{
        
    }];
    
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
