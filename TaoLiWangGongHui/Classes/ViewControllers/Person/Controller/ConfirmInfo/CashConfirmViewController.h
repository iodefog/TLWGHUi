//
//  CashConfirmViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ViewController.h"

@interface CashConfirmViewController : ViewController // 现金信息确认
@property (strong, nonatomic) IBOutlet UIButton *aliPayButton; // 支付宝客户端支付
@property (strong, nonatomic) IBOutlet UIButton *unionpayButton; // 银联支付
@property (strong, nonatomic) IBOutlet UILabel *totalPrice; // 总计


@end
