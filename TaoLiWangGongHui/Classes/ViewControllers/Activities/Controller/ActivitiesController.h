//
//  ActivitiesController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitiesController : ViewController <UITableViewDelegate , UITableViewDataSource>

@property (nonatomic, strong) UITableView *activitiesTableView;  //我的活动

@end
