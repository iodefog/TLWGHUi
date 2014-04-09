//
//  UINarmolViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapkuLibrary.h"

@interface ViewController : UIViewController  // 用来做父类，方便一些全局操作，例如返回按钮修改
@property (nonatomic, strong) id model;
@property (nonatomic, strong) TKEmptyView *emptyView;

- (void)reloadNewData; // 数据接收成功后 用新数据刷新view
- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url; // 根据url和参数 提交到网络
- (void)setDataDic:(NSDictionary *)resultDic withRequest:(id)request; // 数据完成后回调的函数

#pragma mark - Response Success
- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request;
#pragma mark - Response Fail
- (void)responseFailWithResponse:(ITTBaseDataRequest *)request;
#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request;


// 无数据时，显示的图片
- (UIImage *)emptyImage;
// 无数据时，显示的标题
- (NSString *)emptyTitle;
// 无数据时，显示的子标题
- (NSString *)emptySubTitle;
// 当无数据时，显示空图
- (void)showEmptyView;
// 当有数据是，移除空图
- (void)hideEmptyView;

- (void)back;
@end
