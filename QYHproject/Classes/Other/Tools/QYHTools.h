//
//  QYHTools.h
//  YUNDBAP
//
//  Created by hao on 17/9/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface QYHTools : NSObject
/*获取单例对象*/
+ (instancetype)sharedInstance;
/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect;
/*获取本地或者网络图片*/
+(UIImage *)getImageFromURL:(NSString *)fileURL ;
+(NSData *)getDataFromURL:(NSString *)fileURL ;
/*保存图片到本地沙盒*/
+(void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension;
/*根据路径获取图片*/
+(UIImage *)loadImage:(NSString *)fileName;
/*十六进制转换为颜色*/
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;
/*颜色转换为图片*/
+ (UIImage *)createImageWithColor:(UIColor *)color;

/*偏好设置*/
+ (void)UserDefaultsObj:(id)obj key:(NSString *)key;
/*获取偏好设置*/
+ (id)UserDefaultsObjectForKey:(NSString *)key;
/*对象转字符串*/
-(NSString*)DataTOjsonString:(id)object;
/*删除用户偏好设置*/
+ (void)removeUserDataWithkey:(NSString*)key;
/*对象归档偏好设置*/
+ (void)archiveObj:(id)obj withKey:(NSString *)key;
/*获取偏好设置对象*/
+ (id)unArchiveKey:(NSString *)key;

/*读程序目录而准备*/
+(NSString *)bundlePath:(NSString *)fileName ;
/*用户文档文件路径*/
+(NSString *)documentsPath:(NSString *)fileName;
/*获取用户文档文件路径*/
+(NSString *)documentsPath;
/*获取缓存路径*/
+(NSString *)getCachesPath;
/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 *
 *  @^BLOCK 返回文件夹尺寸
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;


/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;

@end
