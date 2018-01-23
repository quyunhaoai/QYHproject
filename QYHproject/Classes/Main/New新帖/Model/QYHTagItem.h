//
//  QYHTagItem.h
//  QYHproject
//
//  Created by hao on 2018/1/4.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYHTagItem : NSObject
/*
 标签图片名称
 */
@property (nonatomic,strong) NSString* image_list;
/*
 标签名字
 */
@property (nonatomic,strong) NSString* theme_name;
/*
 标签统计
 */
@property (nonatomic,strong) NSString* sub_number;

@end
