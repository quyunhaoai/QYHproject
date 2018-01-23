//
//  QYHseeBigPictureViewController.m
//  QYHproject
//
//  Created by hao on 2018/1/13.
//  Copyright © 2018年 hao. All rights reserved.
//

#import "QYHseeBigPictureViewController.h"
#import "QYH.h"
#import "UIImageView+Download.h"
#import <Photos/Photos.h>
@interface QYHseeBigPictureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollview;
@property (nonatomic, weak) UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *saveBut;
-(PHAssetCollection *)createdCollection;//创建相册
-(PHFetchResult<PHAsset *>*)createdPhasset;//添加相片
@end

@implementation QYHseeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIScrollView *scrollview = [[UIScrollView alloc]init];
    scrollview.frame =[UIScreen mainScreen].bounds;
//    scrollview.autoresizesSubviews = NO;
    [self.view insertSubview:scrollview atIndex:0];
    self.scrollview = scrollview;
//    if (_topic.is_gif) return;
    UIImageView *imageview = [[UIImageView alloc] init];
    [imageview sd_setImageWithURL:[NSURL URLWithString: _topic.image1 ] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
        
    }];
//    imageview.contentMode = UIViewContentModeCenter;
    imageview.qyh_width = _scrollview.qyh_width;
    if (_topic) {
        imageview.qyh_height = imageview.qyh_width * _topic.height/_topic.width;
    }else{
        imageview.qyh_height =200;
    }
    imageview.qyh_x = 0;
    if (imageview.qyh_height > qyhScreenH) {
        imageview.qyh_y = 0;
        _scrollview.contentSize = CGSizeMake(0, imageview.qyh_height);
    }else{
        imageview.qyh_center_y = _scrollview.qyh_height * 0.5;
    }
    
    _imageview = imageview;

//    [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnBackView:)]];
    [_scrollview addSubview:imageview];
    CGFloat maxScale = self.topic.width / imageview.qyh_width;
    if (maxScale > 1) {
        _scrollview.maximumZoomScale = maxScale;
        _scrollview.delegate = self;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnBackView:)];
    [_scrollview addGestureRecognizer:tap];
}
#pragma mark SavePhoto
-(PHAssetCollection *)createdCollection{
    NSError *error = nil;
    NSString *appName = [NSBundle mainBundle].infoDictionary[(NSString*)kCFBundleNameKey];
    PHFetchResult<PHAssetCollection *>*collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    PHAssetCollection *createdCollection = nil;
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:appName]) {
            return collection;
        }
    }
    __block NSString *createdCollectionId = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:appName].placeholderForCreatedAssetCollection.localIdentifier;
        
    } error:&error] ;
    if (error) {
        //相册创建失败，返回nil；
        return nil;
    }
    createdCollection = [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
    
    return createdCollection;
    
}
-(PHFetchResult<PHAsset *>*)createdPhasset{
    NSError *error = nil;
    __block NSString *assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageview.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    
    if (error) return nil;
    
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
/*状态栏颜色黑色*/
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    //    return UIStatusBarStyleLightContent;
//    return UIStatusBarStyleDefault;
//}
/*状态栏颜色为白色*/
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
#pragma mark scrollview Delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnBackView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveClick:(id)sender {
    
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    
    // 请求\检查访问权限 :
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) { // 用户拒绝当前App访问相册
                if (oldStatus != PHAuthorizationStatusNotDetermined) {
                    //                    XMGLog(@"提醒用户打开开关")
                }
            } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许当前App访问相册
                [self saveImageAction];
            } else if (status == PHAuthorizationStatusRestricted) { // 无法访问相册
                [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
            }
        });
    }];
    
}
-(void)saveImageAction
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        NSLog(@"%zd",status);
        switch (status) {
            case 0:
                
                break;
                
            default:
                break;
        }
    }];
    //获取相片
    PHFetchResult <PHAsset *>*createdPhasset = self.createdPhasset;
    if (createdPhasset == nil) {
        NSLog(@"保存图片失败！");
        return;
    }else{
        NSLog(@"保存相片成功！");
    }
    //获取相册
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        NSLog(@"创建或者获取相册失败！");
        return;
    }else{
        NSLog(@"创建相册成功！");
    }
    
    
    //1,保存图片到系统相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdPhasset atIndexes:[NSIndexSet indexSetWithIndex:0]];
        //           [request addAssets:createdPhasset];
        
    } error:&error] ;
    if (error) {
        NSLog(@"插入图片失败！");
    }else{
        NSLog(@"插入图片成功！");
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
