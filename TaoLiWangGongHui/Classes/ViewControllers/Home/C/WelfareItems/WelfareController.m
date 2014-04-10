//
//  WelfareController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "WelfareController.h"
#import "GoodsInfoController.h"
#include "WelfareCell.h"
#import "PopCarView.h"

@interface WelfareController ()<JoinCarDelegate>
@property (nonatomic, strong)PopCarView             *Carview;

@end

@implementation WelfareController
@synthesize welfareType;

- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStylePlain;
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithWelfareType:(WelfareType)myWelfareType{
    self.welfareType = myWelfareType;
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.welfareType?@"节日福利领取":@"生日福利领取";
    if (!self.model) {
        NSDictionary *param = @{
                                @"id":[[UserHelper shareInstance] getMemberID],
                                (self.welfareType?@"type":@"productType"):self.welfareType?@"2":@"1",
                                @"pageNo":@"0",
                                @"pageSize":PAGESIZE
                                };
        [self commitRequestWithParams:param withUrl:[GlobalRequest productAction_QueryProductListByType_Url]];
    }
   
    [self.tableView setTableFooterView:[[UIView alloc] init]];
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
    return [self.model count];
}

static GoodsListModel *goodsModel = nil;

- (WelfareCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WelfareCell";
    WelfareCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WelfareCell" owner:nil options:nil] lastObject];
    }
    [cell setObject:self.model[indexPath.row]];
    cell.welfareType = self.welfareType;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsListModel *goodsModel = [[GoodsListModel alloc] initWithDataDic:self.model[indexPath.row]];
    GoodsInfoController *goodsInfo = [[GoodsInfoController alloc] initWithNibName:@"GoodsInfoController" bundle:nil];
    goodsInfo.goodsInfoType = self.welfareType == WelfareBirthDay ? GoodsType_BirthDay :GoodsType_Holiday ;
    goodsInfo.goodsListModel = goodsModel;
    goodsInfo.productID = goodsModel.productId;
    [goodsInfo setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:goodsInfo animated:YES];
}

@end
