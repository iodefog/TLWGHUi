//
//  SubscribeController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-11.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "SubscribeController.h"
#import "MessageController.h"
#import "SubscribeCell.h"

@interface SubscribeController ()

@end

@implementation SubscribeController

- (id)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"订阅管理";
    [self commitRequestWithParams:@{
                                    @"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"pageNo": @"0",
                                    @"pageSize":PAGESIZE ,} withUrl:[GlobalRequest articleAction_QueryWebsiteNewsType_Url] withView:self.view];
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    [self addHeader];
    [self addFooter];
}

- (void)back{
    if (self.parent && [self.parent respondsToSelector:@selector(refreshHeaderView)]) {
        [self.parent changeIsSelfResquestWithBool:YES];
        [self.parent performSelector:@selector(refreshHeaderView) withObject:nil];
    }
    [super back];
}

- (void)reloadNewData{
    [self.tableView reloadData];
}

#pragma mark - UITabelView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.0f;
}

- (SubscribeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"SubscribeName";
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubscribeCell" owner:nil options:nil] lastObject];
    }
    [cell setObject:self.model[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
