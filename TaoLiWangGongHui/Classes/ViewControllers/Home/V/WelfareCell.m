//
//  WelfareCell2.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "WelfareCell.h"
#import "WelfareConfirmViewController.h"
#import "CashConfirmViewController.h"
@implementation WelfareCell

- (void)awakeFromNib
{
    // Initialization code
}

// 立即获取
- (IBAction)GetNowClicked:(id)sender {
//    if (self.welfareType == WelfareBirthDay) {
        WelfareConfirmViewController *welfareConfirmVC = [[WelfareConfirmViewController alloc] initWithNibName:@"WelfareConfirmViewController" bundle:nil];
        welfareConfirmVC.goodPic = self.welfareGoodImage.image;
        welfareConfirmVC.goodText = self.welfareGoodTitle.text;
        welfareConfirmVC.goodIDText = self.welfareGoodID.text;
        welfareConfirmVC.goodsListModel = self.goodsModel;
        [selected_navigation_controller() pushViewController:welfareConfirmVC animated:YES];
//    }else if (self.welfareType == WelfareHoliday){
//        CashConfirmViewController *cashConfirmVC = [[CashConfirmViewController alloc] initWithNibName:@"CashConfirmViewController" bundle:nil];
//        cashConfirmVC.goodsModel = self.goodsModel;
//        [selected_navigation_controller() pushViewController:cashConfirmVC animated:YES];
//    }
}

- (void)setObject:(NSDictionary *)params{
    self.goodsModel = [[GoodsListModel alloc] initWithDataDic:params];
    if (self.goodsModel.theHolidayReceiveType.boolValue && self.welfareType == WelfareHoliday) {
        self.receiveButton.enabled = YES;
    }else if (self.goodsModel.birthdayReceiveType.boolValue && self.welfareType == WelfareBirthDay){
        self.receiveButton.enabled = YES;
    }else{
        self.receiveButton.enabled = NO;
    }
    
    [self.welfareGoodImage setImageWithURL:[NSURL URLWithString:self.goodsModel.previewPicPath]];
    self.welfareGoodTitle.text = self.goodsModel.productName;
    self.welfareGoodID.text = self.goodsModel.productId;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
