//
//  DiscountShopping Cell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "DiscountShoppingCell.h"
#import "GoodsDetailDataBase.h"
#import "GoodsListModel.h"
@implementation DiscountShoppingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)addShoppingCart:(id)sender {
    if ([[GoodsDetailDataBase shareDataBase] insertItem:self.discountModel]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已加入购物车"];
    }else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"购物车里已存在"];
    }

    [GlobalHelper showCarViewInNavC:nil withVC:nil];
}

- (void)setObject:(NSDictionary *)dict{
    self.discountModel = [[GoodsListModel alloc] initWithDataDic:dict];
    [self.goodsImage setImageWithURL:[NSURL URLWithString:self.discountModel.previewPicPath]];
    self.goodsTitle.text = self.discountModel.productName;
    self.goodsPrice.text = [NSString stringWithFormat:@"原价:%@元",self.discountModel.costPrice];
    self.goodsPrePrice.text = [NSString stringWithFormat:@"现价:%@元",self.discountModel.basicPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
