//
//  SubscribeCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "SubscribeCell.h"

@implementation SubscribeCell

- (void)awakeFromNib
{
    // Initialization code
}
- (IBAction)subscribeClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
