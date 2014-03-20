//
//  UserInfoModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-20.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (NSDictionary *)attributeMapDictionary{
return @{@"phone": @"phone",
         @"memberName": @"memberName",
         @"email": @"email",
         @"headImage": @"headImage",};
}

@end
