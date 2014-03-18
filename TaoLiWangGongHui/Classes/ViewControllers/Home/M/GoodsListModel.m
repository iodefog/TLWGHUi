//
//  GoodsListModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GoodsListModel.h"

@implementation GoodsListModel

- (NSDictionary *)attributeMapDictionary{
    return @{
             @"productId":@"productId",
             @"previewPicPath":@"previewPicPath",
             @"productName":@"productName",
             @"productDescribe":@"productDescribe",
             @"productType":@"productType",
             @"basicPrice":@"basicPrice",
             @"costPrice":@"costPrice",
             @"productQuantity":@"productQuantity"
             };
}

@end
