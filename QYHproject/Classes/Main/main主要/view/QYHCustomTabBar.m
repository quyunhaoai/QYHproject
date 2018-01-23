//
//  QYHCustomTabBar.m
//  TabBarDemo
//
//  Created by hao on 17/9/15.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHCustomTabBar.h"
#import "QYHbutton.h"
@implementation QYHCustomTabBar
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setItems:(NSArray *)items{
    _items = items;
    for (int i = 0; i < items.count; i ++) {
        QYHbutton *but = [[QYHbutton alloc]init];
        [self addSubview:but];
        UITabBarItem *item = items[i];
        [but setBackgroundImage:item.image forState:UIControlStateNormal];
        [but setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        [but addTarget:self action:@selector(buttonOnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
}
-(void)buttonOnClick:(UIButton *)button{
    
    self.selectbutton.selected = NO;
    
    button.selected = YES;
    
    self.selectbutton = button;
    
    if ([self.delegate respondsToSelector:@selector(tabBar:index:)]) {
        [self.delegate tabBar:self index:button.tag];
    }
    
}
-(void)layoutSubviews{
    int i = 0 ;
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width/self.items.count    ;
    CGFloat buttonH = self.frame.size.height;

    for (UIButton *but in self.subviews) {
        buttonX = buttonW * i;
        if (i == 0) {
            [self buttonOnClick:but];
        }
        but.tag = i;
        

        but.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        i++;
    }
}
@end
