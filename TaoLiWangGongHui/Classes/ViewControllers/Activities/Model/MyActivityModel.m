//
//  MyActivityModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "MyActivityModel.h"

@implementation MyActivityModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"activityId": @"activityId",
             @"activityPic":@"activityPic",
             @"activityTitle":@"activityTitle",
             @"publishDatetime":@"publishDatetime",
             @"status":@"status",};
}

@end
