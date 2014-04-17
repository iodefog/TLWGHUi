//
//  ActivityNormalCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ActivityNormalCell.h"
#import "SignUpAndVotedModel.h"

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
}

- (void)setObject:(NSDictionary *)dict{
    SignUpAndVotedModel *signUpAndVotedModel = [[SignUpAndVotedModel alloc] initWithDataDic:dict];

    self.eventDetail.text = [NSString stringWithFormat:@"报名时间：%@",signUpAndVotedModel.joinTime];
    self.name.text = signUpAndVotedModel.member[@"realname"];
    [self.department setTitle:signUpAndVotedModel.member[@"property0"] forState:UIControlStateNormal];
    
    if (showType != showSignUp) {
        self.eventDetail.text = [NSString stringWithFormat:@"投票选择：%@",signUpAndVotedModel.activityVote[@"options"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
