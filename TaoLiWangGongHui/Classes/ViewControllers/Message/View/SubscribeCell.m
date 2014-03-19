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
                                   @"newsId":self.subscribeModel.newsId,
                                   @"status":sender.selected?@"1":@"0"};
    [self commitRequestWithParams:params withUrl:[GlobalRequest articleAction_DoSubscription_Url]];
}

- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url{
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:self withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        NSLog(@"request finish");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"操作成功"];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        NSLog(@"request cancel");
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        NSLog(@"request fail");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"操作失败"];
        
    }];
}


- (void)setObject:(NSDictionary *)dict{
    self.subscribeModel = [[MessageModel alloc] initWithDataDic:dict];
    self.goodCategory.text = self.subscribeModel.newsTitle;
    [self.preViewImage setImageWithURL:[NSURL URLWithString:self.subscribeModel.newsPicPath]];
    if (self.subscribeModel.status.boolValue) {
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
