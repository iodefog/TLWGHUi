//
//  ActivitiesCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "ActivitiesCell.h"

@implementation ActivitiesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.activityImage.backgroundColor = UIColorFromRGB(0xF0ECEC);
}

- (void)setObject:(NSDictionary *)dict{
    self.activityModel = [[MyActivityModel alloc] initWithDataDic:dict[@"activity"]];
    [self.activityImage setImageWithURL:[NSURL URLWithString:self.activityModel.activityPic]];
    self.activityDescription.text = self.activityModel.activityTitle;
    self.activityTime.text = self.activityModel.publishDatetime;
    if (self.activityModel.status.boolValue) {
        self.activityTime.textColor = [UIColor lightGrayColor];
        self.activityDescription.textColor = [UIColor lightGrayColor];
        self.activityTime.text = @"已过期";
    }else{
        self.activityTime.textColor = [UIColor blackColor];
        self.activityDescription.textColor = [UIColor blackColor];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
