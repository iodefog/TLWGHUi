//
//  ActivitiesCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitiesCell : UITableViewCell

// 我的活动图片，小图
@property (strong, nonatomic) IBOutlet UIImageView *activityImage;
// 活动描述
@property (strong, nonatomic) IBOutlet UILabel *activityDescription;
// 活动显示时间
@property (strong, nonatomic) IBOutlet UILabel *activityTime;
// 传入参数，并根据参数修改活动类型

@end
