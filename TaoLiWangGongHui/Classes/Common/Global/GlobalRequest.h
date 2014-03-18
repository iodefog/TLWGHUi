//
//  GlobalRequest.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Login_Request
}RequestType;

@interface GlobalRequest : ITTASIBaseDataRequest  //全局网路请求基础

+ (NSString *)getBaseServiceUrl;  // 网路请求前拼

#pragma mark -   一、注册登陆相关功能接口

//  1.用户登录接口
+ (NSString *)userAction_Login_Url;

//	2.用户信息接口
+ (NSString *)userAction_queryUserInfo_Url;

//	3.用户信息维护—手机号码修改接口
+ (NSString *)userAction_UpdateMobile_Url;

//	4.用户信息维护—邮箱修改接口
+ (NSString *)userAction_UpdateEmail_Url;

//  5.用户信息维护—密码修改接口
+ (NSString *)userAction_UpdatePassword_Url;

//  6.密码找回—短息找回接口
+ (NSString *)userAction_QueryPasswordByMessage_Url;

//  7.密码找回—邮件找回接口
+ (NSString *)userAction_QueryPasswordByEmail_Url;

#pragma mark -  二、	首页
// 8.首页接口
+ (NSString *)eCMainAction_QueryECMainInfo_Url;

// 9.工会活动接口
+ (NSString *)activityAction_QueryActivityList_Url;

//  10.工会活动详细接口
+ (NSString *)activityAction_QueryActivityInfo_Url;

//	11.工会活动查看接口(我的活动)
+ (NSString *)activityAction_QueryActivityStatus_Url;

//	12.工会活动—报名接口
+ (NSString *)activityAction_EnterActivity_Url;

//	13.工会活动—投票选项列表接口
+ (NSString *)activityAction_QueryActivityOptionList_Url;

//	14.工会活动—投票记录接口
+ (NSString *)activityAction_AddVote_Url;

//	15.娱乐信息列表接口
+ (NSString *)activityAction_QueryJokeList_Url;

// 	16.福利商品列表接口
+ (NSString *)productAction_QueryProductListByType_Url;

// 	17.福利商品详情接口
//  19.	购物商品详细接口
+ (NSString *)productAction_QueryProducInfo_Url;

// 	18.福利购物商品列表接口
//  20.	购物车接口
+ (NSString *)productAction_QueryProductListByIds_Url;

#pragma mark - 三、	购物车
// 21.	去结算接口
+ (NSString *)orderAction_Pay_Url;

// 22.	提交订单接口
+ (NSString *)orderAction_Submit_Url;

#pragma mark - 四、	通知接口
// 23.	通知列表接口
+ (NSString *)articleAction_QueryAdList_Url;

// 24.	广告详细接口
+ (NSString *)articleAction_QueryAdInfo_Url;

// 25.	订阅栏目列表接口
+ (NSString *)articleAction_QuerySubscription_Url;

// 26.	订阅/取消订阅接口
+ (NSString *)articleAction_DoSubscription_Url;

#pragma mark - 五、	我的活动
// 27.	我的活动接口
+ (NSString *)articleAction_QueryMyActivityList_Url;

#pragma mark - 六、	个人中心
// 28.	配送信息获取接口
+ (NSString *)addressAction_QueryAddressList_Url;

// 29.	新增配送信息接口
+ (NSString *)addressAction_AddAddress_Url;

// 30.	修改配送信息接口
+ (NSString *)addressAction_UpdateAddress_Url;

// 31.	删除配送信息接口
+ (NSString *)addressAction_deleteAddress_Url;

// 32.	我的订单接口
+ (NSString *)orderAction_QueryOrderList_Url;

// 33.	订单详情接口
+ (NSString *)orderAction_QueryOrderInfo_Url;

// 34.	意见反馈接口
+ (NSString *)userAction_Feedback_Url;

// 35.	版本信息接口
+ (NSString *)userAction_QuerySystemInfo_Url;
@end
