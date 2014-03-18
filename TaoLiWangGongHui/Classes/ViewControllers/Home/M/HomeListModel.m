//
//  GoodsListModel.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel
-(NSDictionary *)attributeMapDictionary
{
    return @{@"activityId":@"activityId"
             ,@"activityPic":@"activityPic"
             ,@"activityTitle":@"activityTitle"
             ,@"description":@"description"
             ,@"typeId":@"typeId"
             };
}
@end
