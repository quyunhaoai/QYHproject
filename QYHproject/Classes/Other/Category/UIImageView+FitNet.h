//
//  UIImageView+FitNet.h
//  PLMMPRJK
//
//  Created by HuXuPeng on 2017/5/23.
//  Copyright © 2017年 GoMePrjk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface UIImageView (FitNet)


- (void)lmj_setImageWithURL:(NSURL *)originImageURL thumbnailImageURL:(NSURL *)thumbImageURL placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock;


@end
