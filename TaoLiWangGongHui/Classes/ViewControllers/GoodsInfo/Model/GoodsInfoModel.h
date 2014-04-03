//
//  GoodsInfoModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface GoodsInfoModel : ITTBaseModelObject

@property (nonatomic, strong) NSArray *productPictures;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *basicPrice;
@property (nonatomic, strong) NSString *costPrice;
@property (nonatomic, strong) NSString *productDescribe;

/*****
 	商品图片(数组结构）productPictures
 	商品名称（productName）
 	原价(basicPrice)
 	现价(costPrice)
 	介绍图片（带文字的图片）(productDescribe)
 */

@end
