//
//  BaseViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBadgeView.h"

@interface BaseViewController : UITabBarController <UITabBarControllerDelegate>
@property (nonatomic, strong) JSBadgeView *badgeView;

- (void)showBadgeView;

@end
