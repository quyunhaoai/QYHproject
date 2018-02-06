//
//  QYHModel.m
//  QYHproject
//
//  Created by hao on 2017/12/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "QYHModel.h"
#import "QYH.h"
@implementation QYHModel

-(CGFloat)cellHeight
{
    if (_cellHeight) {
        return _cellHeight;
    }
    _cellHeight += 77;
    
    CGSize textMaxSize = CGSizeMake(QYHScreenW - 2 * QYHMarin, MAXFLOAT);
    
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height + QYHMarin*2;
    
    
    // 中间的内容
    if (self.type != QYHTopicTypeWord) { // 中间有内容（图片、声音、视频）
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;

        if (middleH >= QYHScreenH) { // 显示的图片高度超过一个屏幕，就是超长图片
            middleH = 200;
            self.isBigPicture = YES;
        }
        CGFloat middleY = _cellHeight-37;
        CGFloat middleX = QYHMarin;
        self.middleViewFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH + QYHMarin*2;
    }
    
    return _cellHeight;
    
    
}
@end
