//
//  OrdelModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface OrdelModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderCode;
@property (nonatomic, strong) NSString *totalMoney;
@property (nonatomic, strong) NSString *totalScore;
@property (nonatomic, strong) NSString *orderDate;
@property (nonatomic, strong) NSDictionary *orderReceiver;
@property (nonatomic, strong) NSArray *orderProducts;


// orderPorducts 里的数据解析，两层共用一个class


/*****
 	订单id（orderId）
 	订单号(orderCode)
 	订单金额(totalMoney)
 	积分（totalScore）
 	下单时间(orderDate)
 **/

@end
