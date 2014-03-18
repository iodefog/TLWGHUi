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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setTableFooterView:[[UIView alloc] init]];
    
    self.navigationItem.title = @"优惠购物";
    NSDictionary *params = @{
                             @"memberId": [[UserHelper shareInstance] getMenberID],
                             @"pageNo": @"1",
                             @"Type":@"3",
                             @"pageSize": PAGESIZE,};
    [self commitRequestWithParams:params withUrl:[GlobalRequest productAction_QueryProductListByType_Url]];
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
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscountShoppingCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    GoodsInfoController *goodsInfo = [[GoodsInfoController alloc] initWithType:GoodsType_Discount withProductID:cell.discountModel.productId];
    [goodsInfo setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:goodsInfo animated:YES];
}

@end