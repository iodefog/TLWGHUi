

//
//  ShoppingModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-17.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"productId": @"productId",
             @"previewPicPath": @"previewPicPath",
             @"productName": @"productName",
             @"basicPrice": @"basicPrice",
             @"costPrice": @"costPrice",
             @"productType": @"productType"};
}

@end
