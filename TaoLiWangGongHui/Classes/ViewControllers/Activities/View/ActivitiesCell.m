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
    [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:self.activityModel.activityPic] options:0 progress:^(NSUInteger receivedSize, long long expectedSize) {
        /**
         * progress
         */
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        if (finished && !error && image && self.activityModel.status.boolValue) {
            UIImage *temp = [[UIImage alloc] initWithData:UIImageJPEGRepresentation(image, 1.0f)];
            self.activityImage.image = [GlobalHelper grayscale:temp type:1];;
        }else{
            self.activityImage.image = image;
        }
    }];

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
