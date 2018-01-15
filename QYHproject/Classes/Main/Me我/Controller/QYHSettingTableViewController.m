//
//  QYHSettingTableViewController.m
//  QYHproject
//
//  Created by hao on 2018/1/3.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "QYHSettingTableViewController.h"
#import "QYHCustomTabBar.h"
#import "QYH.h"
@interface QYHSettingTableViewController ()<UITabBarDelegate,UITableViewDataSource>
/*
 缓存大小
 */
@property (nonatomic,assign) NSUInteger CachesSize;
@end

static NSString *const cellID = @"cellID";
@implementation QYHSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBar];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSString *cachePath = [QYHTools getCachesPath];

    __weak typeof (self) KweakSelf = self;
    [QYHTools getFileSize:cachePath completion:^(NSInteger size) {
        KweakSelf.CachesSize =size;
        [self.tableView reloadData];
    }];
    NSLog(@"documents:%@",[QYHTools documentsPath]);
}
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
-(void)setNavBar
{
    self.title = @"设置";
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [self sizeStr];
    // Configure the cell...
    
    return cell;
}
-(NSString *)sizeStr{
    NSString *sizeStr = @"清除缓存";
    NSInteger size = _CachesSize;
    if (size > 1000 *1000) {
        //MB
        CGFloat sizeF = size / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    }else if (size > 1000){
        //KB
        CGFloat sizeF = size / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    }else if (size > 0 ){
        //B

        sizeStr = [NSString stringWithFormat:@"%@(%ldB)",sizeStr,size];
    }
    return sizeStr;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [QYHTools removeDirectoryPath:[QYHTools getCachesPath]];
    _CachesSize = 0;
    [self.tableView reloadData];
    [QyhAlterView showAlterViewStatue:AlterViewStatueNORMALSTYLE message:@"已清除" topImageUrl:@"pushguidebot" cancelButtonTitle:@"cancel" otherButtonTitle:@"Done" times:3 onDismiss:^(NSInteger buttonIndex) {
        
    } onCancel:^{
        
    }];
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
