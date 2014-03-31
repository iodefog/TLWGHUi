//
//  GetCityDataRequest.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-19.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GetCityDataRequest.h"

@implementation GetCityDataRequest
-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    NSString *url = [GlobalRequest addressAction_QueryProvinceAndRegionList_Url];
    return url;
}


- (void)processResult
{
    [super processResult];
    NSMutableArray *ProvieAndCityArray = self.handleredResult[@"result"];
    NSMutableArray *ProviedataArray = [[NSMutableArray alloc]init];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in ProvieAndCityArray) {
        if ([dict[@"dm"] length] ==3) {
            [arr addObject:dict];
        }
    }
    
    for (NSMutableDictionary * dict02 in arr) {
        NSMutableArray *arr01 = [[NSMutableArray alloc]init];
        [arr01 removeAllObjects];
        for (NSDictionary *dict01 in ProvieAndCityArray) {
            if ([dict01[@"dm"] length] == 6) {
                if ([[dict01[@"dm"] substringToIndex:3] isEqualToString:dict02[@"dm"]]) {
                    [arr01 addObject:dict01];
                }
                
            }
        }
        NSMutableDictionary *DataDic = [[NSMutableDictionary alloc]initWithDictionary:dict02];
        [DataDic setObject:arr01 forKey:@"Cities"];
        [ProviedataArray addObject:DataDic];
    }
     [self.handleredResult setObject:ProviedataArray forKey:@"ProviedataArray"];
}
@end
