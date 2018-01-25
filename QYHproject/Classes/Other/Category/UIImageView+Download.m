//
//  UIImageView+Download.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIImageView+Download.h"
#import <AFNetworkReachabilityManager.h>
#import <UIImageView+WebCache.h>
#import "QYH.h"
@implementation UIImageView (Download)
- (void)qyh_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock andModel:(QYHModel *)topic
{
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) { // 原图已经被下载过
        self.image = originImage;
        completedBlock(originImage,nil,0,[NSURL URLWithString:originImageURL]);
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
            completedBlock(nil,nil,0,[NSURL URLWithString:originImageURL]);
        } else if (mgr.isReachableViaWWAN) {
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 缩略图已经被下载过
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
            } else { // 没有下载过任何图片
                // 占位图片;
                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
            }
        }
    }
    /**/
    if (self.image) {
    CGFloat imageW = topic.middleViewFrame.size.width;
    CGFloat imageH = imageW * topic.height / topic.width;
    
    // 开启上下文
    UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
    // 绘制图片到上下文中
    [self.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    }
}

//- (void)qyh_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock
//{
//    // 根据网络状态来加载图片
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
//    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
//    if (originImage) { // 原图已经被下载过
////        self.image = originImage;
////        completedBlock(originImage, nil, 0, [NSURL URLWithString:originImageURL]);
//        
//        [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
//    } else { // 原图并未下载过
//        if (mgr.isReachableViaWiFi) {
//            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
//        } else if (mgr.isReachableViaWWAN) {
//#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
//            // 3G\4G网络下时候要下载原图
//            BOOL downloadOriginImageWhen3GOr4G = YES;
//            if (downloadOriginImageWhen3GOr4G) {
//                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder completed:completedBlock];
//            } else {
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
//            }
//        } else { // 没有可用网络
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
//            if (thumbnailImage) { // 缩略图已经被下载过
////                self.image = thumbnailImage;
////                completedBlock(thumbnailImage, nil, 0, [NSURL URLWithString:thumbnailImageURL]);
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder completed:completedBlock];
//            } else { // 没有下载过任何图片
//                 // self.image = placeholder;
//                // 占位图片;
//                [self sd_setImageWithURL:nil placeholderImage:placeholder completed:completedBlock];
//            }
//        }
//    }
//}

- (void)qyh_setHeader:(NSString *)headerUrl
{
    UIImage *placeholder = [UIImage qyh_circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法
        if (!image) return;
        
        self.image = [image qyh_circleImage];
    }];
    
//    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
