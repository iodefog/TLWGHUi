//
//  WelfareCell2.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"
#import "WelfareController.h"
@interface WelfareCell : UITableViewCell

@property (strong, nonatomic) GoodsListModel *goodsModel;
@property (strong, nonatomic) IBOutlet UIImageView *welfareGoodImage; // 商品图片
@property (strong, nonatomic) IBOutlet UILabel *welfareGoodTitle; //商品名字
@property (strong, nonatomic) IBOutlet UILabel *welfareGoodID;// 商品编号
@property (strong, nonatomic) IBOutlet UIButton *receiveButton;// 立即领取

@property (assign, nonatomic) WelfareType welfareType;

- (void)setObject:(NSDictionary *)params;

@end
