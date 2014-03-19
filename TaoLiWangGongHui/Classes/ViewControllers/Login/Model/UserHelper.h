//
//  UserHelper.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserHelper : NSObject

+ (id) shareInstance;

// 获取用户ID
- (NSString *)getMemberID;
// 移除用户ID
- (BOOL)removeMemberID;
// 保存用户ID
- (BOOL)saveMemberID:(NSDictionary *)dict;

@end
