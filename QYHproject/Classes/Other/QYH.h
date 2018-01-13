//
//  QYH.h
//  QYHproject
//
//  Created by hao on 2017/12/23.
//  Copyright © 2017年 hao. All rights reserved.
//

#ifndef QYH_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define QYH_h
#import "UIView+frame.h"
#import "UIBarButtonItem+Item.h"
#import "QYHTools.h"
#import "UIImage+Image.h"
#import "QyhAlterView.h"


#import "QYHOneViewController.h"
#import "QYHTwoViewController.h"
#import "QYHThreeViewController.h"
#import "QYHFiveViewController.h"
#import "MeTableViewController.h"
#import "QYHCustomTabBar.h"
#import "QYHBaseNavigationViewController.h"

#define NavBarHeight 64
#define TitleBarHeight 35
#define TabBarHeight 49
#define TableCellRowHeight 35
#define APPFont 14
#define kScreenH   [UIScreen mainScreen].bounds.size.height
#define kScreenW   [UIScreen mainScreen].bounds.size.width
#define isIPhoneX kScreenH==812
#define bottomMargin (isIPhoneX ? 84 : 64)
#endif /* QYH_h */

