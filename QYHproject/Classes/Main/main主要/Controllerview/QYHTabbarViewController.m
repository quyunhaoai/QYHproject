//
//  QYHTabbarViewController.m
//  TabBarDemo
//
//  Created by hao on 17/9/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHTabbarViewController.h"

#import "QYH.h"
@interface QYHTabbarViewController ()<QYHCustomDelegate>
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation QYHTabbarViewController
-(NSMutableArray *)items{

    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
+(void)load{
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:dict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildview];
    
    [self setupTabBar];
    
    
}

#pragma mark --QYHCustomTabBarDeletage
-(void)tabBar:(QYHCustomTabBar *)tabBar index:(NSUInteger)index{
    self.selectedIndex = index;
}
-(void)setupTabBar{
//    self.tabBar.translucent = NO;
    [self.tabBar removeFromSuperview];
    
    QYHCustomTabBar *tabBar = [[QYHCustomTabBar alloc]initWithFrame:self.tabBar.frame ];
//    tabBar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tabBar];
    tabBar.items = self.items;
    tabBar.delegate = self;
    
}
-(void)viewDidLayoutSubviews
{
    
}
-(void)setupChildview{
    
    
    QYHOneViewController *one = [[QYHOneViewController alloc] init];
    QYHBaseNavigationViewController *nav = [[QYHBaseNavigationViewController alloc] initWithRootViewController:one];
    [self setupOneViewController:nav image:[UIImage imageNamed:@"tabBar_essence_icon"] selectImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    QYHFiveViewController *fiveView = [[QYHFiveViewController alloc]init];
    QYHBaseNavigationViewController *NewNav = [[QYHBaseNavigationViewController alloc]initWithRootViewController:fiveView];
    [self setupOneViewController:NewNav image:[UIImage imageNamed:@"tabBar_new_icon"] selectImage:[UIImage imageNamed:@"tabBar_new_click_icon"] title:@"新帖"];
    
    QYHTwoViewController *two = [[QYHTwoViewController alloc]init];
    QYHBaseNavigationViewController *friendNav = [[QYHBaseNavigationViewController alloc]initWithRootViewController:two];
    [self setupOneViewController:friendNav image:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selectImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"动态"];
    
//    QYHThreeViewController *three = [[QYHThreeViewController alloc]init];
//    [self setupOneViewController:three image:[UIImage imageNamed:@"tabBar_publish_icon"] selectImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] title:@"发布"];

    UIStoryboard *MeTable = [UIStoryboard storyboardWithName:@"MeTableViewController" bundle:nil];
    MeTableViewController *meVC = [MeTable instantiateViewControllerWithIdentifier:@"MeTableViewController"];
    [self setupOneViewController:meVC image:[UIImage imageNamed:@"tabBar_me_icon"] selectImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"我"];
    



}
-(void)setupOneViewController:(UIViewController *)vc image:(UIImage *)image selectImage:(UIImage *)selectImage title:(NSString *)title;
{
    [self addChildViewController:vc];
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectImage;
    vc.tabBarItem.title = title;
    [self.items addObject:vc.tabBarItem];
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
