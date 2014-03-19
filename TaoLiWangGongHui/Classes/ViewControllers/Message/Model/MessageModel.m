//
//  MessageModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-19.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"newsId": @"newsId",
             @"newsPicPath": @"newsPicPath",
             @"newsTitle": @"newsTitle",
             @"status":@"status"};
}

@end
