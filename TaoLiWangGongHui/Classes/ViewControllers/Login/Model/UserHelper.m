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
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"memberID"];
}

- (BOOL)removeMemberID{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"memberID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

- (BOOL)saveMemberID:(NSDictionary *)dict{
    BOOL mm = YES;
//    NSString *memberID = nil;
    NSDictionary *result = nil;
    if ([dict[@"result"] isKindOfClass:[NSArray class]] && [dict[@"result"] count]>0) {
        result = [dict[@"result"] firstObject];
    }
    UserModel *userModel = [[UserModel alloc] initWithDataDic:result];
    
    /**
    if ([result[@"memberId"] isKindOfClass:[NSNumber class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:result[@"birthday"] forKey:[NSString stringWithFormat:@"birthday_%d",memberID.intValue]];
        [[NSUserDefaults standardUserDefaults] synchronize];
        memberID = [NSString stringWithFormat:@"%d", ((NSNumber *)result[@"memberId"]).intValue];
    }else if([result[@"memberId"] isKindOfClass:[NSString class]]){
        memberID = result[@"memberId"];
        [[NSUserDefaults standardUserDefaults] setObject:result[@"birthday"] forKey:[NSString stringWithFormat:@"birthday_%@",memberID]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
     */
     [[NSUserDefaults standardUserDefaults] setObject:userModel.memberId forKey:@"memberID"];
    [[NSUserDefaults standardUserDefaults] setObject:userModel.birthday forKey:[NSString stringWithFormat:@"birthday_%@",userModel.memberId]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return mm;
}

@end
