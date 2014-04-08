//
//  OrderProductModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-4-4.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "OrderProductModel.h"

@implementation OrderProductModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"productId":@"productId",
             @"previewPicPath":@"previewPicPath",
             @"productName":@"productName",
             @"productDescribe":@"productDescribe",
             @"amount":@"amount",
             @"totalMoney":@"totalMoney",
             @"totalScore":@"totalScore"};
    /****
     	商品id(productId)
     	商品图片(previewPicPath)
     	名称(productName)
     	介绍(productDescribe)
     	数量(amount)
     	金额小计(totalMoney)
     	积分小计（totalScore）
     */
}

@end
