//
//  UserModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-28.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface UserModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *birthday;

/****
 	用户id: memberId
 	生日：birthday
 */

@end
