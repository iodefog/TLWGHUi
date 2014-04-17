//
//  OrderCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrdelModel.h"
@interface OrderCell : UITableViewCell

@property (strong, nonatomic) OrdelModel *ordelModel;
// 福利界面
@property (strong, nonatomic) IBOutlet UIView *welfareView;
@property (strong, nonatomic) IBOutlet UIImageView *welfareBackImageView; // 福利界面边框
@property (strong, nonatomic) IBOutlet UIImageView *welfareHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *welfareOrderNum; // 时间  warning**名字起反了**
@property (strong, nonatomic) IBOutlet UILabel *welfareOrderTime; // 订单号

// 现金界面
@property (strong, nonatomic) IBOutlet UIView *cashView;
@property (strong, nonatomic) IBOutlet UIImageView *cashBackImageView; // 福利界面边框

@property (strong, nonatomic) IBOutlet UIImageView *cashHeadImage;  //商品图像
@property (strong, nonatomic) IBOutlet UILabel *cashOrderNum;   // 订单时间   warning**名字起反了,** 和订单号，
@property (strong, nonatomic) IBOutlet UILabel *cashOrderTime;  // 订单号 warning**名字起反了,**

@property (strong, nonatomic) IBOutlet UILabel *cashOrderPirce;  //订单金额

- (void)showWelfareViewWithHidden:(BOOL)welfareHidden withCashViewHidden:(BOOL)cashHidden;

- (void)setObject:(NSDictionary *)dict;

@end
