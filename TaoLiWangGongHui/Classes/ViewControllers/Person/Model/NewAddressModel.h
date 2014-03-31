//
//  NewAddressModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

/****
 * 不用 #import "AddressModel.h", 用现在这个
 */

@interface NewAddressModel : ITTBaseModelObject
@property (nonatomic, strong) NSString *receiverAddressId;
@property (nonatomic, strong) NSString *receiverAddress;
@property (nonatomic, strong) NSString *receiverName;
@property (nonatomic, strong) NSString *receiverPhone;
@property (nonatomic, strong) NSString *receiverPostalcode;
@property (nonatomic, strong) NSString *isDefault;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *email;

/******
 	地址id（receiverAddressId）
 	地址信息（receiverAddress）
 	姓名（receiverName）
 	手机号码（receiverPhone）
 	邮编(receiverPostalcode)
 	是否首选地址（isDefault）1 是 0 否
 	地区(city)
 */

@end
