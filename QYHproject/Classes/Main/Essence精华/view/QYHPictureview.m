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
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigpicture)]];
}
-(void)seeBigpicture{
    NSLog(@"%s",__FUNCTION__);
}
-(void)setTopic:(QYHModel *)topic
{
    _topic = topic;
    self.placeholderview.hidden = NO;
    
    [self.imageView qyh_setOriginImage:_topic.image1 thumbnailImage:_topic.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        self.placeholderview.hidden = YES;
        if (_topic.isBigPicture) {
            
        }
        
    }];
    self.gifview.hidden = !topic.is_gif;
    
}
@end
