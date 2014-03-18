//
//  WelfareOrderViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelfareOrderViewController : UIViewController  // 福利订单|| 订单详情
@property (strong, nonatomic) IBOutlet UILabel *orderNum; // 订单号
@property (strong, nonatomic) IBOutlet UILabel *orderTime; //下单时间

@property (strong, nonatomic) IBOutlet UIImageView *goodHeadImage; // 商品图片
@property (strong, nonatomic) IBOutlet UILabel *goodTitle; // 商品概要
@property (strong, nonatomic) IBOutlet UILabel *goodID; // 商品编码

@property (strong, nonatomic) IBOutlet UILabel *userName; // 用户姓名
@property (strong, nonatomic) IBOutlet UILabel *userPhone; // 用户手机号码
@property (strong, nonatomic) IBOutlet UILabel *userDescription; // 用户描述
@property (strong, nonatomic) IBOutlet UIButton *enterButton;  // 确认按钮
@end
