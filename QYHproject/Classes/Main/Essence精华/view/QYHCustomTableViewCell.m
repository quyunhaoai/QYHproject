//
//  QYHCustomTableViewCell.m
//  QYHproject
//
//  Created by hao on 2017/12/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHCustomTableViewCell.h"
@interface QYHCustomTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleString;
@property (weak, nonatomic) IBOutlet UILabel *titletime;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
@implementation QYHCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    NSString *imagename = @"defaultUserIcon";
    self.headIcon.image = [UIImage xmg_circleImageNamed:imagename];
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    
    [super setFrame:frame];

}
-(void)setQYHModel:(QYHModel *)QYHModel
{
    
    _QYHModel = QYHModel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
