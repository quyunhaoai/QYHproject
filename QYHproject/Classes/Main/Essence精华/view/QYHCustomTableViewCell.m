//
//  QYHCustomTableViewCell.m
//  QYHproject
//
//  Created by hao on 2017/12/28.
//  Copyright © 2017年 hao. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "QYHCustomTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface QYHCustomTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleString;
@property (weak, nonatomic) IBOutlet UILabel *titletime;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *dingBut;
@property (weak, nonatomic) IBOutlet UIButton *caiBut;
@property (weak, nonatomic) IBOutlet UIButton *repostBut;
@property (weak, nonatomic) IBOutlet UIButton *commentBut;

@end
@implementation QYHCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headIcon.layer.masksToBounds = YES;
    self.headIcon.layer.cornerRadius = self.headIcon.bounds.size.width/2;
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    
    [super setFrame:frame];

}
-(void)headSetIcon
{
    NSString *imagename = @"defaultUserIcon";
    UIImage *placeImage = [UIImage imageNamed:imagename];
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:_QYHModel.profile_image] placeholderImage:placeImage];
    
}
-(void)setQYHModel:(QYHModel *)QYHModel
{
    _QYHModel = QYHModel;
    [self headSetIcon];
    self.titleString.text = QYHModel.name;
    self.titletime.text = QYHModel.passtime;
    self.content.text = QYHModel.text;
    
    [self setupButton:self.dingBut number:QYHModel.ding placeholderText:@"顶"];
    [self setupButton:self.caiBut number:QYHModel.cai placeholderText:@"踩"];
    [self setupButton:self.repostBut number:QYHModel.repost placeholderText:@"分享"];
    [self setupButton:self.commentBut number:QYHModel.comment placeholderText:@"评论"];
    
}
-(void)setupButton:(UIButton *)button number:(NSUInteger )number placeholderText:(NSString *)string
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number/10000.0] forState:UIControlStateNormal];
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    }else{
        [button setTitle:string forState:UIControlStateNormal];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
