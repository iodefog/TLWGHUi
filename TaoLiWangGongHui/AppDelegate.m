//
//  AppDelegate.m
//  TaoLiWangGongHui
//
//  Created by Mac OS X on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

///支付宝
#import "AliPayHelper.h"
#import "UIAlertView+ITTAdditions.h"


@implementation AppDelegate
@synthesize baseViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // 全局预定义导航背景

    if (isIOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_background_64.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_background.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor whiteColor], UITextAttributeTextColor,nil]];
    
    if (([[UserHelper shareInstance] getMemberID].intValue != 0) && [[UserHelper shareInstance] getMemberID]) {
        [self chageRootVC];
    }else{
        [self chageLoginVC];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

// 登陆成功后修改rootVC
- (void)chageRootVC{
    self.baseViewController = [[BaseViewController alloc] init];
    self.window.rootViewController = self.baseViewController;
}

// 登陆成功后修改rootVC
- (void)chageLoginVC{
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
    [[AliPayHelper shareInstance] parse:url application:application];
	return YES;
}


@end
