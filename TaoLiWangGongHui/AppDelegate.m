//
//  AppDelegate.m
//  TaoLiWangGongHui
//
//  Created by Mac OS X on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TimeObject.h"
///支付宝
#import "AliPayHelper.h"
#import "UIAlertView+ITTAdditions.h"
#import "BootPageViewController.h"

@implementation AppDelegate
@synthesize baseViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    if(![self SenderlimitTime])
        return NO;
    
    // 全局预定义导航背景
    if (isIOS7) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_background_64.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_background.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    if (isIOS7) {
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor], UITextAttributeTextColor,
                                                              [UIFont systemFontOfSize:18.0f], UITextAttributeFont,nil]];
    }else{
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              [UIColor whiteColor],UITextAttributeTextColor,
                                                              [UIColor clearColor],
                                                              UITextAttributeTextShadowColor,nil]];

    }
    
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"BootPage_key"]){
        //加载引导页
        if (iPhone5) {
            BootPageViewController *bvc = [[BootPageViewController alloc]initWithNibName:@"BootPageViewController-iPhone5" bundle:nil];
            self.window.rootViewController = bvc;
        }else{
            BootPageViewController *bvc = [[BootPageViewController alloc]initWithNibName:@"BootPageViewController-iPhone4" bundle:nil];
            self.window.rootViewController = bvc;
        }
    }else{
        if (([[UserHelper shareInstance] getMemberID].intValue != 0) && [[UserHelper shareInstance] getMemberID]) {
            [self chageRootVC];
        }else{
            [self chageLoginVC];
        }
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

// 登录成功后修改rootVC
- (void)chageRootVC{
    [UIApplication sharedApplication].statusBarHidden = NO;
    if (([[UserHelper shareInstance] getMemberID].intValue != 0) && [[UserHelper shareInstance] getMemberID]) {
        self.baseViewController = [[BaseViewController alloc] init];
        self.window.rootViewController = self.baseViewController;            }else{
            [self chageLoginVC];
        }
    
}

// 登录成功后修改rootVC
- (void)chageLoginVC{
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
}

//打包使用期限限制
- (BOOL)SenderlimitTime{
    int timeDay5 = 7 * 24 * 60 * 60;
    NSString * strNewTime = [TimeObject currentTime];
    NSString * strTime = @"1397662005";
    NSLog(@"预计开始时间===%@",[TimeObject fromTimeChuoTotime:strTime]);
    NSLog(@"当前时间====%@",[TimeObject currentTime]);
    if ([strTime intValue] + timeDay5 <= [strNewTime intValue]) {
        [UIAlertView popupAlertByDelegate:self andTag:7000 title:@"温馨提示" message:@"超出有效期  不再正常使用"];
        NSLog(@"strNew超出有效期  不再正常使用");
        return NO;
    }
    return YES;
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
