//
//  UIView+frame.h
//  xibLearn
//
//  Created by hao on 2017/11/27.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frame)
@property CGFloat qyh_x;
@property CGFloat qyh_y;
@property CGFloat qyh_width;
@property CGFloat qyh_height;


@property CGFloat qyh_center_x;
@property CGFloat qyh_center_y;

+ (instancetype)qyh_viewFromXib;


@end
