//
//  OrderCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderCell : UITableViewCell

// 福利界面
@property (strong, nonatomic) IBOutlet UIView *welfareView;
@property (strong, nonatomic) IBOutlet UIImageView *welfareHeadImage;
@property (strong, nonatomic) IBOutlet UILabel *welfareOrderNum;
@property (strong, nonatomic) IBOutlet UILabel *welfareOrderTime;

// 现金界面
@property (strong, nonatomic) IBOutlet UIView *cashView;
@property (strong, nonatomic) IBOutlet UIImageView *cashHeadImage;  //商品图像
@property (strong, nonatomic) IBOutlet UILabel *cashOrderNum;   // 订单号
@property (strong, nonatomic) IBOutlet UILabel *cashOrderTime;  // 订单时间
@property (strong, nonatomic) IBOutlet UILabel *cashOrderPirce;  //订单金额

- (void)showWelfareViewWithHidden:(BOOL)welfareHidden withCashViewHidden:(BOOL)cashHidden;

@end
