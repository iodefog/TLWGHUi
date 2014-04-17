//
//  DiscountShoppingController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "DiscountShoppingController.h"
#import "DiscountShoppingCell.h"
#import "GoodsInfoController.h"

@interface DiscountShoppingController ()

@end

@implementation DiscountShoppingController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [GlobalHelper showCarViewInNavC:self.navigationController withVC:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [GlobalHelper hiddenCarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    self.navigationItem.title = @"优惠购物";
    
    [self addHeader];
    [self addFooter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MJRefresh
- (void)refreshHeaderView{
    NSDictionary *params = @{
                             @"memberId": [[UserHelper shareInstance] getMemberID],
                             @"pageNo": @"1",
                             @"productType":@"3",
                             @"pageSize": PAGESIZE,};
    [self commitRequestWithParams:params withUrl:[GlobalRequest productAction_QueryProductListByType_Url] withView:nil];
}

- (void)refreshFooterView{
    NSDictionary *params = @{
                             @"memberId": [[UserHelper shareInstance] getMemberID],
                             @"pageNo": [NSString stringWithFormat:@"%d", [self.model count]/PAGESIZEINT],
                             @"Type":@"3",
                             @"pageSize": PAGESIZE,};
    [self commitRequestWithParams:params withUrl:[GlobalRequest productAction_QueryProductListByType_Url] withView:nil];
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

- (DiscountShoppingCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DiscountShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscountShoppingCell" owner:nil options:nil] lastObject];
    }
    if (indexPath.row < [self.model count]) {
        [cell setObject:self.model[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountShoppingCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    GoodsInfoController *goodsInfo = [[GoodsInfoController alloc] initWithNibName:@"GoodsInfoController" bundle:nil];
    goodsInfo.productID = cell.discountModel.productId;
    goodsInfo.goodsListModel = cell.discountModel;
    goodsInfo.goodsInfoType = GoodsType_Discount;
    [goodsInfo setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:goodsInfo animated:YES];
}

@end
