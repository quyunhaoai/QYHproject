//
//  QYHCustomTextField.m
//  xibLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHCustomTextField.h"

@implementation QYHCustomTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [super awakeFromNib];
    //光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = [UIColor redColor];
    
}
-(void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
    NSLog(@"1%s",__FUNCTION__);
}
-(void)textEnd
{
    self.placeholderColor = [UIColor redColor];
    NSLog(@"2%s",__FUNCTION__);
}

@end
