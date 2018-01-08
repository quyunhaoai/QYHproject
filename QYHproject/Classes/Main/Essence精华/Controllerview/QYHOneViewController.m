//
//  ViewController.m
//  UIstoryboadyLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#import "QYHOneViewController.h"
#import "MeTableViewController.h"
#import "UIView+frame.h"
#import "QYHallViewController.h"
#import "QYHmuiceViewController.h"
#import "QYHpicerViewController.h"
#import "QYHvodieViewController.h"
#import "QYHworldViewController.h"
#import "QYH.h"
CGFloat  const marin=10;
@interface QYHOneViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *myScrollView;
@property (nonatomic, weak) UIButton *currelButton;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, weak) UIView *underline;
@end

@implementation QYHOneViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    NSLog(@"scrollview:%@",NSStringFromCGRect(self.myScrollView.bounds));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精华";
    //添加自控制器
    [self addchildViews];
    //添加ScrollView
    [self setupContenView];
    //添加titleview
    [self setupTitleView];

    //添加第0个控制器View
    [self addVCtoScrollView:0];
}
-(void)addVCtoScrollView:(NSUInteger )integer
{
    UIViewController *childVc = self.childViewControllers[integer];
    
    if (childVc.isViewLoaded) return;
    
    UIView *childVcview = childVc.view;
    
    CGFloat scrollviewW = self.myScrollView.qyh_width;
    
    childVcview.frame = CGRectMake(scrollviewW * integer, 0, scrollviewW, self.myScrollView.qyh_height);
    [self.myScrollView addSubview:childVcview];
    NSLog(@"scrollviewY:%f",self.myScrollView.frame.origin.y);
}
-(void)addchildViews
{
    [self addChildViewController:[[QYHallViewController alloc]init]];
    [self addChildViewController:[[QYHvodieViewController alloc]init]];
    [self addChildViewController:[[QYHmuiceViewController alloc]init]];
    [self addChildViewController:[[QYHpicerViewController alloc]init]];
    [self addChildViewController:[[QYHworldViewController alloc]init]];
    
}
-(void)setupTitleView
{
    NSArray *titles = @[@"全部",@"视频",@"音乐",@"图片",@"段子"];
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0, bottomMargin, ScreenW, TitleBarHeight)];
    [titleview setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [self.view addSubview:titleview];
    self.titleView = titleview;
    CGFloat titleButtonW = ScreenW/5;
    
    for (int i = 0; i < 5; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat titleButtonX = titleButtonW *i;
        titleButton.tag = i;
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        titleButton.frame = CGRectMake(titleButtonX, 0, titleButtonW, titleview.frame.size.height);
        [titleButton addTarget:self action:@selector(chicktitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [titleButton setTitle:[NSString stringWithFormat:@"%@",titles[i]] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.titleView addSubview:titleButton];
    }
    

    //添加标题下划线
    [self setuptitleunderline];
    
}

-(void)chicktitleButton:(UIButton *)button
{
    NSUInteger index = button.tag;
    self.currelButton.selected = NO;
    button.selected = YES;
    self.currelButton = button;
    NSLog(@"%s",__FUNCTION__);

    [UIView animateWithDuration:0.3 animations:^{

        self.underline.qyh_width = button.titleLabel.qyh_width ;
        self.underline.qyh_center_x = button.qyh_center_x ;
        
    }];
    [self addVCtoScrollView:index];
    self.myScrollView.contentOffset = CGPointMake(self.myScrollView.qyh_width*index, 0);

    
}
-(void)viewDidLayoutSubviews
{
//    NSLog(@"%s",__FUNCTION__);
}
-(void)setuptitleunderline
{
    UIView *underline = [[UIView alloc] init];
    UIButton *button = (UIButton *)[[self.titleView subviews] firstObject];
    [button.titleLabel sizeToFit];
    CGFloat underlineX = 0;
    CGFloat underlineW = button.titleLabel.qyh_width ;
    NSLog(@"%f",underlineW);
    underline.frame = CGRectMake(underlineX, self.titleView.qyh_height-2, underlineW, 2);
    underline.backgroundColor = [button titleColorForState:UIControlStateSelected];
    button.selected = YES;
    self.currelButton = button;
    underline.qyh_center_x = button.qyh_center_x;
    underline.backgroundColor = [button titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underline];
    _underline = underline;
}
-(void)setupContenView
{
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = self.view.bounds;
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.delegate = self;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.scrollsToTop = NO;
    scrollview.bounces = NO;
    if (@available(iOS 11.0,*)) {
         scrollview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:scrollview];

    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollW = scrollview.qyh_width;
    scrollview.contentSize = CGSizeMake(count * scrollW, 0);
    self.myScrollView = scrollview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goMeView:(id)sender {
//    UIStoryboard *tableView = [UIStoryboard storyboardWithName:@"MeTableViewController" bundle:nil];
//    MeTableViewController *vc = [tableView instantiateInitialViewController];
      
    
//    [self.navigationController pushViewController:vc animated:YES];
}
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.qyh_width;
    
    // 点击对应的标题按钮
    UIButton *titleButton = (UIButton *)self.titleView.subviews[index];
    //    [self titleButtonClick:titleButton];
    [self chicktitleButton:titleButton];
}
@end
