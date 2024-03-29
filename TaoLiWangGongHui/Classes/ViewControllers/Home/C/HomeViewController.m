//
//  HomeViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "HomeViewController.h"
#import "DelicateLifeController.h"
#import "DiscountShoppingController.h"
#import "UnionActivitiesController.h"
#import "WelfareController.h"
#import "HomeListModel.h"
#import "ShufflingImageView.h"

#import "AddUserInfoViewController.h"

@interface HomeViewController ()<UIWebViewDelegate>{
    NSTimer *activitiesTimer;
    BOOL    welfareDataHaveData;
    BOOL    homeDataHaveData;
    BOOL    DelicateHaveData;
}

@property (nonatomic, strong) NSMutableArray *activitiesArray;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.model && !homeDataHaveData) {
        homeDataHaveData = YES;
        [self commitRequestWithParams:nil withUrl:[GlobalRequest eCMainAction_QueryECMainInfo_Url]];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
//    if (iPhone5) {
//        self.baseScroll.contentSize = CGSizeMake(self.view.width, 568-49);
//    }
//    else{
        self.baseScroll.top = 0;
//        self.baseScroll.contentSize = CGSizeMake(self.view.width, 568+30);
//    }
    
    
    
    self.baseScroll.backgroundColor  = RGBCOLOR(241, 241, 241);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.baseScroll.userInteractionEnabled = YES;
    self.headScroll.userInteractionEnabled = YES;
    self.navigationItem.title = @"员工关怀";
    self.navigationItem.leftBarButtonItem = nil;
    
    self.activitiesArray = [NSMutableArray array];
    
    [self createUI];
    // 精致生活点击
    [self.delicateLifeLable addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delicateLifeClicked:)]];
    self.delicateLifeLable.userInteractionEnabled = YES;
    
    NSLog(@"isIOS7    %d",isIOS7);
    if (isIOS7) {
        
    }else{
        self.baseScroll.height = self.baseScroll.height - 64;
    }
}


- (void)createUI{
    //给轮播添加xx个图片视频
    int imageCount = self.activitiesArray.count;
    for (int i = 0;i < imageCount ;i ++) {
        ShufflingImageView *imageView = [[ShufflingImageView alloc] initWithFrame:CGRectMake(self.view.width*i, 0, self.view.width, 170)];
        [imageView createSubViewsWithModel:self.activitiesArray[i]];
        [self.headScroll addSubview:imageView];
    }
    
    self.headScroll.contentSize = CGSizeMake(self.view.width * imageCount, self.headScroll.height);
    activitiesTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(scrollTheHeadImage) userInfo:nil repeats:YES];
}

#pragma mark - 数据返回成功后刷新数据
- (void)reloadNewData{
    [activitiesTimer invalidate];
    [self.activitiesArray removeAllObjects];
    for (NSDictionary *dict in self.model) {
        HomeListModel *model = [[HomeListModel alloc] initWithDataDic:dict];
        if (model.typeId.intValue == 1) {
            [self.activitiesArray addObject:model];
        }else if (model.typeId.intValue == 3){
            self.jokeTitle.text = model.activityTitle;
            [self.jokeDescription  loadHTMLString:model.description baseURL:nil];
        }
    }
    if ([self.activitiesArray count]>0) {
        [self createUI];
    }
}

- (void)setDataDic:(NSDictionary *)resultDic withRequest:(ITTBaseDataRequest *)request{
    if ([request.requestUrl isEqualToString:[GlobalRequest eCMainAction_QueryECMainInfo_Url]]) {
        [super setDataDic:resultDic withRequest:request];
        homeDataHaveData = NO;
    }else if ([request.requestUrl isEqualToString:[GlobalRequest productAction_QueryProductListByType_Url]]){
        
        if (!resultDic[@"result"] || [resultDic[@"result"] isKindOfClass:[NSString class]]) {
            [UIAlertView popupAlertByDelegate:nil andTag:0 title:nil message:@"\n\n亲，福利的时间还没有到。\n\n"];
        }else if ([resultDic[@"result"] isKindOfClass:[NSArray class]] || [resultDic[@"result"] isKindOfClass:[NSDictionary class]]){
            if ([resultDic[@"result"] count]==0) {
                [UIAlertView popupAlertByDelegate:nil andTag:0 title:nil message:@"\n\n亲，福利的时间还没有到。\n\n"];
            }else{
                WelfareController *welfareController = [[WelfareController alloc] initWithWelfareType:isBirthDay?WelfareBirthDay:WelfareHoliday];
                if ([resultDic[@"result"] isKindOfClass:[NSArray class]]) {
                    welfareController.model = [NSMutableArray arrayWithArray:resultDic[@"result"]];
                }
                [welfareController setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:welfareController animated:YES];
            }
            
        }else{
            WelfareController *welfareController = [[WelfareController alloc] initWithWelfareType:isBirthDay?WelfareBirthDay:WelfareHoliday];
            [welfareController setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:welfareController animated:YES];
        }
        
        welfareDataHaveData = NO;
    }
}

- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request{
    welfareDataHaveData = NO;
    homeDataHaveData= NO;
}

- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    welfareDataHaveData = NO;
    homeDataHaveData = NO;
}

/*** 定时器实现方法
 *   当偏移量小于size的wide 减去 自己的frame的宽度，就直接设置偏移为0
 */
- (void)scrollTheHeadImage{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.headScroll.contentOffset = CGPointMake(self.headScroll.contentOffset.x + self.view.width, 0);
    } completion:^(BOOL finished) {
        
    }];

    if (self.headScroll.contentOffset.x > (self.headScroll.contentSize.width - self.headScroll.width)) {
        self.headScroll.contentOffset = CGPointZero;
    }
}

//精致生活点击进入详情页
- (IBAction)delicateLifeClicked:(id)sender {
    DelicateLifeController *delicateLife = [[DelicateLifeController alloc] initWithStyle:UITableViewStylePlain];
    [delicateLife setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:delicateLife animated:YES];
}

// 生日福利和节日福利点击
- (IBAction)welfareClicked:(UIButton *)sender {

    if (welfareDataHaveData == NO) {
        welfareDataHaveData = YES;
        isBirthDay = (200==sender.tag)?YES:NO;
        NSDictionary *param = @{
                                @"memberId":[[UserHelper shareInstance] getMemberID],
                                @"productType":(200==sender.tag)?@"1":@"2",
                                @"pageNo":@"0",
                                @"pageSize":PAGESIZE
                                };
        [self commitRequestWithParams:param withUrl:[GlobalRequest productAction_QueryProductListByType_Url]];
    }
}

// 优惠购物点击
- (IBAction)discountShoppingClicked:(id)sender {
    DiscountShoppingController *discountShopping = [DiscountShoppingController new];
    [discountShopping setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:discountShopping animated:YES];
}

// 工会活动点击
- (IBAction)unionActitivesClicked:(id)sender {
    UnionActivitiesController *unionActivities = [[UnionActivitiesController alloc] init];
    [unionActivities setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:unionActivities animated:YES];
}

#pragma mark - WebView Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *jsString = @"document.body.style.fontSize=14";
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    [webView setFrame:frame];
    
//    if (isIOS7) {
        if (iPhone5) {
            self.baseScroll.contentSize = CGSizeMake(self.baseScroll.width, ((480+frame.size.height - 88) > 524)?(480+frame.size.height - 88):524);
        }else{
            self.baseScroll.contentSize = CGSizeMake(self.baseScroll.width, ((480+frame.size.height) > 598)?(480+frame.size.height):578);
        }
//    }else{
//        if (iPhone5) {
//            self.baseScroll.contentSize = CGSizeMake(self.baseScroll.width, ((460+frame.size.height - 88) > 504)?(460+frame.size.height - 88):504);
//        }else{
//            self.baseScroll.contentSize = CGSizeMake(self.baseScroll.width, ((460+frame.size.height) > 578)?(460+frame.size.height):578);
//        }
//    }
       self.jokeImageView.height = frame.size.height+25;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
