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
    self.imageView.contentMode = UIViewContentModeTop;
    self.imageView.clipsToBounds = YES;
}
-(void)seeBigpicture{
    NSLog(@"%s",__FUNCTION__);
    QYHseeBigPictureViewController *seeVc = [[QYHseeBigPictureViewController alloc] init];
    seeVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeVc animated:YES completion:nil];
}
-(void)setTopic:(QYHModel *)topic
{
    _topic = topic;
    self.placeholderview.hidden = NO;
    
    [self.imageView qyh_setOriginImage:_topic.image1 thumbnailImage:_topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.placeholderview.hidden = YES;
        if (_topic.isBigPicture) {
            /**/
            CGFloat imageW = topic.middleViewFrame.size.width;
            CGFloat imageH = imageW * topic.height / topic.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
            /* */
//            self.imageView.image = [QYHTools ct_imageFromImage:image inRect:CGRectMake(0, 0, topic.middleViewFrame.size.width, 200)];
        }
        
    }];
    
//    self.gifview.hidden = !topic.is_gif;
    self.gifview.hidden = YES;
    // 点击查看大图
//    if (topic.isBigPicture) { // 超长图
//        self.seeBigPictureButton.hidden = NO;
//        self.imageView.contentMode = UIViewContentModeTop;
//        self.imageView.clipsToBounds = YES;
//    } else {
//        self.seeBigPictureButton.hidden = YES;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
//        self.imageView.clipsToBounds = NO;
//    }
}
- (IBAction)SeeBigPciture:(id)sender {
    
    QYHseeBigPictureViewController *seeVc = [[QYHseeBigPictureViewController alloc] init];
    seeVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeVc animated:YES completion:nil];
}

@end
