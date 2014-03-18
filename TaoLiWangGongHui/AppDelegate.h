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
- (void)chageRootVC;

@end
