//
//  UIView+frame.m
//  xibLearn
//
//  Created by hao on 2017/11/27.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "UIView+frame.h"

@implementation UIView (frame)
+ (instancetype)qyh_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
-(void)setQyh_x:(CGFloat)qyh_x
{
    CGRect frame = self.frame;
    frame.origin.x = qyh_x;
    self.frame = frame;
}
-(CGFloat)qyh_x{
    return self.frame.origin.x;
}
-(void)setQyh_y:(CGFloat)qyh_y
{
    CGRect frame = self.frame;
    frame.origin.y = qyh_y;
    self.frame = frame;
}
-(CGFloat)qyh_y
{
    return self.frame.origin.y;
}
-(void)setQyh_center_x:(CGFloat)qyh_center_x{
    CGPoint center = self.center;
    center.x = qyh_center_x;
    self.center = center;
}
-(CGFloat)qyh_center_x
{
    return self.center.x;
}
-(void)setQyh_center_y:(CGFloat)qyh_center_y
{
    CGPoint center = self.center;
    center.y = qyh_center_y;
    self.center = center;
    
}
-(CGFloat)qyh_center_y
{
    return self.center.y;
}
-(void)setQyh_width:(CGFloat)qyh_width
{
    CGRect rect = self.frame;
    rect.size.width = qyh_width;
    self.frame = rect;
    
    
}
-(CGFloat)qyh_width
{
    return self.frame.size.width;
}
-(void)setQyh_height:(CGFloat)qyh_height
{
    CGRect rect = self.frame;
    rect.size.height = qyh_height;
    self.frame = rect;
}
-(CGFloat)qyh_height
{
    return self.frame.size.height;
}
@end
