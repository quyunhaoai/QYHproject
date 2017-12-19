//
//  AlterView.h
//  aaa
//
//  Created by 云书网 on 2017/12/5.
//  Copyright © 2017年 云书网. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)(void);
typedef enum {
    SHOWORIGIN = 0, //显示原点
    NORMALSTYLE = 1,//正常样式
    COUNTDOWN = 2,//倒计时
} AlterViewStatue;
@interface QyhAlterView : UIView

+ (void)showAlterViewStatue:(AlterViewStatue)statue message:(NSString*) message topImageUrl:(NSString*)imageUrl cancelButtonTitle:(NSString*) cancelButtonTitle otherButtonTitle:(NSString*)otherButtonTitle times:(NSInteger)times onDismiss:(DismissBlock) dismissed onCancel:(CancelBlock) cancelled;
@end
