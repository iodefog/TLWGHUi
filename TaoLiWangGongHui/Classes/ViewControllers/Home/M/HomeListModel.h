//
//  GoodsListModel.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface HomeListModel : ITTBaseModelObject

/**
 	类型(typeId)：1：活动， 3：笑话
 	Id(activityId)：（活动id或者笑话id）
 	标题(activityTitle)：（活动标题、笑话标题）
 	图片(activityPic)：（活动图片）
 	内容(description)：（笑话内容）
 */

@property (nonatomic, strong) NSString *typeId;
@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *activityPic;
@property (nonatomic, strong) NSString *activityTitle;
@property (nonatomic, strong) NSString *description;

@end
