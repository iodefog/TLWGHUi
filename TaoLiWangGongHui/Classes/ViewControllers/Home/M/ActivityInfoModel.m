//
//  ActivityInfoModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ActivityInfoModel.h"

@implementation ActivityInfoModel

- (NSDictionary *)attributeMapDictionary{
    return @{@"activityId":@"activityId",
             @"activityPic": @"activityPic",
             @"activityTitle": @"activityTitle",
             @"description": @"description",
             @"publishDatetime": @"publishDatetime",
             @"status":@"status"};
}

@end
