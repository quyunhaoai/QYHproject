//
//  QYHCont.h
//  QYHproject
//
//  Created by hao on 2018/1/5.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/** UITabBar的高度 */
UIKIT_EXTERN CGFloat const QYHTabBarH;

/** 导航栏的最大Y值 */
UIKIT_EXTERN CGFloat const QYHNavMaxY;

/** 标题栏的高度 */
UIKIT_EXTERN CGFloat const QYHTitlesViewH;

/** 全局统一的间距 */
UIKIT_EXTERN CGFloat const QYHMarin;

/** 统一的一个请求路径 */
UIKIT_EXTERN NSString  * const QYHCommonURL;

/** TabBarButton被重复点击的通知 */
UIKIT_EXTERN NSString  * const QYHTabBarButtonDidRepeatClickNotification;

/** TitleButton被重复点击的通知 */
UIKIT_EXTERN NSString  * const QYHTitleButtonDidRepeatClickNotification;
@interface QYHCosnt : NSObject

@end
