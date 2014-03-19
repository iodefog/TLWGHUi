//
//  ActivityNormalCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//


typedef enum{
    showSignUp,
    showVote
} ShowType;


#import <UIKit/UIKit.h>

@interface ActivityNormalCell : UITableViewCell  // 已报名会员或者已投票记录
{
    ShowType showType;
}

@property (strong, nonatomic) IBOutlet UILabel *name;           //姓名
@property (strong, nonatomic) IBOutlet UIButton *department;    // 部门
@property (strong, nonatomic) IBOutlet UILabel *eventName;     // 事件名称（报名时间，投票选择）
@property (strong, nonatomic) IBOutlet UILabel *eventDetail;   // 事件详情(时间，投票记录等）
//设置类型，如显示报名或者投票
- (void)changeShowType:(ShowType)myShowType;
- (void)setObject:(NSDictionary *)dict;
@end
