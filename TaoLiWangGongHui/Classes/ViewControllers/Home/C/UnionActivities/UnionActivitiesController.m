//
//  UnionActivitiesController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UnionActivitiesController.h"
#import "ActivitiesDetailController.h"
#import "MessageCell.h"
#import "HomeListModel.h"
@interface UnionActivitiesController ()

@end

@implementation UnionActivitiesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self changeIsSelfResquestWithBool:NO];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = @"工会活动";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"navigation_Back.png" backgroundImage:nil target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = nil;
    self.messageTableView.height = self.view.height - 64;
    NSDictionary *params = @{
                             @"memberId":[[UserHelper shareInstance] getMemberID],
                             @"pageSize":PAGESIZE,
                             @"pageNo":@"0"
                             };
    [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryActivityList_Url]];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeListModel *homeModel = [[HomeListModel alloc] initWithDataDic:self.model[indexPath.row]];

    ActivitiesDetailController *activiteVC = [[ActivitiesDetailController alloc] initWithActivityType:indexPath.row+1 withID:homeModel.activityId];
    activiteVC.navigationItem.title = @"工会活动详情";
    [activiteVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:activiteVC animated:YES];
}

- (void)reloadNewData{
    [self.messageTableView reloadData];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = (MessageCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    HomeListModel *homeModel = [[HomeListModel alloc] initWithDataDic:self.model[indexPath.row]];
    [cell.goodImage setImageWithURL:[NSURL URLWithString:homeModel.activityPic]];
    cell.goodDescription.text = homeModel.activityTitle;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
