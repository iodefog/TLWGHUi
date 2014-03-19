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
@synthesize activitiesTableView;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = nil;
    
    NSDictionary *params = @{@"memberId": [[UserHelper shareInstance] getMemberID],
                             @"pageSize": PAGESIZE,
                             @"pageNo": @"0"};
    [self commitRequestWithParams:params withUrl:[GlobalRequest articleAction_QueryMyActivityList_Url]];
    
    self.activitiesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.activitiesTableView.delegate = self;
    self.activitiesTableView.dataSource = self;
    [self.view addSubview:self.activitiesTableView];
    
    [self.activitiesTableView setTableFooterView:[[UIView alloc] init]];
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
    MyActivityModel *activityModel = [[MyActivityModel alloc] initWithDataDic:self.model[indexPath.row]];
    [cell.activityImage setImageWithURL:[NSURL URLWithString:activityModel.activityPic]];
    cell.activityDescription.text = activityModel.activityTitle;
    cell.activityTime.text = activityModel.publishDatetime;
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
