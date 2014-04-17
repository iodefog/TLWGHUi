//
//  GoodsInfoModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GoodsInfoModel.h"

@implementation GoodsInfoModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"productPictures":@"productPictures",
             @"productName":@"productName",
             @"basicPrice":@"basicPrice",
             @"costPrice":@"costPrice",
             @"productDescribe":@"productDescribe",
             @"productType":@"productType",
             @"productId":@"productId"
             };
    
}

@end
