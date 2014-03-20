//
//  UserInfoModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-20.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface UserInfoModel : ITTBaseModelObject

@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *memberName;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) id       headImage;

/*****
 	头像(去掉，存客户端)
 	手机号码:phone
  用户名 memberName
 	邮箱:email
 */

@end
