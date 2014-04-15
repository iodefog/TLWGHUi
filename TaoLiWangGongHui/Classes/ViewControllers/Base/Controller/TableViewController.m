//
//  TableViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "TableViewController.h"
#import "MJRefresh.h"

@interface TableViewController (){
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

@end

@implementation TableViewController

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
    if ([self.model isKindOfClass:[NSArray class]]) {
        if (![self.model count]) {
            [self refreshHeaderView];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"navigation_Back.png" backgroundImage:nil target:self action:@selector(back)];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url withView:(UIView *)view{
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
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

// 数据接收成功后 用新数据刷新view
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
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


// 下拉刷新，其他复用类需重写
- (void)refreshHeaderView{
    NSLog(@"上拉尚未重写");
}

// 上拉刷新，其他复用类需重写
- (void)refreshFooterView{
    NSLog(@"下拉尚未重写");
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

#pragma mark - TapkuLibrary
// 无数据时，显示的图片
- (UIImage *)emptyImage{
    return nil;
}

// 无数据时，显示的标题
- (NSString *)emptyTitle{
    return @"无数据";
}

// 无数据时，显示的子标题
- (NSString *)emptySubTitle{
    return nil;
}

// 当无数据时，显示空图
- (void)showEmptyView{
    if (self.emptyView && !self.emptyView.superview) {
        [self.view addSubview:self.emptyView];
    }else if(!self.emptyView){
        self.emptyView = [[TKEmptyView alloc] initWithFrame:self.view.bounds mask:[self emptyImage] title:[self emptyTitle] subtitle:[self emptySubTitle]];
        self.emptyView.backgroundColor = [UIColor clearColor];
        self.emptyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.emptyView];
    }
}

// 当有数据是，移除空图
- (void)hideEmptyView{
    [self.emptyView removeFromSuperview];
}

@end
