//
//  AddressModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(NSDictionary *)attributeMapDictionary{
    return @{@"Name": @"receiverName",
             @"AddressId": @"id",
             @"Address": @"receiverAddress",
             @"Email": @"email",
             @"Phone": @"receiverPhone",
             @"ZipCode":@"receiverPostalcode",
             @"Type":@"Type",
             @"City":@"city"};
}
@end
