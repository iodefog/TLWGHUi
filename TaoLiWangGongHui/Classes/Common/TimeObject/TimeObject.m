//
//  TimeObject.m
//  FBSecond
//
//  Created by apple on 14-1-3.
//  Copyright (c) 2014年 hong. All rights reserved.
//

#import "TimeObject.h"
#import "GoodsListModel.h"
#import "GoodsDetailDataBase.h"


@implementation TimeObject



#pragma mark ========从时间转换为时间戳==========
+(NSString *)currentTime
{
    //把获取的时间转化为当前时间
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    //    NSLog(@"%@", datenow);
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; //时区
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    //    NSLog(@"%@", localeDate);
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    NSLog(@"时间戳的值:%@",timeSp); //时间戳的值
    
    return timeSp;
}


#pragma mark ========从时间戳转换为时间==========
+(NSString *)fromTimeChuoTotime:(NSString *)timeChuo{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *nowDate = [NSDate date];
    NSDate *yesterDate = [NSDate dateWithTimeInterval:-24*3600 sinceDate:nowDate];
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:[timeChuo doubleValue]];
    
    NSString *nowDateString = [formatter stringFromDate:nowDate];
    NSString *yesterDateString = [formatter stringFromDate:yesterDate];
    NSString *myDateString = [formatter stringFromDate:myDate];
    
    if ([myDateString isEqualToString:nowDateString]) {
        return @"今天";
    }else if([myDateString isEqualToString:yesterDateString]){
        return @"昨天";
    }else{
        return myDateString;
    }
}



@end
