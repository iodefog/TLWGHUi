//
//  MessageController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
 // 推送通知
@interface MessageController : TableViewController <UITableViewDataSource ,UITableViewDelegate>

- (void)changeIsSelfResquestWithBool:(BOOL)selfBool;

@end
