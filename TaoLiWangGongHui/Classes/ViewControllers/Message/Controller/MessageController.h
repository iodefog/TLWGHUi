//
//  MessageController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageController : ViewController <UITableViewDataSource ,UITableViewDelegate>

@property (nonatomic, strong) UITableView *messageTableView;  // 推送通知

@end
