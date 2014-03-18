//
//  VoteModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-14.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface VoteModel : ITTBaseModelObject

@property (nonatomic, strong) NSString *activityVoteId;
@property (nonatomic, strong) NSString *voteName;

/***
 	选项id(activityVoteId)
 	选项名称(voteName)
 */

@end
