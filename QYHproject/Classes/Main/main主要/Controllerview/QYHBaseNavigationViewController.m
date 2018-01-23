//
//  QYHBaseViewController.m
//  TabBarDemo
//
//  Created by hao on 2017/11/20.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHBaseNavigationViewController.h"
#import "UIBarButtonItem+Item.h"
@interface QYHBaseNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation QYHBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/**iOS7之后是有侧滑返回手势功能的。注意，也就是说系统已经定义了一种手势，并且给这个手势已经添加了一个触发方法（重点）。但是，系统的这个手势的触发条件是必须从屏幕左边缘开始滑动。我们取巧的方法是自己写一个支持全屏滑动的手势，而其触发方法系统已经有，没必要自己实现pop的动画，所以直接就把系统的触发处理方法作为我们自己定义的手势的处理方法。**/
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    // 控制手势什么时候触发,只有非根控制器才需要触发手势
    pan.delegate = self;
    
    // 禁止之前手势
    self.interactivePopGestureRecognizer.enabled = NO;
    
    // 假死状态:程序还在运行,但是界面死了.
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void)load{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 只要是通过模型设置,都是通过富文本设置
    // 设置导航条标题 => UINavigationBar
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:16];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark - UIGestureRecognizerDelegate
// 决定是否触发手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置返回按钮,只有非根控制器
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
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
