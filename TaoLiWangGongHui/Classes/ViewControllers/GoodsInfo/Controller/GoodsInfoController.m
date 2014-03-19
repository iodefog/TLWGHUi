//
//  GoodsInfoController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#define GoodsInfoExampleCount 2

#import "GoodsInfoController.h"
#import "GoodsInfoCell.h"
#import "GoodsListModel.h"
@interface GoodsInfoController ()
@property (nonatomic, strong) GoodsListModel *discountModel;
@end

@implementation GoodsInfoController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithType:(GoodsInfoType)myGoodsInfoType withProductID:(NSString *)myProductID{
    goodsInfoType  = myGoodsInfoType;
    productID = myProductID;
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    
    [self commitRequestWithParams:@{
                                   @"memberId": [[UserHelper shareInstance] getMemberID],
                                   @"productId": productID
                                   } withUrl:
     [GlobalRequest productAction_QueryProducInfo_Url]];
}

- (void)reloadNewData{
    [self.tableView reloadData];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 320.0f;
    if (indexPath.row == 1) {
        height = 180;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return GoodsInfoExampleCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row == 0) {
        static NSString *CellIdentifier = @"GoodsInfoCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"GoodsInfoCell" owner:nil options:nil] lastObject];
            [(GoodsInfoCell *)cell createUI];
        }
        if ([self.model isKindOfClass:[NSDictionary class]]) {
            NSDictionary *params = self.model;
            [((GoodsInfoCell *)cell) setObject:params];
            ((GoodsInfoCell *)cell).goodsListModel = [[GoodsListModel alloc] initWithDataDic:@{
                                                                                               @"productId":productID,
                                                                                               @"productName": params[@"productName"]}];
        }
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GoodsInfoCell1"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, cell.width - 10, 170)];
        imageView.backgroundColor = [UIColor clearColor];
        [imageView setImageWithURL:[NSURL URLWithString:self.discountModel.productDescribe]];
        [cell addSubview:imageView];
    }
    
    return cell;
}


@end
