//
//  JokeListModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface JokeListModel : ITTBaseModelObject

/**
 	笑话id(activityId)
 	笑话标题(activityTitle)
 	笑话内容(description)
 	发布时间(publishDatetime)
 */

@property (nonatomic, strong) NSString *activityId;
@property (nonatomic, strong) NSString *activityTitle;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *publishDatetime;

@end
