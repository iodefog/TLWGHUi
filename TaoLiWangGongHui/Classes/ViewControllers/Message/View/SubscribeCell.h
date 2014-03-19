//
//  SubscribeCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface SubscribeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *preViewImage; //商品图片
@property (strong, nonatomic) IBOutlet UILabel *goodCategory;
@property (strong, nonatomic) IBOutlet UIButton *subscribeBtn;

@property (strong, nonatomic) MessageModel *subscribeModel; // 商品信息

- (void)setObject:(NSDictionary *)dict;

@end
