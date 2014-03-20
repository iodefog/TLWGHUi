//
//  ShoppingCartCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "GoodsDetailDataBase.h"

@implementation ShoppingCartCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.GoodQuantity.delegate = self;
}

// 点击减少商品数量
- (IBAction)ReduceQuantity:(id)sender {
    NSInteger currentNum = [self.GoodQuantity.text intValue];
    if (currentNum-1 >= 0) {
        self.GoodQuantity.text = [NSString stringWithFormat:@"%d",--currentNum];
        self.GoodPrice.text    = [NSString stringWithFormat:@"%d元",currentNum*250];
    }
}

// 点击增加商品数量
- (IBAction)IncreaseQuantity:(id)sender {
    NSInteger currentNum = [self.GoodQuantity.text intValue];
    self.GoodQuantity.text = [NSString stringWithFormat:@"%d",++currentNum];
    self.GoodPrice.text    = [NSString stringWithFormat:@"%d元",currentNum*250];
}

// 展示是否为编辑时，显示活隐藏删除按钮
- (void)showDeleteButton:(BOOL)show{
    if (show) {
        self.baseView.left = -60;
    }else{
        self.baseView.left = 0;
    }
    self.deleteButton.hidden = !show;
}

// 删除按钮点击
- (IBAction)deleteClicked:(id)sender {
    [[GoodsDetailDataBase shareDataBase] deleteTableProductId:self.shoppingModel];
    
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(responseWithIndex:withData:)]) {
        [self.shoppingDelegate performSelector:@selector(responseWithIndex:withData:) withObject:currentIndex withObject:currentData];
    }
}

- (void)setObjectWithIndex:(NSIndexPath*)index withData:(NSDictionary *)data{
    currentIndex = index;
    currentData = data;
    
    self.shoppingModel = [[GoodsListModel alloc] initWithDataDic:data];
    self.GoodID.text = self.shoppingModel.productId;
    self.GoodDescription.text = self.shoppingModel.productName;
    [self.goodImage setImageWithURL:[NSURL URLWithString:self.shoppingModel.previewPicPath]];
    self.GoodPrice.text = self.shoppingModel.costPrice;
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(shoppingTextFieldDidBeginEditing:)]) {
        [self.shoppingDelegate shoppingTextFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(shoppingTextFieldDidEndEditing:)]) {
        [self.shoppingDelegate shoppingTextFieldDidEndEditing:textField];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
