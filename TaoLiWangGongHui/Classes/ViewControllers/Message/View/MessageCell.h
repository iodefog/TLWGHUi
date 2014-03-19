//
//  MessageCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"
@interface MessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *goodImage;
@property (strong, nonatomic) IBOutlet UILabel *goodDescription;
@property (strong, nonatomic) MessageModel *messageModel;

- (void)setObject:(NSDictionary *)dict;


@end
