//
//  MessageCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "MessageCell.h"
@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setObject:(NSDictionary *)dict{
    self.messageModel = [[MessageModel alloc] initWithDataDic:dict];
    [self.goodImage setImageWithURL:[NSURL URLWithString:self.messageModel.newsPicPath]];
    self.goodDescription.text = self.messageModel.newsTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
