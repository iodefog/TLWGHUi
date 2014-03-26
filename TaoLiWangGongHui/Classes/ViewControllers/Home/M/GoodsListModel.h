//
//  GoodsListModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GoodsListModel : ITTBaseModelObject

/****
 	商品id（productId）
 	商品图片(previewPicPath)
 	商品名称（productName）
 	商品介绍（productDescribe）
 	原价(basicPrice)
 	现价(costPrice)
 	商品类型 productType（参考：1为生日福利，2为节日福利，3为购物商品）
 	商品数量 productQuality
 */

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *previewPicPath;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productDescribe;
@property (nonatomic, strong) NSString *productType;
@property (nonatomic, strong) NSString *basicPrice;
@property (nonatomic, strong) NSString *costPrice;
@property (nonatomic, strong) NSString *productQuantity;

@end
