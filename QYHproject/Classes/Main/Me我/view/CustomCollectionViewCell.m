//
//  CustomCollectionViewCell.m
//  UIstoryboadyLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "QYH.h"
#import "UIImageView+WebCache.h"
@interface CustomCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *headimage;

@end
@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.name sizeToFit];

}
-(void)setHead:(headicon *)Head
{
    _Head = Head;
//    UIImage *image = [UIImage imageNamed:@""];
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:Head.icon] ];
    self.name.text = Head.name;
    

}

@end
