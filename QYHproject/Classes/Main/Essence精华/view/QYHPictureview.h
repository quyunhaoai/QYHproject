//
//  QYHPictureview.h
//  QYHproject
//
//  Created by hao on 2018/1/12.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYHModel.h"
#import "M13ProgressViewRing.h"
@interface QYHPictureview : UIView
/** <#digest#> */
@property (weak, nonatomic) M13ProgressViewRing *ringProgressView;
/** 模型数据 **/
@property (nonatomic,strong) QYHModel * topic;
@end
