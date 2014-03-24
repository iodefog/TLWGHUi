//
//  ActivitiesController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "ActivitiesController.h"
#import "ActivitiesCell.h"
#import "MyActivityModel.h"

@interface ActivitiesController ()

@end

@implementation ActivitiesController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

static NSString *activityCellName = @"activityCellName";

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = nil;
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
 
    [self addHeader];
    [self addFooter];
}

#pragma mark - TableView Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (ActivitiesCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"ActivitiesCellName";
    ActivitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivitiesCell" owner:nil options:nil] lastObject];
    }
    [cell setObject:self.model[indexPath.row]];
    return cell;
}

- (void)reloadNewData{
//    [self.tableView reloadData];
}

#pragma mark -
// MJRefresh
- (void)refreshHeaderView{
    NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMemberID],
                             @"pageSize": PAGESIZE,
                             @"pageNo": @"0"};
    [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryMyActivityList_Url]];
    
}

- (void)refreshFooterView{
    NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMemberID],
                             @"pageSize": PAGESIZE,
                             @"pageNo": [NSString stringWithFormat:@"%d", [self.model count]/PAGESIZEINT]};
    [self commitRequestWithParams:params withUrl:[GlobalRequest activityAction_QueryMyActivityList_Url]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
