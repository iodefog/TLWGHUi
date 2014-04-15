//
//  TimeObject.h
//  FBSecond
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 hong. All rights reserved.
//



typedef NS_ENUM(NSInteger, CarHaveSameGoods) {
    CarHaveSameGoodsNomal = 0,
    CarHaveSameGoodsPoint,
    CarHaveSameGoodsMoney
};
#import <Foundation/Foundation.h>
@interface TimeObject : NSObject

/**
 *  从时间转换为时间戳
 */
+(NSString *)currentTime;

/**
 *  从时间戳转换为时间
 */
+(NSString *)fromTimeChuoTotime:(NSString *)timeChuo;



/****
 *打包使用期限限制
 */
+ (BOOL)SenderlimitTime;


@end
