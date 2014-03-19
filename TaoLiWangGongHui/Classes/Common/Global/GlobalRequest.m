//
//  GlobalRequest.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GlobalRequest.h"

@implementation GlobalRequest

+ (NSString *)getBaseServiceUrl{
    NSString *serviceUrl = @"http://www.ugift.com.cn:8088/Interface/";
    return serviceUrl;
}

#pragma mark -   一、注册登陆相关功能接口



//	1.用户信息接口
+ (NSString *)userAction_queryUserInfo_Url{
 return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!queryUserInfo.do"];
}

//	2.用户信息维护—手机号码修改接口
+ (NSString *)userAction_UpdateMobile_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!updateMobile.do"];
}

//	3.用户信息维护—邮箱修改接口
+ (NSString *)userAction_UpdateEmail_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!updateEmail.do"];
}

//  4.用户信息维护—密码修改接口
+ (NSString *)userAction_UpdatePassword_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!updatePassword.do"];
}

//  5.密码找回—短息找回接口
+ (NSString *)userAction_QueryPasswordByMessage_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!queryPasswordByMessage.do"];
}

//  6.密码找回—邮件找回接口
+ (NSString *)userAction_QueryPasswordByEmail_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!queryPasswordByEmail.do"];
}

// 7.用户登录接口
+ (NSString *)userAction_Login_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!login.do"];
}

#pragma mark -  二、	首页
// 8.首页接口
+ (NSString *)eCMainAction_QueryECMainInfo_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ECMainAction!queryECMainInfo.do"];
}

// 9.工会活动接口
+ (NSString *)activityAction_QueryActivityList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!queryActivityList.do"];
}

//  10.工会活动详细接口
+ (NSString *)activityAction_QueryActivityInfo_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!queryActivityInfo.do"];
}

//	11.工会活动查看接口(我的活动)
+ (NSString *)activityAction_QueryActivityStatus_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!queryActivityStatus.do"];
}

//	12.工会活动—报名接口
+ (NSString *)activityAction_EnterActivity_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!enterActivity.do"];
}

//	13.工会活动—投票选项列表接口
+ (NSString *)activityAction_QueryActivityOptionList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!queryActivityOptionList.do"];
}

//	14.工会活动—投票记录接口
+ (NSString *)activityAction_AddVote_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!addVote.do"];
}

//	15.娱乐信息列表接口
+ (NSString *)activityAction_QueryJokeList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ActivityAction!queryJokeList.do"];
}

// 	16.福利商品列表接口
+ (NSString *)productAction_QueryProductListByType_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ProductAction!queryProductListByType.do"];
}

// 	17.福利商品详情接口
//  19.	购物商品详细接口
+ (NSString *)productAction_QueryProducInfo_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ProductAction!queryProductInfo.do"];
}

// 	18.福利购物商品列表接口
//  20.	购物车接口
+ (NSString *)productAction_QueryProductListByIds_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ProductAction!queryProductListByIds.do"];
}


#pragma mark - 三、	购物车
// 21.	去结算接口
+ (NSString *)orderAction_Pay_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"OrderAction!pay.do"];
}

// 22.	提交订单接口
+ (NSString *)orderAction_Submit_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"OrderAction!submit.do"];
}

#pragma mark - 四、	通知接口
// 23.	通知列表接口
+ (NSString *)articleAction_QueryAdList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ArticleAction!queryAdList.do"];
}

// 24.	广告详细接口
+ (NSString *)articleAction_QueryAdInfo_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ArticleAction!queryAdInfo.do"];
}

// 25.	订阅栏目列表接口
+ (NSString *)articleAction_QuerySubscription_Url{
 return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ArticleAction!querySubscription.do"];
}

// 26.	订阅/取消订阅接口
+ (NSString *)articleAction_DoSubscription_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ArticleAction!doSubscription.do"];
}

#pragma mark - 五、	我的活动
// 27.	我的活动接口
+ (NSString *)articleAction_QueryMyActivityList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"ArticleAction!queryMyActivityList.do"];
}

#pragma mark - 六、	个人中心
// 28.	配送信息获取接口
+ (NSString *)addressAction_QueryAddressList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"AddressAction!queryAddressList.do"];
}

// 29.	新增配送信息接口
+ (NSString *)addressAction_AddAddress_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"AddressAction!addAddress.do"];
}

// 30.	修改配送信息接口
+ (NSString *)addressAction_UpdateAddress_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"AddressAction!updateAddress.do"];
}

// 31.	删除配送信息接口
+ (NSString *)addressAction_deleteAddress_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"AddressAction!deleteAddress.do"];
}

// 32.	我的订单接口
+ (NSString *)orderAction_QueryOrderList_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"OrderAction!queryOrderList.do"];
}

// 33.	订单详情接口
+ (NSString *)orderAction_QueryOrderInfo_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"OrderAction!queryOrderInfo.do"];
}

// 34.	意见反馈接口
+ (NSString *)userAction_Feedback_Url{
return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!feedback.do"];
}

// 35.	版本信息接口
+ (NSString *)userAction_QuerySystemInfo_Url{
    return [NSString stringWithFormat:@"%@%@",[GlobalRequest getBaseServiceUrl],@"UserAction!querySystemInfo.do"];
}

@end
