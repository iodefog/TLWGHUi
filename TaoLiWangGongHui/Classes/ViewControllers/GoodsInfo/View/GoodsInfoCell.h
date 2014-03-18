//
//  GoodsInfoCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListModel.h"

@interface GoodsInfoCell : UITableViewCell <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *goodsScroll; // 可滑动的scroll，显示商品图片
@property (strong, nonatomic) IBOutlet UILabel *goodsDescription; // 商品描述
@property (strong, nonatomic) IBOutlet UILabel *discount;         // 打折后的价格
@property (strong, nonatomic) IBOutlet UILabel *originalPrice;    // 原价
@property (strong, nonatomic) IBOutlet UILabel *imagePage;        // 当前scroll 显示的是第几张图
@property (strong, nonatomic) IBOutlet UIView *sperateLine;
@property (strong, nonatomic) GoodsListModel *goodsListModel;

- (void)createUI; // 用来创建scroll的图片，也可传入参数修改，自己需先传入参数，这里暂时为无参函数

- (void)setObject:(NSDictionary *)params;

@end
