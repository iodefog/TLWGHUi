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
#import "EmptyView.h"

@interface MessageController (){
    EmptyView *emptyView;
}

@end

@implementation MessageController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"订阅管理" image:nil target:self action:@selector(subscribeClicked:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] withRightBarItem:YES];
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf6f1ea];
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;

    
    [self addHeader];
    [self addFooter];
}

// 订阅管理点击
- (void)subscribeClicked:(UIButton *)sender{
    SubscribeController *subscribeVC = [[SubscribeController alloc] initWithStyle:UITableViewStylePlain];
    subscribeVC.parent = self;
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
    if ([self.model count] > indexPath.row) {
        [cell setObject:self.model[indexPath.row]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    ActivitiesDetailController *activitiesVC = [[ActivitiesDetailController alloc] initWithActivityType:TypeNone withID:cell.messageModel.newsId];
    [activitiesVC setHidesBottomBarWhenPushed:YES];
    activitiesVC.navigationItem.title = @"信息详情";
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger cellNum = 0;
    if ([self.model isKindOfClass:[NSArray class]]) {
        cellNum = [self.model count];
    }
    return cellNum;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float cellHeight =  220.0;
//    NSLog(@"count %d   indexPath.section %d",[self.model count], indexPath.row );
    if (([self.model count]- 1) == indexPath.row) {
        cellHeight = 216.f;
    }
    return cellHeight;
}

#pragma mark - MJRefresh
- (void)refreshHeaderView{
    if (isSelfRequest) {
        [self commitRequestWithParams:@{@"pageNo":@"0",
                                        @"pageSize":PAGESIZE,
                                        @"memberId":[[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest articleAction_QueryAdList_Url] withView:nil];
    }
}

- (void)refreshFooterView{
    if (isSelfRequest) {
        NSString *pageNo = [NSString stringWithFormat:@"%d", ([self.model count]/PAGESIZEINT)];
        [self commitRequestWithParams:@{@"pageNo":pageNo,
                                        @"pageSize":PAGESIZE,
                                         @"memberId":[[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest articleAction_QueryAdList_Url] withView:nil];
    }
}

- (void)reloadNewData{
    [super reloadNewData];
    [self checkShoppingData];
}

- (void)checkShoppingData{
    if (![self.model isKindOfClass:[NSMutableArray class]]) {
        if (!emptyView) {
            emptyView = [[EmptyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            emptyView.imageView.image = [UIImage imageNamed:@"mydiscount_empty.png"];
            emptyView.titleLabel.text = @"您还没有订阅，先去订阅吧~";
        }
        if (!emptyView.superview) {
            [self.view addSubview:emptyView];
        }
    }
    else if ([self.model count] == 0 || !self.model ) {
        if (!emptyView) {
            emptyView = [[EmptyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            emptyView.imageView.image = [UIImage imageNamed:@"mydiscount_empty.png"];
            emptyView.titleLabel.text = @"您还没有订阅，先去订阅吧~";
        }
        if (!emptyView.superview) {
            [self.view addSubview:emptyView];
        }
    }else{
        [emptyView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
