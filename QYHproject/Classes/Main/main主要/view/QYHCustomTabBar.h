//
//  QYHCustomTabBar.h
//  TabBarDemo
//
//  Created by hao on 17/9/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYHCustomTabBar;
@protocol QYHCustomDelegate <NSObject>

-(void)tabBar:(QYHCustomTabBar *)tabBar index:(NSUInteger )index;

@end


@interface QYHCustomTabBar : UIView
@property (nonatomic,strong) NSArray *items;
@property (nonatomic,weak) UIButton *selectbutton;
@property (nonatomic,strong) id<QYHCustomDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame;

@end
