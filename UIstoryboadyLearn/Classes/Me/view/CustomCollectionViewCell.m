//
//  CustomCollectionViewCell.m
//  UIstoryboadyLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "CustomCollectionViewCell.h"
@interface CustomCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *headimage;

@end
@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setHead:(headicon *)Head
{
    _Head = Head;
    self.headimage.image = [UIImage imageNamed:Head.iconUrl];
    self.name.text = Head.name;

}

@end
