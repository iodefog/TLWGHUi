//
//  GoodsDetailModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"productPicture":@"productPicture",
             @"productName":@"productName",
             @"basicPrice":@"basicPrice",
             @"costPrice":@"costPrice",
             @"productDescribe":@"productDescribe"
             };
}

@end
