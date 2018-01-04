//
//  CustomDoneBtn.h
//  WebViewAD
//
//  Created by hao on 16/3/4.
//  Copyright © 2016年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDoneBtn : UIButton
- (instancetype)initWithFrame:(CGRect)frame time:(int)mytime;
@property (copy, nonatomic) void (^completionHandler)();

@end
