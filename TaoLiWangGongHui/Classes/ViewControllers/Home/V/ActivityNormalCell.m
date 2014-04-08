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
    if (myShowType == showSignUp) {
        self.eventName.text = @"报名时间";
    }else{
        self.eventName.text = @"投票选择";
    }
}

- (void)setObject:(NSDictionary *)dict{
    SignUpAndVotedModel *signUpAndVotedModel = [[SignUpAndVotedModel alloc] initWithDataDic:dict];
    self.eventDetail.text = signUpAndVotedModel.joinTime;
    self.name.text = signUpAndVotedModel.member[@"realname"];
    [self.department setTitle:signUpAndVotedModel.member[@"property0"] forState:UIControlStateNormal];
    if (showType != showSignUp) {
        self.eventDetail.text = signUpAndVotedModel.activityVote[@"options"];
    }
//    self.name.text = signUpAndVotedModel.realname;
//    [self.department setTitle:signUpAndVotedModel.Property0 forState:UIControlStateNormal];
//    self.eventDetail.text = signUpAndVotedModel.productName;
    
//    if (showType == showSignUp) {
//        
//    }else{
//        self.eventDetail.text = dict[@"voteName"];
//    }  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
