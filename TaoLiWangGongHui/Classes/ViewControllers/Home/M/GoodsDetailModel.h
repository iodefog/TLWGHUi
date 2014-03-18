//
//  GoodsDetailModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GoodsDetailModel : ITTBaseModelObject

@property (nonatomic, strong) NSMutableArray *productPictures;
@property (nonatomic, strong) NSString       *productName;
@property (nonatomic, strong) NSString       *productDescribe;
@property (nonatomic, strong) NSString       *basicPrice;
@property (nonatomic, strong) NSString       *costPrice;

/****
 	商品图片(数组结构）productPictures
 	商品名称（productName）
 	介绍图片（带文字的图片）(productDescribe)
 */

/****
 	商品图片（数组）（productPicture）
 	商品名称（productName）
 	原价(basicPrice)
 	现价(costPrice)
 	介绍图片（带文字的图片）(productDescribe)
 */


@end
