//
//  UserHelper.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UserHelper.h"
#import "UserModel.h"
@implementation UserHelper
static UserHelper *helper = nil;

+ (id)shareInstance{
    if (!helper) {
        helper = [[UserHelper alloc] init];
    }
    return helper;
}

- (NSString *)getMemberID{
    NSString *memberId = [[NSUserDefaults standardUserDefaults] objectForKey:@"memberID"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"memberID"]) {
        memberId = [[NSUserDefaults standardUserDefaults] objectForKey:@"memberID"];
    }else{
        memberId = @"";
    }
    return memberId;
}

- (BOOL)removeMemberID{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"memberID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (BOOL)saveMemberID:(NSDictionary *)dict{
    BOOL mm = YES;
    NSDictionary *result = nil;
    if ([dict[@"result"] isKindOfClass:[NSArray class]] && [dict[@"result"] count]>0) {
        result = [dict[@"result"] firstObject];
    }
    UserModel *userModel = [[UserModel alloc] initWithDataDic:result];
    
     [[NSUserDefaults standardUserDefaults] setObject:userModel.memberId forKey:@"memberID"];
    [[NSUserDefaults standardUserDefaults] setObject:userModel.birthday forKey:[NSString stringWithFormat:@"birthday_%@",userModel.memberId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return mm;
}

@end
