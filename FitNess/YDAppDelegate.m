//
//  YDAppDelegate.m
//  FitNess
//
//  Created by liuguoyan on 14-9-22.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "YDAppDelegate.h"
#import "FNNavigationViewController.h"
//#import "FNHintControlViewController.h"
#import "FNUserStatues.h"
#import "FNHomeTabBarController.h"
#import "FNLoginController.h"

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "FNGuideViewController.h"

#import "UMFeedback.h"

@implementation YDAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    

    
    ///////shareSDK
    [self setUMSocialSDKParams];
//    ///第一次启动
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstStart"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstStart"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LocalDate"];
        FNGuideViewController *navController = [[FNGuideViewController alloc]init];
        self.window.rootViewController = navController;
    }else {
        FNLoginController *rootContrller = [[FNLoginController alloc]init];
        FNNavigationViewController *navController = [[FNNavigationViewController alloc]initWithRootViewController:rootContrller];
        self.window.rootViewController = navController;
    }
//
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setUMSocialSDKParams
{
    //打开调试log的开关
//    [UMSocialData openLog:YES];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UmengAppkey];
    
    [UMFeedback setAppkey:@"54bf1733fd98c514330001a7"];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
    
    //打开新浪微博的SSO开关
    [UMSocialSinaHandler openSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];



    
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        [UMSocialSnsService  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
