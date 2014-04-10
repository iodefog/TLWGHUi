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
    NSDictionary *params = @{
                                   @"memberId":[[UserHelper shareInstance] getMemberID],
                                   @"websiteNewsTypeId":self.subscribeModel.newsId,
                                   @"newsType":sender.selected?@"1":@"0"};
    [self commitRequestWithParams:params withUrl:[GlobalRequest articleAction_UpdateWebsiteNewsMember_Url]];
}

- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url{
    UINavigationController *navC = selected_navigation_controller();
    
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:navC.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        NSLog(@"request finish");
        if (self.subscribeBtn.isSelected) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"订阅成功"];
        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"取消订阅成功"];
        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        NSLog(@"request cancel");
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        NSLog(@"request fail");
        if (self.subscribeBtn.isSelected) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"订阅失败"];
        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"取消订阅失败"];
        }
        self.subscribeBtn.selected = !self.subscribeBtn.selected;
    }];
}


- (void)setObject:(NSDictionary *)dict{
    self.subscribeModel = [[MessageModel alloc] initWithDataDic:dict];
    self.goodCategory.text = self.subscribeModel.newsTitle;
    [self.preViewImage setImageWithURL:[NSURL URLWithString:self.subscribeModel.newsPicPath]];
    if (self.subscribeModel.newsType.boolValue) {
        self.subscribeBtn.selected = YES;
    }else{
        self.subscribeBtn.selected = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
