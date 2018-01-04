//
//  CustomerViewController.m
//  xibLearn
//
//  Created by hao on 2017/11/21.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "CustomerViewController.h"
#import "QYHTabbarViewController.h"
#import "CustomDoneBtn.h"
@interface CustomerViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchScreen;
@property (retain, nonatomic) UIImageView *customPrepLoadingActView;
@property (weak, nonatomic) IBOutlet CustomDoneBtn *mybutton;
@property (weak, nonatomic) NSTimer *timer;
@end


@implementation CustomerViewController

- (IBAction)chickAction:(id )sender {
    QYHTabbarViewController *vc = [[QYHTabbarViewController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    [self.timer invalidate];
    
}

- (UIImageView *)customPrepLoadingActView {
    if (!_customPrepLoadingActView) {
        _customPrepLoadingActView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"newviewpagerprogress"]];
        _customPrepLoadingActView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2+100);
        _customPrepLoadingActView.bounds = CGRectMake(0, 0, 25, 25);
    }
    return _customPrepLoadingActView;
}
- (void)startAnimation:(float)imageviewAngle
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(imageviewAngle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.customPrepLoadingActView.transform = endAngle;
    } completion:^(BOOL finished) {
        float angle = imageviewAngle;
        angle += 5;
        [self startAnimation:angle];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startAnimation:0];
    
    [self.view addSubview:self.customPrepLoadingActView];
    
    UIImage * image = [self getTheLaunchImage];
    self.LaunchScreen.image = image;
    
    self.mybutton.layer.cornerRadius = 6;
    self.mybutton.layer.masksToBounds = YES;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    /*
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loadInView)];
    [self.view addGestureRecognizer:tap];
    */
}
-(void)loadInView
{
    QYHTabbarViewController *vc = [[QYHTabbarViewController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    [self.timer invalidate];
}
- (UIImage *)getTheLaunchImage
{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown) || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    } else {
        viewOrientation = @"Landscape";
    }
    
    
    NSString *launchImage = nil;
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    return [UIImage imageNamed:launchImage];
    
}
-(void)timerAction
{
    NSLog(@"%s",__FUNCTION__);
    static int i = 10;
    if (i == 0) {
        [self chickAction:nil];
    }
    i --;
    [self.mybutton setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
    
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
