//
//  QYHCustomButton.m
//  xibLearn
//
//  Created by hao on 2017/11/27.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHCustomButton.h"

#import "UIView+Frame.h"
@implementation QYHCustomButton


-(void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.imageView.qyh_y = 0;
    self.imageView.qyh_center_x = self.qyh_width * 0.5;
    
    self.titleLabel.qyh_y = self.qyh_height - self.titleLabel.qyh_height;
    
    [self.titleLabel sizeToFit];
    
    self.titleLabel.qyh_center_x = self.qyh_width *0.5;
    
}

@end
