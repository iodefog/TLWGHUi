//
//  PersonController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonController : UIViewController <UITableViewDataSource, UITableViewDelegate ,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *personTableView;  // 个人中心

@end
