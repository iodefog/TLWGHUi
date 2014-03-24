//
//  SignUpAndVotedModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface SignUpAndVotedModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *Property0;

/****
 	会员id(memberId)
 	姓名(realname)
 	报名时间（productName）
 	所在部门(Property0)
 */

@end
