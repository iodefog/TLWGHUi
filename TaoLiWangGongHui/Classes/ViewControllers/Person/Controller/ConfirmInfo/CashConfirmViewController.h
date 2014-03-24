//
//  CashConfirmViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ViewController.h"
#import "GoodsListModel.h"
@interface CashConfirmViewController : ViewController // 现金信息确认

@property (strong, nonatomic) IBOutlet UIButton *aliPayButton; // 支付宝客户端支付
@property (strong, nonatomic) IBOutlet UIButton *unionpayButton; // 银联支付

// 视图第一部分
@property (strong, nonatomic) IBOutlet UIView *head1;

@property (strong, nonatomic) IBOutlet UILabel *totalPrice; // 总计

// 视图低一部分2
@property (strong, nonatomic) IBOutlet UIView *head2;
@property (strong, nonatomic) IBOutlet UILabel *userName; // 用户名
@property (strong, nonatomic) IBOutlet UILabel *phoneNum; // 用户手机号
@property (strong, nonatomic) IBOutlet UILabel *detailAddress;// 详细地址
@property (strong, nonatomic) GoodsListModel *goodsModel;

// 传入商品价格
@property (assign, nonatomic) CGFloat goodsSumPrice;

- (void)shoppingPriceWithShow:(BOOL)show;

@end
