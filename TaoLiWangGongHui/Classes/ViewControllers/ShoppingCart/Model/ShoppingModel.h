//
//  ShoppingModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-17.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface ShoppingModel : ITTBaseModelObject // 购物车
/***
 	商品id(productId)
 	商品图片(previewPicPath)
 	商品标题（productName）
 	原价(basicPrice)
 	现价(costPrice)
 	商品类型（productType）
 */

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *previewPicPath;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *basicPrice;
@property (nonatomic, strong) NSString *costPrice;
@property (nonatomic, strong) NSString *productType;



@end
