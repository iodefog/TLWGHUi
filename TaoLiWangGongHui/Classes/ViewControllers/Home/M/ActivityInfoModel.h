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
 	活动图片(activityPic)
 	活动名称(activityTitle)
 	活动介绍（description）(html样式）
 	发布时间（publishDatetime）
 */

@property (nonatomic, strong) NSString *activityPic;
@property (nonatomic, strong) NSString *activityTitle;
@property (nonatomic, strong) id       description;
@property (nonatomic, strong) NSString *publishDatetime;


@end
