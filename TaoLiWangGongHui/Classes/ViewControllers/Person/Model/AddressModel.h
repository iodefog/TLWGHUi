//
//  AddressModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

/****
 * 这是本地服务器解析的，现在数据从网络获取，不用这个，用的是 #import "NewAddressModel.h"
 */

@interface AddressModel : ITTBaseModelObject
@property (nonatomic, strong) NSString            *Name;          //姓名
@property (nonatomic, strong) NSNumber*           AddressId;     //地址id   //默认用UserID
@property (nonatomic, strong) NSString            *Address;       //地址
@property (nonatomic, strong) NSString            *Province;      //省份代码
@property (nonatomic, strong) NSString            *Phone;         //手机号码
@property (nonatomic, strong) NSString            *Email;         //邮箱
@property (nonatomic, strong) NSString            *ZipCode;       //邮编
@property (nonatomic, strong) NSString            *Type;          //是否首选地址
@property (nonatomic, strong) NSString            *City;          //地区代码
@end
