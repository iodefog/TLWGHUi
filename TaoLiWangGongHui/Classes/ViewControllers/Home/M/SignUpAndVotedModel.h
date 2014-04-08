//
//  SignUpAndVotedModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface SignUpAndVotedModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *joinTime;
@property (nonatomic, strong) NSDictionary *member;
@property (nonatomic, strong) NSDictionary *activityVote;

/*****
 	报名时间（joinTime）
 	用户的为数组格式
 	member{
 	会员id(memberId)
 	姓名(realname)
 	所在部门(property0)
 	}
 */

@end
