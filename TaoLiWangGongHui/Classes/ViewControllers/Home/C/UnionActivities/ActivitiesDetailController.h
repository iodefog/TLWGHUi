//
//  ActivitiesDetailController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TypeNone,     //不显示 报名和投票
    TypeSignUp,  //显示 报名
    TypeVote,    //显示 投票
} ActivityType;

@interface ActivitiesDetailController : ViewController <UIWebViewDelegate> // 活动详情
{
    ActivityType activityType;
    NSString     *activityID;
}

@property (strong, nonatomic) IBOutlet UIScrollView *baseScroll;    // 基础滑动视图，所有视图都添加到这上面
@property (strong, nonatomic) IBOutlet UIImageView *headImage;    //活动详情图片
@property (strong, nonatomic) IBOutlet UILabel *activitiesTitle;  //活动情简介

@property (strong, nonatomic) IBOutlet UIScrollView *middleScrollView;  //中部滑动scroll
// 描述
@property (strong, nonatomic) IBOutlet UIWebView *descriptionWebView;

@property (strong, nonatomic) IBOutlet UIView *bottomView; // 底部视图，用来隐藏底部两个按钮

@property (strong, nonatomic) IBOutlet UIButton *signUpButton;    // 我要报名
@property (strong, nonatomic) IBOutlet UIButton *haveSignedButton; // 查看已报名会员

- (id)initWithActivityType:(ActivityType)myActivityType withID:(NSString *)myActivityID;;

@end
