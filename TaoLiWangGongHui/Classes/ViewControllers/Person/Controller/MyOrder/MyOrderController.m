//
//  MyOrdelController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//


#define FirstHeadViewHeight 60

#import "MyOrderController.h"
#import "WelfareOrderViewController.h"
#import "OrderDetailViewController.h"
#import "MyOrderDetailViewController.h"
#import "OrderCell.h"
#import "OrdelModel.h"
#import "MJRefresh.h"


@interface MyOrderController (){
    BOOL isShowWelfareHidden;
    
    NSMutableArray *welfareArray;
    NSMutableArray *cashArray;
    
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation MyOrderController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        welfareArray = [NSMutableArray array];
        cashArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isShowWelfareHidden = NO;
    if (isIOS7) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height - 44 - 60) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.width, self.view.height - 44 - 44) style:UITableViewStylePlain];
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self addHeader];
    [self addFooter];
    
    UIView *headerView = [self createCustomItems];
    [self.view addSubview:headerView];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

#pragma mark - MJRefresh
- (void)refreshHeaderView{
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"orderType": @"1",
                                    @"pageNo":@"0",
                                    @"pageSize":PAGESIZE} withUrl:[GlobalRequest orderAction_QueryOrderList_Url]];
}

- (void)refreshFooterView{
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"orderType": @"1",
                                    @"pageNo":[NSString stringWithFormat:@"%d",[self.model count]/PAGESIZEINT],
                                    @"pageSize":PAGESIZE} withUrl:[GlobalRequest orderAction_QueryOrderList_Url]];

}

- (UIView *)createCustomItems{
    UIView *headerView = nil;
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, FirstHeadViewHeight)];
        UIButton *welfareOrders = [UIButton createButton:@selector(orderClicked:) title:@"福利订单" image:nil selectedBgImage:@"goods_gift_selected.png" backGroundImage:@"goods_gift_normal.png" backGroundTapeImage:nil frame:CGRectMake(0, 0, self.view.width/2, 45) tag:100 target:self];
        UIButton *cashOrders = [UIButton createButton:@selector(orderClicked:) title:@"现金订单" image:nil selectedBgImage:@"goods_cash_selected.png" backGroundImage:@"goods_cash_normal.png" backGroundTapeImage:nil frame:CGRectMake(self.view.width/2, 0, self.view.width/2, 45) tag:101 target:self];
        welfareOrders.titleLabel.font = cashOrders.titleLabel.font = [UIFont systemFontOfSize:16];
        welfareOrders.titleEdgeInsets = cashOrders.titleEdgeInsets = UIEdgeInsetsMake(0 , 25, 0, 5);
        if (!isShowWelfareHidden) {
            welfareOrders.selected = YES;
            cashOrders.selected = NO;
        }else{
            welfareOrders.selected = NO;
            cashOrders.selected = YES;
        }
        [headerView addSubview:welfareOrders];
        [headerView addSubview:cashOrders];
    return headerView;
}

#pragma mark - response Mothod
- (void)reloadNewData{
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.model count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return isShowWelfareHidden ?90 : 73;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if(section == 0){
        height = 0.1;
    }
    return height;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0.1;
//}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = nil;
    if (section == 0) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, FirstHeadViewHeight)];
        UIButton *welfareOrders = [UIButton createButton:@selector(orderClicked:) title:@"福利订单" image:nil selectedBgImage:@"goods_gift_selected.png" backGroundImage:@"goods_gift_normal.png" backGroundTapeImage:nil frame:CGRectMake(0, 0, self.view.width/2, 45) tag:100 target:self];
         UIButton *cashOrders = [UIButton createButton:@selector(orderClicked:) title:@"现金订单" image:nil selectedBgImage:@"goods_cash_selected.png" backGroundImage:@"goods_cash_normal.png" backGroundTapeImage:nil frame:CGRectMake(self.view.width/2, 0, self.view.width/2, 45) tag:101 target:self];
        welfareOrders.titleLabel.font = cashOrders.titleLabel.font = [UIFont systemFontOfSize:16];
        welfareOrders.titleEdgeInsets = cashOrders.titleEdgeInsets = UIEdgeInsetsMake(0 , 25, 0, 5);
        if (!isShowWelfareHidden) {
            welfareOrders.selected = YES;
            cashOrders.selected = NO;
        }else{
            welfareOrders.selected = NO;
            cashOrders.selected = YES;
        }
        [headerView addSubview:welfareOrders];
        [headerView addSubview:cashOrders];
    }
    return headerView;
}
*/

- (OrderCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Order";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderCell" owner:nil options:nil] lastObject];
    }
    [cell showWelfareViewWithHidden:isShowWelfareHidden withCashViewHidden:!isShowWelfareHidden];
    if ( [self.model count] > indexPath.section ) {
        [cell setObject:self.model[indexPath.section]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    NSString *orderCode = cell.ordelModel.orderCode;
    if (isShowWelfareHidden) {
        OrderDetailViewController *cashOrderVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
        cashOrderVC.orderCode = orderCode;
        [self.navigationController pushViewController:cashOrderVC animated:YES];
    }else{
        MyOrderDetailViewController *welfareOrderVC = [[MyOrderDetailViewController alloc] initWithNibName:@"WelfareOrderViewController" bundle:nil];
        welfareOrderVC.orderCode = orderCode;
        [self.navigationController pushViewController:welfareOrderVC animated:YES];
    }
}

#pragma mark - Custom Method
- (void)orderClicked:(UIButton *)sender{
    UIButton *button1 = (id)[self.view viewWithTag:100];
    UIButton *button2 = (id)[self.view viewWithTag:101];
    
    if (sender == button1) {
        button1.selected = YES;
        button2.selected = NO;
        isShowWelfareHidden = NO;
        [self.tableView reloadData];
    }else if(sender == button2){
        button1.selected = NO;
        button2.selected = YES;
        isShowWelfareHidden = YES;
        [self.tableView reloadData];
    }
}

#pragma mark - *****************
- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url{
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [self doneWithView:_header];
        [self doneWithView:_footer];
        
        [self setDataDic:request.handleredResult withRequest:nil];
        NSLog(@"request finish");
        [self responseSuccessWithResponse:request];
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
        [self doneWithView:_header];
        [self doneWithView:_footer];
        
        NSLog(@"request cancel");
        [self responseFailWithResponse:request];
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
        [self doneWithView:_header];
        [self doneWithView:_footer];
        
        [self responseCancelWithResponse:request];
        NSLog(@"request fail");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"加载失败"];
        
    }];
}

#pragma mark - Response Success
- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    
}

#pragma mark - Response Fail
- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    
}

#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request{
    
}

- (void)setDataDic:(NSDictionary *)resultDic withRequest:(id)request
{
    /**
     *  返回数据
     */
    
    NSLog(@"resultDic  %@", resultDic);
    if (resultDic[@"result"] && [resultDic[@"result"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.model];
        [tempArray addObjectsFromArray:resultDic[@"result"]];
        self.model = tempArray;
        if ([resultDic[@"result"] count] < PAGESIZEINT) {
            [_footer removeFromSuperview];
            [_footer free];
        }
        
    }else{
        [_footer removeFromSuperview];
        [_footer free];
        self.model = resultDic[@"result"];
    }
    
    if ([self.model isKindOfClass:[NSArray class]] || [self.model isKindOfClass:[NSDictionary class]]) {
        if ([self.model count]==0) {
            [self showEmptyView];
        }else{
            [self hideEmptyView];
        }
    }
    [self reloadNewData];
}

#pragma mark - MJRefresh
- (void)addFooter
{
    //    __unsafe_unretained MJTableViewController *vc = self;
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 模拟延迟加载数据，因此2秒后才调用）
        [self refreshFooterView];
        // 这里的refreshView其实就是footer
        //        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    _footer = footer;
}

- (void)addHeader
{
    //    __unsafe_unretained self *vc = self;
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // 进入刷新状态就会回调这个Block
        if ([self.model isKindOfClass:[NSArray class]]) {
            [self.model removeAllObjects];
        }
        [self refreshHeaderView];
        // 模拟延迟加载数据，因此2秒后才调用）
        // 这里的refreshView其实就是header
        //        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2.0];
        
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView) {
        // 刷新完毕就会回调这个Block
        NSLog(@"%@----刷新完毕", refreshView.class);
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                break;
            default:
                break;
        }
    };
    [header beginRefreshing];
    _header = header;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    NSLog(@"完成，刷新数据");
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
    [_header free];
    [_footer free];
}



@end
