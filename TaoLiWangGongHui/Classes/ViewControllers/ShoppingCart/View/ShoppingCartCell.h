//
//  ShoppingCartCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@protocol ShoppingDelegate <NSObject>
@optional
// 删除按钮点击回调
- (void)responseWithIndex:(NSIndexPath *)index withData:(id)data;
// 文本框开始编辑
- (void)shoppingTextFieldDidBeginEditing:(UITextField *)textField;
// 文本框结束编辑
- (void)shoppingTextFieldDidEndEditing:(UITextField *)textField;

// 减少商品数量
- (void)reduceGoodsQuantityWithPrice:(float)price;
// 增加商品数据
- (void)increaseGoodsQuantityWithPrice:(float)price;
@end

@interface ShoppingCartCell : UITableViewCell <ShoppingDelegate ,UITextFieldDelegate>{
    NSIndexPath         *currentIndex ;
    id                  currentData;
}
@property (nonatomic, assign) id shoppingDelegate; // 用来删除时做出回调

@property (strong, nonatomic) IBOutlet UIView *baseView;// 整个cell的底视图，用来做偏移

@property (strong, nonatomic) IBOutlet UIImageView *goodImage;    // 购物车，商品图片
@property (strong, nonatomic) IBOutlet UILabel *GoodDescription;  // 购物车, 商品说明
@property (strong, nonatomic) IBOutlet UILabel *GoodID;           // 购物车，商品编号
@property (strong, nonatomic) IBOutlet UILabel *GoodPrice;        // 购物车，商品价格
@property (strong, nonatomic) IBOutlet UITextField *GoodQuantity; // 购物车，商品个数
@property (strong, nonatomic) IBOutlet UIButton *deleteButton; // 删除按钮
@property (strong, nonatomic) GoodsListModel *shoppingModel;

- (void)setObjectWithIndex:(NSIndexPath *)index withData:(NSDictionary *)data;

- (void)showDeleteButton:(BOOL)show;

// 当用户点击时触发
- (void)whenCellDidSelected;
@end
