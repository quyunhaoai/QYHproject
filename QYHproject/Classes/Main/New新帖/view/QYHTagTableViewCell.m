//
//  QYHTagTableViewCell.m
//  QYHproject
//
//  Created by hao on 2018/1/3.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "QYHTagTableViewCell.h"
#import "SDImageCache.h"
#import "UIView+frame.h"
#import "UIImageView+WebCache.h"
@implementation QYHTagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    /*设置圆形*/
    self.TagImang.clipsToBounds = YES;
    self.TagImang.layer.cornerRadius = self.TagImang.bounds.size.width / 2;
    
}
-(void)setItme:(QYHTagItem *)itme
{
    _itme = itme;

    UIImage *placeImage = [UIImage imageNamed:@"defaultUserIcon"];
    [self.TagImang sd_setImageWithURL:[NSURL URLWithString:itme.image_list] placeholderImage:placeImage];
    
    self.TagTitle.text = itme.theme_name;
    
    [self resolveNum];
    
//    self.ContLable.text = itme.sub_number;
    
}
-(void)resolveNum{
    NSString *number_string = [NSString stringWithFormat:@"%@人订阅",_itme.sub_number];
    NSInteger number = _itme.sub_number.integerValue;
    if (number > 10000) {
        number_string = [NSString stringWithFormat:@"%.1f万人订阅",number / 10000.0 ];
        number_string = [number_string stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    self.ContLable.text = number_string;
    
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
