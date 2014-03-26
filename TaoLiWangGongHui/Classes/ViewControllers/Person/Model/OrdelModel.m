//
//  OrdelModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "OrdelModel.h"

@implementation OrdelModel

- (NSDictionary *)attributeMapDictionary{

    return @{@"orderId":@"orderId",
             @"orderCode":@"orderCode",
             @"totalMoney":@"totalMoney",
             @"totalScore":@"totalScore",
             @"orderDate":@"orderDate",
             };
}

@end
