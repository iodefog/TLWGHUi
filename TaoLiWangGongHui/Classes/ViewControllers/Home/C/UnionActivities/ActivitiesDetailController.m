//
//  ActivitiesDetailController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ActivitiesDetailController.h"
#import "ActivityNormalController.h"
#import "RadioGroup.h"
#import "Universal.h"
#import "ActivityInfoModel.h"
#import "VoteModel.h"

#define CheckButtonCount 2

@interface ActivitiesDetailController ()

@end

@implementation ActivitiesDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithActivityType:(ActivityType)myActivityType withID:(NSString *)myActivityID{
    activityType = myActivityType;
    activityID = myActivityID;
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.headImage.height = 160;
    self.baseScroll.userInteractionEnabled = YES;
    self.baseScroll.backgroundColor  = RGBCOLOR(241, 241, 241);
    self.baseScroll.contentSize = CGSizeMake(self.view.width, 568);
    
    if (activityType == TypeNone){ // 不显示报名和投票
        self.bottomView.hidden = YES;
        
        [self commitRequestWithParams:@{@"activityId":activityID} withUrl:[GlobalRequest activityAction_QueryActivityInfo_Url]];
    }
    else if (activityType == TypeSignUp) {  // 报名
        [self.signUpButton setBackgroundImage:[UIImage imageNamed:@"union_signUp_selected"] forState:UIControlStateSelected];
        [self.signUpButton setTitle:@"已报名" forState:UIControlStateSelected];
        [self.haveSignedButton setTitle:@"查看已报名会员" forState:UIControlStateNormal];
    }
    else{ // 投票
        [self.signUpButton setBackgroundImage:[UIImage imageNamed:@"union_signUp_selected"] forState:UIControlStateSelected];
        [self.signUpButton setTitle:@"投票" forState:UIControlStateNormal];
        [self.signUpButton setTitle:@"已投票" forState:UIControlStateSelected];
        [self.haveSignedButton setTitle:@"查看投票记录" forState:UIControlStateNormal];
    }
}

- (void)showDiffrentMiddleViewWithType:(ActivityType)myActivityType withDescription:(NSString *)description{
    if ((myActivityType == TypeSignUp) || (myActivityType == TypeNone)) {
        RTLabel *signDescription = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, self.middleScrollView.width - 20, 0)];
        signDescription.text = description;
       signDescription.height =  signDescription.optimumSize.height +5 ;
        self.middleScrollView.contentSize = CGSizeMake(self.middleScrollView.width, signDescription.optimumSize.height);
        [self.middleScrollView addSubview:signDescription];
    }else if(myActivityType == TypeVote){
        RTLabel *signDescription = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, self.middleScrollView.width - 20, 0)];
        signDescription.text = description;
        signDescription.height =  signDescription.optimumSize.height +5 ;
        [self.middleScrollView addSubview:signDescription];

        NSArray *checkBtnTitleArray = [NSArray arrayWithObjects:@"同意本次活动，活动a很有意思不错，非常想参加",@"反对活动，不想参加", nil];
        RadioGroup * radioGroup = [[RadioGroup alloc] init];
        for (int i = 0; i < CheckButtonCount ; i++) {
            CheckButton *checkBtn = [[CheckButton alloc] initWithFrame:CGRectMake(signDescription.left, signDescription.bottom + 40*i, signDescription.width, 20)];
            [radioGroup add:checkBtn];
            checkBtn.label.font = [UIFont systemFontOfSize:14];
            checkBtn.label.text = checkBtnTitleArray[i];
            checkBtn.value = [NSNumber numberWithInt:i];
            checkBtn.style = CheckButtonStyleBox;
            [self.middleScrollView addSubview:checkBtn];
        }
        self.middleScrollView.contentSize = CGSizeMake(self.middleScrollView.width, signDescription.bottom + 40*CheckButtonCount);

    }
}


// 我要报名
// 我要投票
- (IBAction)signUpClicked:(id)sender {
    self.signUpButton.selected = !self.signUpButton.selected;
    
    if (activityType == TypeSignUp) {
        NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMenberID],
                                 @"activityId":activityID};
        NSString *url = [GlobalRequest activityAction_EnterActivity_Url];
        [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
            NSLog(@"request start");
        } onRequestFinished:^(ITTBaseDataRequest *request) {
//            [self setDataDic:request.handleredResult toManager:nil];
            NSLog(@"signUpSuccess  request finish");
        } onRequestCanceled:^(ITTBaseDataRequest *request) {
            NSLog(@"signUpSuccess request cancel");
        } onRequestFailed:^(ITTBaseDataRequest *request) {
            NSLog(@"signUpSuccess  request fail");
        }];
    }else if(activityType == TypeVote){
        NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMenberID],
                                 @"activityId":activityID};
        NSString *url = [GlobalRequest activityAction_EnterActivity_Url];
        [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
            NSLog(@"request start");
        } onRequestFinished:^(ITTBaseDataRequest *request) {
            [self.model addObjectsFromArray:request.handleredResult[@"result"]];
//            [self reloadNewData];
            NSLog(@"voteSuccess  request finish");
        } onRequestCanceled:^(ITTBaseDataRequest *request) {
            NSLog(@"voteSuccess request cancel");
        } onRequestFailed:^(ITTBaseDataRequest *request) {
            NSLog(@"voteUpSuccess  request fail");
        }];
    }
}


// 参看已报名会员
- (IBAction)haveSignedClicked:(id)sender {
    if (activityType == TypeSignUp) {
        ActivityNormalController *activityNormal = [[ActivityNormalController alloc] initWithShowType:showSignUp withActivityID:activityID withActivityVoteId:nil];
        [self.navigationController pushViewController:activityNormal animated:YES];
    }else{
        ActivityNormalController *activityNormal = [[ActivityNormalController alloc] initWithShowType:showVote withActivityID:activityID withActivityVoteId:nil];
        [self.navigationController pushViewController:activityNormal animated:YES];

    }
}

- (void)reloadNewData{
    ActivityInfoModel *activityModel = [[ActivityInfoModel alloc] initWithDataDic:[self.model lastObject]];
    self.activitiesTitle.text = activityModel.activityTitle;
    [self.headImage setImageWithURL:[NSURL URLWithString:activityModel.activityPic]];
    [self showDiffrentMiddleViewWithType:activityType withDescription:activityModel.description];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
