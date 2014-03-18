//
//  ActivityNormalController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#define ActivityExampleCount 3

#import "ActivityNormalController.h"

@interface ActivityNormalController ()

@end

@implementation ActivityNormalController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithShowType:(ShowType)myShowType withActivityID:(NSString *)myActivityID withActivityVoteId:(NSString *)myActivityVoteId{
    if (self = [super init]) {
        
    }
    activityID = myActivityID;
    showType = myShowType;
    activityVoteId = myActivityVoteId;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = (showType == showSignUp)?@"已报名会员":@"投票详情";
    
    NSDictionary *params = nil;
    NSString *url = nil;
    
    //	投票记录(activityVoteId) 未填写
    params = @{@"memberId": [[UserHelper shareInstance] getMenberID],
               @"activityId":activityID,
               @"activityVoteId":@""
               };
    url = [GlobalRequest activityAction_AddVote_Url];
    [self commitRequestWithParams:params withUrl:url];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return ActivityExampleCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}

- (ActivityNormalCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ActivityNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivityNormalCell" owner:nil options:nil] lastObject];
        [cell changeShowType:showType];
    }
    
    return cell;
}


@end
