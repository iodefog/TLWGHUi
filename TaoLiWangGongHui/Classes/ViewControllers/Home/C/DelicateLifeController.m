//
//  DelicateLifeController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "DelicateLifeController.h"
#import "DelicateLifeCell.h"

@interface DelicateLifeController () <DelicateLifeDelegate>

@property (nonatomic, strong) NSMutableDictionary *cellHightDict;

@end

@implementation DelicateLifeController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.cellHightDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 假数据
    self.navigationItem.title = @"精致生活";
    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addHeader];
    [self addFooter];
}

#pragma mark - MJRefresh
- (void)refreshHeaderView{
    [self commitRequestWithParams:@{@"pageNo":@"0",
                                    @"pageSize":PAGESIZE} withUrl:[GlobalRequest activityAction_QueryJokeList_Url] withView:nil];
}

- (void)refreshFooterView{
    [self commitRequestWithParams:@{@"pageNo":[NSString stringWithFormat:@"%d", [self.model count]/PAGESIZEINT],
                                    @"pageSize":PAGESIZE} withUrl:[GlobalRequest activityAction_QueryJokeList_Url] withView:nil];
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
    NSInteger cellCount = 0;
    if ([self.model isKindOfClass:[NSArray class]]) {
        cellCount = [self.model count];
    }
    return cellCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSDictionary *dict = self.model[indexPath.section];
//    NSLog(@"**** %f",[DelicateLifeCell getCellHeight:dict]);
//    NSLog(@"**** %d",indexPath.section);
//    return [DelicateLifeCell getCellHeight:dict];
    NSString *cellName = [NSString stringWithFormat:@"section_%d",indexPath.section ];
    NSNumber *num = self.cellHightDict[cellName];
    return num.floatValue;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    float cellHeight = 30.0f;
    if (section == 0) {
        cellHeight = 20.0f;
    }
    return cellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20.0f)];
}

//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.1f;
//}

- (DelicateLifeCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DelicateCell";
    DelicateLifeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[DelicateLifeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    NSDictionary *dict = self.model[indexPath.section];
    [cell setObject:dict];
    return cell;
}


- (void)reloadTableViewWithCell:(DelicateLifeCell *)cell{
    [self.cellHightDict setObject:[NSNumber numberWithFloat:cell.cellHeight] forKey:[NSString stringWithFormat:@"section_%d",cell.indexPath.section]];
    [self.tableView reloadData];
}


@end
