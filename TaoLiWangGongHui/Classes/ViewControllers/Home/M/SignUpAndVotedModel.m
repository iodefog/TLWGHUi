//
//  SignUpAndVotedModel.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "SignUpAndVotedModel.h"

@implementation SignUpAndVotedModel

- (NSDictionary *)attributeMapDictionary{
   return  @{@"joinTime":@"joinTime",
             @"member":@"member",
             @"activityVote":@"activityVote"};
}

@end
