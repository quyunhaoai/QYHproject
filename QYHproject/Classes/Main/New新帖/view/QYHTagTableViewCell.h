//
//  QYHTagTableViewCell.h
//  QYHproject
//
//  Created by hao on 2018/1/3.
//  Copyright © 2018年 hao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYHTagItem.h"
@interface QYHTagTableViewCell : UITableViewCell
/*
 模型数据
 */
@property (nonatomic,strong) QYHTagItem *itme;
@property (weak, nonatomic) IBOutlet UIImageView *TagImang;
@property (weak, nonatomic) IBOutlet UILabel *TagTitle;
@property (weak, nonatomic) IBOutlet UILabel *ContLable;
@property (weak, nonatomic) IBOutlet UIButton *TagButton;

@end
