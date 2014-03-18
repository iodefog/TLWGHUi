//
//  GoodsInfoController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

/*** 共用一个福利详情页
 */
typedef enum{
    GoodsType_BirthDay, // 生日福利
    GoodsType_Holiday,  // 节日福利
    GoodsType_Discount  // 优惠购物
}  GoodsInfoType;

@interface GoodsInfoController : TableViewController
{
    GoodsInfoType goodsInfoType;
    NSString      *productID;
}

- (id)initWithType:(GoodsInfoType)myGoodsInfoType withProductID:(NSString *)myProductID; // 传入相应类型，生日，节日，优惠购物等

@end
