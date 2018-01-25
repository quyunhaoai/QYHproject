//
//  QYHPictureview.m
//  QYHproject
//
//  Created by hao on 2018/1/12.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "QYHPictureview.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Download.h"
#import "QYHseeBigPictureViewController.h"
#import "QYH.h"
#import "UIImageView+FitNet.h"


@interface QYHPictureview()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderview;
@property (weak, nonatomic) IBOutlet UIImageView *gifview;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end
@implementation QYHPictureview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigpicture)]];
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    self.imageView.clipsToBounds = YES;
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}
-(void)seeBigpicture{
    QYHseeBigPictureViewController *seeVc = [[QYHseeBigPictureViewController alloc] init];
    seeVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeVc animated:YES completion:nil];
}
-(void)setTopic:(QYHModel *)topic
{
    _topic = topic;
    self.placeholderview.hidden = NO;
    NSURL *bigpictureUrl = [NSURL URLWithString:topic.image1];
    NSURL *smalepictureUrl = [NSURL URLWithString:topic.image0];
    self.ringProgressView.hidden = self.topic.downloadPictureProgress >=1;
    __weak typeof (self) weakSelf = self;
    [self.imageView lmj_setImageWithURL:bigpictureUrl thumbnailImageURL:smalepictureUrl placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        // 3.3储存 "每个模型" 的进度
        topic.downloadPictureProgress = (CGFloat)receivedSize / expectedSize;
        
        
        // 3.4给每个cell对应的模型进度赋值
        [weakSelf.ringProgressView setProgress:weakSelf.topic.downloadPictureProgress animated:NO];
        

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) weakSelf.placeholderview.hidden = YES;
        // 4, 处理大图, 必须是当前的模型
        if (!image || error || !weakSelf.topic.isBigPicture || weakSelf.topic != topic ) {
            
            return ;
            
        }

        // 4.1 裁剪
        // 只要设置图片就会调用
        // 控制隐藏, 当是当前的模型的时候才隐藏
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            UIGraphicsBeginImageContextWithOptions(weakSelf.topic.middleViewFrame.size, NO, 0);
            
            CGFloat w = weakSelf.topic.middleViewFrame.size.width;
            
            
            CGFloat h = w * weakSelf.topic.height / weakSelf.topic.width;
            
            
            [image drawInRect:CGRectMake(0, 0, w, h)];
            
            UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                weakSelf.imageView.image = newImage;

            });
            
        });
        
    }];
 
}
- (IBAction)SeeBigPciture:(id)sender {
    
    QYHseeBigPictureViewController *seeVc = [[QYHseeBigPictureViewController alloc] init];
    seeVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeVc animated:YES completion:nil];
}
- (M13ProgressViewRing *)ringProgressView
{
    if(_ringProgressView == nil)
    {
        M13ProgressViewRing *ringProgressView = [[M13ProgressViewRing alloc] init];
        [self insertSubview:ringProgressView belowSubview:self.imageView];
        _ringProgressView = ringProgressView;
        
        
        /**@name Appearance*/
        /**The primary color of the `M13ProgressView`.*/
        //        @property (nonatomic, retain) UIColor *primaryColor;
        //        *The secondary color of the `M13ProgressView`.
        //        @property (nonatomic, retain) UIColor *secondaryColor;
        //
        //        *@name Properties
        //        *Wether or not the progress view is indeterminate.
        //        @property (nonatomic, assign) BOOL indeterminate;
        //        *The durations of animations in seconds.
        //        @property (nonatomic, assign) CGFloat animationDuration;
        
        
        ringProgressView.backgroundRingWidth = 5;
        ringProgressView.progressRingWidth = 5;
        ringProgressView.showPercentage = YES;
        ringProgressView.primaryColor = [UIColor redColor];
        ringProgressView.secondaryColor = [UIColor yellowColor];
        
//        [ringProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.center.centerOffset(CGPointZero);
//            make.size.mas_equalTo(CGSizeMake(80, 80));
//        }];
        ringProgressView.frame = CGRectMake(0, 0, 80, 80);
        ringProgressView.center = self.imageView.center;
        
    }
    return _ringProgressView;
}

@end
