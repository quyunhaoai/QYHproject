//
//  QYHLongInViewController.m
//  xibLearn
//
//  Created by hao on 2017/11/25.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHLongInViewController.h"
#import "QYHCustomLonginview.h"
#import "QYHfastLongin.h"
#import "UIView+frame.h"
@interface QYHLongInViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstraints;

@end

@implementation QYHLongInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    /*创建登录界面*/
    QYHCustomLonginview *longVc = [QYHCustomLonginview fastLoadLongView];
    /*添加登录页面*/
    [self.middleView addSubview:longVc];
    /*创建注册界面*/
    QYHCustomLonginview *registerVc = [QYHCustomLonginview fastRegisterView];
    
    registerVc.qyh_x = self.middleView.qyh_width * 0.5;
    //添加注册页面
    [self.middleView addSubview:registerVc];
    
    QYHfastLongin *fastLongInVc = [QYHfastLongin fastThirdLonginVC];
    
    [self.bottomView addSubview:fastLongInVc];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    
    
}


-(void)viewDidLayoutSubviews
{
    // 一定要调用super
    [super viewDidLayoutSubviews];
    
    // 设置登录view
    QYHCustomLonginview *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.qyh_width * 0.5, self.middleView.qyh_height);
    
//    // 设置注册view
    QYHCustomLonginview *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake( self.middleView.qyh_width * 0.5, 0,self.middleView.qyh_width * 0.5, self.middleView.qyh_height);
    
    // 设置快速登录
    QYHfastLongin *fastLoginView = self.bottomView.subviews.firstObject;
    fastLoginView.frame = self.bottomView.bounds;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeVC:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)zhuce:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    _leadConstraints.constant = self.leadConstraints.constant == 0 ? -(self.middleView.qyh_width * 0.5) :0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];
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
