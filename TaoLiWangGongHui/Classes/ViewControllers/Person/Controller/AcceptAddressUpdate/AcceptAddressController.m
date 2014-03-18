//
//  AcceptAddressController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "AcceptAddressController.h"
#import "AddUserInfoViewController.h"
#import "AddressCell.h"
#import "UserAddressDataBase.h"

@interface AcceptAddressController () <AddressDelegate>

@end

@implementation AcceptAddressController

- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStyleGrouped;
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.model = [[UserAddressDataBase shareDataBase] readTableName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择收货地址";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    return [self.model count]+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120.0f;
}

- (AddressCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddressCell";
    AddressCell *cell = nil;
    if (indexPath.section == [self.model count]) {
        cell = (id)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor clearColor];
        UIButton *addAddressBtn = [UIButton createButton:@selector(addAddressClicked:) title:@"+新增收货地址" image:nil selectedBgImage:@"add_address_highted.png" backGroundImage:@"add_address_normal.png" backGroundTapeImage:@"add_address_highted.png" frame:CGRectMake(0, 10, 100, 40) tag:100 target:self];
        addAddressBtn.centerX = cell.centerX;
        [cell.contentView addSubview:addAddressBtn];
    
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressCell" owner:nil options:nil]lastObject];
        }
        AddressCell *addressCell = cell;
        if (indexPath.row < [self.model count]) {
            [addressCell setObject:self.model[indexPath.section]];
        }
        addressCell.indexPath = indexPath;
        addressCell.addressDelegate = self;
    }
    return cell;
}


- (void)addAddressClicked:(UIButton *)sender{
    AddUserInfoViewController *addUserInfoVC = [[AddUserInfoViewController alloc] init];
    [self.navigationController pushViewController:addUserInfoVC animated:YES];
}

#pragma mark -  AddressDelegate

- (void)setCurrentCellToDefaultModel:(NSIndexPath *)indexPath{
    self.model = [[UserAddressDataBase shareDataBase] readTableName];
    [self.tableView reloadData];
//    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已设置为默认地址"];
}

@end
