//
//  QYHTool.h
//  YUNDBAP
//
//  Created by hao on 17/9/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QYHTool : NSObject
/*获取单例对象*/
+ (instancetype)sharedInstance;
/*获取本地或者网络图片*/
+(UIImage *) getImageFromURL:(NSString *)fileURL ;
+(NSData *) getDataFromURL:(NSString *)fileURL ;
/*保存图片到本地沙盒*/
+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension;
/*根据路径获取图片*/
+(UIImage *) loadImage:(NSString *)fileName;
/*十六进制转换为颜色*/
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;
/*颜色转换为图片*/
+ (UIImage *)createImageWithColor:(UIColor *)color;


@end
