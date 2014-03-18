//
//  OrderDetailViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : ViewController


@property (strong, nonatomic) IBOutlet UIScrollView *baseScrollView;  // 整个滚动视图的载体
@property (strong, nonatomic) IBOutlet UILabel *orderID; // 订单号
@property (strong, nonatomic) IBOutlet UILabel *orderPrice; // 订单金额
@property (strong, nonatomic) IBOutlet UILabel *orderTime; // 下单时间

@property (strong, nonatomic) IBOutlet UIView *bottomView; // 下半部分载体视图
@property (strong, nonatomic) IBOutlet UILabel *orderUserName; // 下单的用户名
@property (strong, nonatomic) IBOutlet UILabel *orderPhone;  // 下单用户的手机号
@property (strong, nonatomic) IBOutlet UILabel *orderDescription; // 下单人的描述
@property (strong, nonatomic) IBOutlet UILabel *orderTotalPrice; // 总计



@end
