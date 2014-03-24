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

@interface ActivitiesDetailController (){
    UIView *voteOrNotVoteView;  //保存当前显示的投票视图
}

@property (nonatomic, strong) NSMutableArray *voteListArray;

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

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
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
    self.middleScrollView.userInteractionEnabled = YES;
    self.baseScroll.backgroundColor  = RGBCOLOR(241, 241, 241);
    self.baseScroll.contentSize = CGSizeMake(self.view.width, 568);
        
    [self commitRequestWithParams:@{@"activityId":activityID} withUrl:[GlobalRequest activityAction_QueryActivityInfo_Url]];
    
    if (activityType == TypeNone){ // 不显示报名和投票
        self.bottomView.hidden = YES;
    }
    else if (activityType == TypeSignUp) {  // 报名
        [self.signUpButton setTitle:@"已报名" forState:UIControlStateDisabled];
        [self.haveSignedButton setTitle:@"查看已报名会员" forState:UIControlStateNormal];
    }
    else{ // 投票
        
        NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMemberID],
                                 @"activityId":activityID};
        [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryActivityOptionList_Url]];
        
        [self.signUpButton setTitle:@"投票" forState:UIControlStateNormal];
        [self.signUpButton setTitle:@"已投票" forState:UIControlStateDisabled];
        [self.haveSignedButton setTitle:@"查看投票记录" forState:UIControlStateNormal];
    }
}

- (void)showDiffrentMiddleViewWithType:(ActivityType)myActivityType withDescription:(NSString *)description withHaveAction:(BOOL)haveAction{
    if ((myActivityType == TypeSignUp) || (myActivityType == TypeNone)) {
        RTLabel *signDescription = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, self.middleScrollView.width - 20, 0)];
        signDescription.text = description;
       signDescription.height =  signDescription.optimumSize.height +5 ;
        if (haveAction) {
            self.signUpButton.selected = YES;
        }
        self.middleScrollView.contentSize = CGSizeMake(self.middleScrollView.width, signDescription.optimumSize.height);
        [self.middleScrollView addSubview:signDescription];
    }else if(myActivityType == TypeVote){
        if (haveAction) {
            [self haveVotedWithDescription:description];
        }
        [self unHaveVotedWithDescription:description];
    }
}

// 未投票时显示这个
- (void)unHaveVotedWithDescription:(NSString *)description{
    voteOrNotVoteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.middleScrollView.width, self.middleScrollView.height)];
                         
    RTLabel *signDescription = [[RTLabel alloc] initWithFrame:CGRectMake(10, 5, self.middleScrollView.width - 20, 0)];
    signDescription.text = description;
    signDescription.height =  signDescription.optimumSize.height +5 ;
    [voteOrNotVoteView addSubview:signDescription];
    
    NSArray *checkBtnTitleArray = [NSArray arrayWithObjects:@"同意本次活动，活动a很有意思不错，非常想参加同意本次活动。",@"反对活动，不想参加", nil];
    RadioGroup * radioGroup = [[RadioGroup alloc] init];
    float tempHeight = 0;
    for (int i = 0; i < CheckButtonCount ; i++) {
        RTLabel *temp = [[RTLabel alloc] initWithFrame:CGRectMake(signDescription.left, signDescription.bottom + 40*i, signDescription.width, 20)];
        temp.font = [UIFont systemFontOfSize:14];
        temp.text = checkBtnTitleArray[i];
        
        CheckButton *checkBtn = [[CheckButton alloc] initWithFrame:CGRectMake(signDescription.left, signDescription.bottom + tempHeight, signDescription.width, temp.optimumSize. height + 5)];
        tempHeight += checkBtn.height;
        
        [radioGroup add:checkBtn];
        checkBtn.label.text = checkBtnTitleArray[i];
        checkBtn.label.numberOfLines = 0;
        checkBtn.value = [NSNumber numberWithInt:i];
        checkBtn.style = CheckButtonStyleBox;
        [voteOrNotVoteView addSubview:checkBtn];
    }
    [self.middleScrollView addSubview:voteOrNotVoteView];
    self.middleScrollView.contentSize = CGSizeMake(self.middleScrollView.width, signDescription.bottom + tempHeight);
}

// 已投票后显示这个
- (void)haveVotedWithDescription:(NSString *)description{
    NSArray *checkBtnTitleArray = [NSArray arrayWithObjects:@"A.同意本次活动，活动a很有意思不错，非常想参加同意本次活动。",@"B.反对活动，不想参加", nil];
        UIView *mView1 = [self createActivityItemWithDescription:checkBtnTitleArray[0] withPersonNum:@"100" withPercent:@"1"];
        UIView *mView2 = [self createActivityItemWithDescription:checkBtnTitleArray[1] withPersonNum:@"60" withPercent:@"0.6"];
    mView1.top = 10;
    mView2.top = mView1.bottom;
    [self.middleScrollView addSubview:mView1];
    [self.middleScrollView addSubview:mView2];
    self.middleScrollView.contentSize = CGSizeMake(self.middleScrollView.width, 10 + mView1.height + mView2.height);

}

- (UIView *)createActivityItemWithDescription:(NSString *)description withPersonNum:(NSString *)personNum withPercent:(NSString *)percent{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 280, 0)];
    
    RTLabel *label = [[RTLabel alloc] initWithFrame:view.frame];
    label.text = description;
    label.font = [UIFont systemFontOfSize:14.];
    label.height = label.optimumSize.height;
    [view addSubview:label];
    
    UIImageView *numBackGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(20, label.optimumSize.height + 5, 200, 20)];
    UIImage *bgImage = [UIImage imageNamed:@"activityNumBg.png"] ;
   bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width/2 topCapHeight:bgImage.size.height/2];
    numBackGroundView.image = bgImage;
    [view addSubview:numBackGroundView];
    
    RTLabel *numLabel = [[RTLabel alloc] initWithFrame:numBackGroundView.frame];
    numLabel.text = personNum;
    numLabel.textColor = [UIColor whiteColor];
    numLabel.font = [UIFont systemFontOfSize:14.0];
    [view addSubview:numLabel];
    
    numBackGroundView.width = 20 + 20 * (percent.floatValue * 100/10);
    
    RTLabel *percentLabel = [[RTLabel alloc] initWithFrame:CGRectMake(numBackGroundView.right+5, numBackGroundView.top, 40, numBackGroundView.height)];
    percentLabel.text = [NSString stringWithFormat:@"%d%%",(int)(percent.floatValue * 100)];
    percentLabel.font = [UIFont systemFontOfSize:14.0];
    percentLabel.textColor = [UIColor grayColor];
    [view addSubview:percentLabel];
    
    view.height = label.height + numBackGroundView.height + 10;
    
    return view;
}

// 我要报名
// 我要投票
- (IBAction)signUpClicked:(id)sender {
    self.signUpButton.enabled = NO;
    
    if (activityType == TypeSignUp) {
        
        NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMemberID],
                                 @"activityId":activityID};
        [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_EnterActivity_Url]];
        
    }else if(activityType == TypeVote){
        [voteOrNotVoteView removeFromSuperview];
        [self haveVotedWithDescription:nil];
        NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMemberID],
                                 @"activityId":activityID};
        [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryActivityOptionList_Url]];
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
    ActivityInfoModel *activityModel = [[ActivityInfoModel alloc] initWithDataDic:self.model];
    self.activitiesTitle.text = activityModel.activityTitle;
    [self.headImage setImageWithURL:[NSURL URLWithString:activityModel.activityPic]];
    activityType = activityModel.typeId.intValue;
    [self showDiffrentMiddleViewWithType:activityType withDescription:activityModel.description withHaveAction:NO];
}

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager{

}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    if ([[request.requestUrl lastPathComponent] isEqualToString:@"ActivityAction!queryActivityOptionList.do"]) { // 投票完成的url
        NSLog(@"resultDic  %@", request.handleredResult);
        if (request.handleredResult[@"result"] && [request.handleredResult[@"result"] isKindOfClass:[NSArray class]]) {
            [self.voteListArray addObjectsFromArray:request.handleredResult[@"result"]];

        }
    }else if([[request.requestUrl lastPathComponent] isEqualToString:@"ActivityAction!queryActivityInfo.do"]){ // 一进本页就请求本页的所有数据 的url
        NSLog(@"resultDic  %@", request.handleredResult);
        if (request.handleredResult[@"result"] && [request.handleredResult[@"result"] isKindOfClass:[NSArray class]]) {
            [self.model addObjectsFromArray:request.handleredResult[@"result"]];
            [self reloadNewData];
        }else if(request.handleredResult[@"result"] && [request.handleredResult[@"result"] isKindOfClass:[NSDictionary class]]){
            self.model = request.handleredResult[@"result"];
            [self reloadNewData];
        }
    }else if([[request.requestUrl lastPathComponent] isEqualToString:@"ActivityAction!enterActivity.do"]){
        [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
