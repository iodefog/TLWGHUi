//
//  MessageController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "MessageController.h"
#import "MessageCell.h"
#import "ActivitiesDetailController.h"
#import "SubscribeController.h"

@interface MessageController ()

@end

@implementation MessageController
@synthesize messageTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

static bool isSelfRequest = YES;

- (void)changeIsSelfResquestWithBool:(BOOL)selfBool{
    isSelfRequest = selfBool;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [UIScreen mainScreen].bounds.size.height - 49 - 44) style:UITableViewStyleGrouped];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    self.messageTableView.contentSize = CGSizeMake(self.view.width, 220*4);
    self.messageTableView.backgroundView = [[UIView alloc] init];
    [self.view addSubview:self.messageTableView];
     self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"订阅管理" image:nil target:self action:@selector(subscribeClicked:) font:[UIFont systemFontOfSize:12] titleColor:[UIColor whiteColor]];
    
    if (isSelfRequest) {
        [self commitRequestWithParams:@{@"pageNo":@"0",
                                        @"pageSize":PAGESIZE} withUrl:[GlobalRequest articleAction_QueryAdList_Url]];
    }
}

// 订阅管理点击
- (void)subscribeClicked:(UIButton *)sender{
    SubscribeController *subscribeVC = [[SubscribeController alloc] initWithStyle:UITableViewStylePlain];
    [subscribeVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:subscribeVC animated:YES];
}

- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"msgCellName";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageCell" owner:nil options:nil] lastObject];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivitiesDetailController *activitiesVC = [[ActivitiesDetailController alloc] initWithActivityType:TypeNone withID:nil];
    [activitiesVC setHidesBottomBarWhenPushed:YES];
    activitiesVC.navigationItem.title = @"信息详情";
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.model count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0.1f;
    if (section != 0) {
        height = 10;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
