//
//  UserHelper.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UserHelper.h"

@implementation UserHelper
static UserHelper *helper = nil;

+ (id)shareInstance{
    if (!helper) {
        helper = [[UserHelper alloc] init];
    }
    return helper;
}

- (NSString *)getMenberID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"memberID"];
}

- (BOOL)saveMenberID:(NSDictionary *)dict{
    BOOL mm = YES;
    NSString *memberID = nil;
    if ([dict[@"result"] isKindOfClass:[NSNumber class]]) {
        memberID = [NSString stringWithFormat:@"%d", ((NSNumber *)dict[@"result"]).intValue];
    }else if([dict[@"result"] isKindOfClass:[NSString class]]){
        memberID = dict[@"result"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:memberID forKey:@"memberID"];
    return mm;
}

@end
