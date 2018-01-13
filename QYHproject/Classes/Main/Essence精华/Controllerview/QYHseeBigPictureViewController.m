//
//  QYHseeBigPictureViewController.m
//  QYHproject
//
//  Created by hao on 2018/1/13.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "QYHseeBigPictureViewController.h"
#import "QYH.h"
#import "UIImageView+Download.h"
@interface QYHseeBigPictureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIImageView *imageview;
@end

@implementation QYHseeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollview = [[UIScrollView alloc]init];
    scrollview.frame =[UIScreen mainScreen].bounds;
//    scrollview.autoresizesSubviews = NO;
    [self.view insertSubview:scrollview atIndex:0];
    self.scrollview = scrollview;
    
    UIImageView *imageview = [[UIImageView alloc] init];
    [imageview sd_setImageWithURL:[NSURL URLWithString: _topic.image1 ] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
    }];
//    imageview.contentMode = UIViewContentModeCenter;
    imageview.qyh_width = _scrollview.qyh_width;
    imageview.qyh_height = imageview.qyh_width * _topic.height/_topic.width;
    imageview.qyh_x = 0;
    if (imageview.qyh_height > kScreenH) {
        imageview.qyh_y = 0;
        _scrollview.contentSize = CGSizeMake(0, imageview.qyh_height);
    }else{
        imageview.qyh_center_y = _scrollview.qyh_height * 0.5;
    }
    
    _imageview = imageview;
    [_scrollview addSubview:imageview];
    CGFloat maxScale = self.topic.width / imageview.qyh_width;
    if (maxScale > 1) {
        _scrollview.maximumZoomScale = maxScale;
        _scrollview.delegate = self;
    }
    
}
#pragma mark scrollview Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBackView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
