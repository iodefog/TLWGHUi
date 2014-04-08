//
//  OrderProductModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-4-4.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface OrderProductModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *previewPicPath;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productDescribe;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *totalScore;
/****
 	商品id(productId)
 	商品图片(previewPicPath)
 	名称(productName)
 	介绍(productDescribe)
 	数量(amount)
 	金额小计(totalMoney)
 	积分小计（totalScore）
*/

@end
