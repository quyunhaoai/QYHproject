//
//  AppDelegate.m
//  UIstoryboadyLearn
//
//  Created by hao on 2017/11/28.
//  Copyright © 2017年 hao. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomerViewController.h"
#import "AFNetworking.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*创建跟控制器和窗口*/
    CustomerViewController *AdVC = [[CustomerViewController alloc] init];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = AdVC;
    [self.window makeKeyAndVisible];
    /*开始监控网络状态*/
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    return YES;
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*clearDisk 直接清楚缓存并创建
      cleanDisk  清楚过期的缓存，7天
     */
    [[SDWebImageManager sharedManager].imageCache clearDisk];
    /*取消当前所有操作*/
    [[SDWebImageManager sharedManager] cancelAll];
    
}

@end
