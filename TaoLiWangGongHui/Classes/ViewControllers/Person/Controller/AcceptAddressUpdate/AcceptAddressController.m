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

@interface AcceptAddressController () <AddressDelegate>{
    BOOL haveRequestData;
}

@end

@implementation AcceptAddressController

- (id)initWithStyle:(UITableViewStyle)style
{
    style = UITableViewStylePlain;
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tableView reloadData];
    /** 地址写入数据库后获取
     NSMutableArray *dbArray = [NSMutableArray arrayWithArray:[[UserAddressDataBase shareDataBase] readTableName] ];
     if([dbArray count]){
     NSMutableArray *tempArray = [NSMutableArray arrayWithObject:[dbArray firstObject]];
     [dbArray removeObject:[dbArray firstObject]];
     [tempArray addObjectsFromArray: [[dbArray reverseObjectEnumerator]allObjects]];
     self.model = tempArray;
     }else{
     self.model = dbArray;
     }
     */
}

- (void)refreshHeaderView{
    [self.model removeAllObjects];
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest addressAction_QueryAddressList_Url] withView:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"选择收货地址";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundView = [[UIView alloc] init];
    haveRequestData = NO;
    [self refreshHeaderView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadNewData{
    haveRequestData = YES;
    [super reloadNewData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // Return the number of sections.
    NSInteger cellCount = ([self.model count] >=3)  ? 3 :  ([self.model count]+1);
    return haveRequestData ? cellCount : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0f;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    addUserInfoVC.parent = self;
    [self.navigationController pushViewController:addUserInfoVC animated:YES];
}

#pragma mark -  AddressDelegate
- (void)setCurrentCellToDefaultModel:(NewAddressModel *)addressmodel{
    [self.model removeAllObjects];
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest addressAction_QueryAddressList_Url] withView:self.view];
}


@end
