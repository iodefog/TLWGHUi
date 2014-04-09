//
//  DelicateLifeCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@protocol DelicateLifeDelegate <NSObject>

- (void)reloadTableView;

@end

@interface DelicateLifeCell : UITableViewCell<UIWebViewDelegate> //(精致生活)

@property (assign, nonatomic) id delegate;
@property (strong, nonatomic) RTLabel *dailyLable;   // 年月日
@property (strong, nonatomic) RTLabel *timeLable;    // 时间
@property (strong, nonatomic) UIImageView *bgImageView; // 背景图片
@property (strong, nonatomic)  RTLabel *delicateLifeTitle;      // 精致生活页，每篇文字的title
@property (strong, nonatomic) UIView *sperateLine;// 分割线
//@property (strong, nonatomic)  RTLabel *delicateLifeDescription; // 精致也文字详情
@property (strong, nonatomic)  UIWebView *delicateWebView; // 精致也文字详情

- (void)setObject:(NSDictionary *)dict;                          // 从网络获取数据，并给视图赋值

+ (CGFloat)getCellHeight:(NSDictionary *)dict;                   // 根据网络获取文字多少，获取cell的高度

@end
