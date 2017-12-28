//
//  QYHCustomTableViewCell.m
//  QYHproject
//
//  Created by hao on 2017/12/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHCustomTableViewCell.h"

@implementation QYHCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
