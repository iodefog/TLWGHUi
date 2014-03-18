//
//  MyActivityModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MyActivityModel : ITTBaseModelObject
/***
 	活动id(activityId)
 	活动图片(activityPic)
 	活动名称(activityTitle)
 	活动时间（publishDatetime）
 	状态（0未过期，1已过去）status
 */

@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *activityPic;
@property (nonatomic, strong) NSString *activityTitle;
@property (nonatomic, strong) NSString *publishDatetime;
@property (nonatomic, strong) NSString *status;


@end
