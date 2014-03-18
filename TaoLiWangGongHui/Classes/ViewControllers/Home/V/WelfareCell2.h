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
@interface WelfareCell2 : UITableViewCell

@property (strong, nonatomic) GoodsListModel *goodsModel;
@property (strong, nonatomic) IBOutlet UIImageView *welfareGoodImage;
@property (strong, nonatomic) IBOutlet UILabel *welfareGoodTitle;
@property (strong, nonatomic) IBOutlet UILabel *welfareGoodID;
@property (assign, nonatomic) WelfareType welfareType;

- (void)setObject:(NSDictionary *)params;

@end
