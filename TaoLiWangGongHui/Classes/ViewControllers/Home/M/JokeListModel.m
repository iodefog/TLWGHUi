//
//  JokeListModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "JokeListModel.h"

@implementation JokeListModel

- (NSDictionary *)attributeMapDictionary{
   return  @{
             @"activityId":@"activityId",
             @"activityTitle":@"activityTitle",
             @"description":@"description",
             @"publishDatetime":@"publishDatetime"
      };
}

@end
