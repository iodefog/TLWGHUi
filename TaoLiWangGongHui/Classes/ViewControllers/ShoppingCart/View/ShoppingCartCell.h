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
- (void)responseWithIndex:(NSIndexPath *)index withData:(id)data;
- (void)shoppingTextFieldDidBeginEditing:(UITextField *)textField;
- (void)shoppingTextFieldDidEndEditing:(UITextField *)textField;

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

@end
