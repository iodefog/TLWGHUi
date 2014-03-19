//
//  AppDelegate.h
//  TaoLiWangGongHui
//
//  Created by Mac OS X on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) BaseViewController *baseViewController;
- (void)chageRootVC; // 切换到内容跟视图
- (void)chageLoginVC; // 切换到登陆视图
@end
