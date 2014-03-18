//
//  ActivityNormalController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityNormalCell.h"

@interface ActivityNormalController : TableViewController{
    ShowType showType;
    NSString *activityID;
    NSString *activityVoteId;
}

- (id)initWithShowType:(ShowType)myShowType withActivityID:(NSString *)myActivityID withActivityVoteId:(NSString *)myActivityVoteId;

@end
