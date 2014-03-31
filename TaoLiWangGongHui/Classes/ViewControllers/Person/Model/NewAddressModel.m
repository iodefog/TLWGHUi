//
//  NewAddressModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "NewAddressModel.h"

@implementation NewAddressModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"receiverAddressId":@"receiverAddressId",
             @"receiverAddress":@"receiverAddress",
             @"receiverName":@"receiverName",
             @"receiverPhone":@"receiverPhone",
             @"receiverPostalcode":@"receiverPostalcode",
             @"isDefault":@"isDefault",
             @"city":@"city",
             @"email":@"email"};
}

@end
