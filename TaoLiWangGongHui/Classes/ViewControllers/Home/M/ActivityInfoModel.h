//
//  ActivityInfoModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface ActivityInfoModel : ITTBaseModelObject
/***
 	活动id(activityId)
 	活动图片(activityPic)
 	活动名称(activityTitle)
 	活动介绍（description）(html样式）
 	发布时间（publishDatetime）
 	状态（0未过期，1已过去）status
 */
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *activityPic;
@property (nonatomic, strong) NSString *activityTitle;
@property (nonatomic, strong) id       description;
@property (nonatomic, strong) NSString *publishDatetime;
@property (nonatomic, strong) NSString *status;

@end
