//
//  ViewController.h
//  UIstoryboadyLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYHOneViewControllerDelegate <NSObject>
@optional
-(void)oneView:(UIViewController *)oneView setupTitleViewFarme:(CGRect)farme;

@end

@interface QYHOneViewController : UIViewController
-(void)setupTitleView:(BOOL)isShow;

@end

