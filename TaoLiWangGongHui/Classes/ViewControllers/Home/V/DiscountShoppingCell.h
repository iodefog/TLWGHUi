//
//  DiscountShopping Cell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface DiscountShoppingCell : UITableViewCell  // 优惠购物

@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet UILabel *goodsTitle;
@property (strong, nonatomic) IBOutlet UILabel *goodsPrice;
@property (strong, nonatomic) IBOutlet UILabel *goodsPrePrice;
@property (strong, nonatomic) IBOutlet UIView *coverView; // 覆盖物
@property (strong, nonatomic) GoodsListModel *discountModel;

- (void)setObject:(NSDictionary *)dict;

@end
