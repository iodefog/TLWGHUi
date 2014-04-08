//
//  OrderCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "OrderCell.h"

@implementation OrderCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showWelfareViewWithHidden:(BOOL)welfareHidden withCashViewHidden:(BOOL)cashHidden{
    self.welfareView.hidden = welfareHidden;
    self.cashView.hidden = cashHidden;
}

- (void)setObject:(NSDictionary *)dict{
    self.ordelModel = [[OrdelModel alloc] initWithDataDic:dict];
//    self.welfareHeadImage setImageWithURL:[]
    self.welfareOrderNum.text = self.ordelModel.orderCode;
    self.welfareOrderTime.text = self.ordelModel.orderDate;
    
    self.cashOrderNum.text = self.ordelModel.orderCode;
    self.cashOrderTime.text = self.ordelModel.orderDate;
    self.cashOrderPirce.text =  [NSString stringWithFormat:@"%@元",self.ordelModel.totalMoney];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
