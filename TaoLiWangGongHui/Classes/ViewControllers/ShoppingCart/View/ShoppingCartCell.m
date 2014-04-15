//
//  ShoppingCartCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "ShoppingCartCell.h"
#import "GoodsDetailDataBase.h"
#import "GoodsInfoController.h"
#import "Appdelegate.h"

@implementation ShoppingCartCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.GoodQuantity.delegate = self;
}

// 点击减少商品数量
- (IBAction)ReduceQuantity:(id)sender {
    NSInteger currentNum = [self.GoodQuantity.text intValue];
    if (currentNum-1 >= 1) {
        self.GoodQuantity.text = [NSString stringWithFormat:@"%d",--currentNum];
        self.GoodPrice.text    = [NSString stringWithFormat:@"%.2f元",currentNum*self.shoppingModel.costPrice.floatValue];
        
        if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(reduceGoodsQuantityWithPrice:)]) {
            [self.shoppingDelegate reduceGoodsQuantityWithPrice:self.shoppingModel.costPrice.floatValue];
        }
        [[GoodsDetailDataBase shareDataBase] updateItem:self.shoppingModel andProNumber:[NSString stringWithFormat:@"%d",currentNum]];
    }
}

// 点击增加商品数量
- (IBAction)IncreaseQuantity:(id)sender {
    NSInteger currentNum = [self.GoodQuantity.text intValue];
    self.GoodQuantity.text = [NSString stringWithFormat:@"%d",++currentNum];
    self.GoodPrice.text    = [NSString stringWithFormat:@"%.2f元",currentNum*self.shoppingModel.costPrice.floatValue];
    
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(increaseGoodsQuantityWithPrice:)]) {
        [self.shoppingDelegate increaseGoodsQuantityWithPrice:self.shoppingModel.costPrice.floatValue];
    }
    [[GoodsDetailDataBase shareDataBase] updateItem:self.shoppingModel andProNumber:[NSString stringWithFormat:@"%d",currentNum]];
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
    AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
   
    [delegate.baseViewController showBadgeView];
    
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(responseWithIndex:withData:)]) {
        [self.shoppingDelegate performSelector:@selector(responseWithIndex:withData:) withObject:currentIndex withObject:currentData];
    }
}

// 赋值
- (void)setObjectWithIndex:(NSIndexPath*)index withData:(NSDictionary *)data{
    currentIndex = index;
    currentData = data;
    
    self.shoppingModel = [[GoodsListModel alloc] initWithDataDic:data];
    self.GoodID.text = self.shoppingModel.productId;
    self.GoodDescription.text = self.shoppingModel.productName;
    [self.goodImage setImageWithURL:[NSURL URLWithString:self.shoppingModel.previewPicPath]];
    NSString *procuctQuantity = [[GoodsDetailDataBase shareDataBase]readTableQualityWithProductID:self.shoppingModel.productId];
    CGFloat tempPrice = self.shoppingModel.costPrice.floatValue * ((procuctQuantity.intValue==0)?1:procuctQuantity.intValue);
    self.GoodPrice.text = [NSString stringWithFormat:@"%.2f元",tempPrice];
    self.GoodQuantity.text = procuctQuantity?procuctQuantity:@"1";
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(shoppingTextFieldDidBeginEditing:)]) {
        [self.shoppingDelegate shoppingTextFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.intValue < 1) {
        textField.text = @"1";
        return;
    }
    [[GoodsDetailDataBase shareDataBase] updateItem:self.shoppingModel andProNumber:self.GoodQuantity.text];
    
    if (self.shoppingDelegate && [self.shoppingDelegate respondsToSelector:@selector(shoppingTextFieldDidEndEditing:)]) {
        [self.shoppingDelegate shoppingTextFieldDidEndEditing:textField];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)whenCellDidSelected{
//    GoodsInfoType goodType = GoodsType_None;
//    if (self.shoppingModel.productType.intValue == 1)
//        goodType =GoodsType_BirthDay;
//    else if (self.shoppingModel.productType.intValue == 2)
//        goodType = GoodsType_Holiday;
//    else goodType = GoodsType_Holiday;
    
    GoodsInfoController *goodsInfoVC = [[GoodsInfoController alloc]  initWithNibName:@"GoodsInfoController" bundle:nil];
    goodsInfoVC.goodsInfoType = GoodsType_Discount ;
    goodsInfoVC.productID = self.shoppingModel.productId;
    [selected_navigation_controller() pushViewController:goodsInfoVC animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
