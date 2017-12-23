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
CGFloat  const marin=10;
@interface QYHOneViewController ()
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIButton *currelButton;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, weak) UIView *underline;
@end

@implementation QYHOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"精华";
    //添加ScrollView
    [self setupContenView];
    //添加titleview
    [self setupTitleView];

}

-(void)setupTitleView
{
    NSArray *titles = @[@"新闻",@"视频",@"音乐",@"小说",@"社会"];
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    [titleview setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [self.scrollview addSubview:titleview];
    self.titleView = titleview;
    CGFloat titleButtonW = ScreenW/5;
    
    for (int i = 0; i < 5; i ++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat titleButtonX = titleButtonW *i;
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
    self.currelButton.selected = NO;
    button.selected = YES;
    self.currelButton = button;
    NSLog(@"%s",__FUNCTION__);

    [UIView animateWithDuration:0.3 animations:^{

        self.underline.qyh_width = button.titleLabel.qyh_width ;
        self.underline.qyh_center_x = button.qyh_center_x ;
        
    }];
    
    
}
-(void)setuptitleunderline
{
    UIView *underline = [[UIView alloc] init];
    UIButton *button = [[self.titleView subviews] firstObject];
    NSString *currenttile = button.currentTitle;
    CGFloat underlineX = 0;
    CGFloat underlineW = button.titleLabel.qyh_width ;
    NSLog(@"%f",underlineW);
    underline.frame = CGRectMake(underlineX, self.titleView.qyh_height-2, underlineW, 2);
    underline.backgroundColor = [button titleColorForState:UIControlStateSelected];
    button.selected = YES;
    self.currelButton = button;
    [self.titleView addSubview:underline];
    _underline = underline;
}
-(void)setupContenView
{
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollview.backgroundColor = [UIColor yellowColor];
    _scrollview = scrollview;
    [self.view addSubview:scrollview];
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

@end
