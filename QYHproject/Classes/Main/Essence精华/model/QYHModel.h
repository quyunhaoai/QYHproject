//
//  QYHModel.h
//  QYHproject
//
//  Created by hao on 2017/12/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, QYHTopicType) {
    /** 全部 */
    QYHTopicTypeAll = 1,
    /** 图片 */
    QYHTopicTypePicture = 10,
    /** 段子 */
    QYHTopicTypeWord = 29,
    /** 声音 */
    QYHTopicTypeVoice = 31,
    /** 视频 */
    QYHTopicTypeVideo = 41
};
@interface QYHModel : NSObject
/**用户名字**/
@property (nonatomic,strong) NSString* name;
/**用户头像**/
@property (nonatomic,strong) NSString* profile_image;
/**帖子的内容**/
@property (nonatomic,strong) NSString* text;
/**帖子审核通过的时间**/
@property (nonatomic,strong) NSString* passtime;
/**顶数量**/
@property (nonatomic,assign) NSUInteger ding;
/**踩的数量**/
@property (nonatomic,assign) NSUInteger cai;
/**转发分享的数量**/
@property (nonatomic,assign) NSUInteger repost;
/**评论的数量**/
@property (nonatomic,assign) NSUInteger comment;
/**帖子的类型 10图片 29段子 31音频 41视频**/
@property (nonatomic,assign) NSUInteger type;
/**宽度（像素）**/
@property (nonatomic,assign) NSUInteger width;
/**高度（像素）**/
@property (nonatomic,assign) NSUInteger height;
/**最热评论**/
@property (nonatomic,strong) NSArray* top_cmt;
/** 小图 **/
@property (nonatomic,strong) NSString* image0;
/** 中图 **/
@property (nonatomic,strong) NSString* imgae2;
/** 大图 **/
@property (nonatomic,strong) NSString* image1;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL isBigPicture;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=is_gif) BOOL is_gif;

/** cellFrame **/
@property (nonatomic,assign) CGFloat cellHeight;
/**中间view的尺寸**/
@property (nonatomic,assign) CGRect middleViewFrame;

@end
