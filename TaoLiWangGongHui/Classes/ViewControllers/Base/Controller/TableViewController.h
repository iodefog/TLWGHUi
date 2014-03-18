//
//  TableViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PAGESIZE @"10"

@interface TableViewController : UITableViewController // 写法与ViewController 一样

@property (nonatomic, strong) id model;

- (void)reloadNewData; // 数据接收成功后 用新数据刷新view
- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url; // 根据url和参数 提交到网络
- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager; // 数据完成后回调的函数

#pragma mark - Response Success
- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request;
#pragma mark - Response Fail
- (void)responseFailWithResponse:(ITTBaseDataRequest *)request;
#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request;

@end
