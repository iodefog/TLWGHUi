//
//  ActivityNormalCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ActivityNormalCell.h"

@implementation ActivityNormalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)changeShowType:(ShowType)myShowType{
    showType = myShowType;
    if (myShowType == showSignUp) {
        self.eventName.text = @"报名时间";
    }else{
        self.eventName.text = @"投票选择";
    }
}

- (void)setObject:(NSDictionary *)dict{
    if (showType == showSignUp) {
        
    }else{
        self.eventDetail.text = dict[@"voteName"];
    }  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
