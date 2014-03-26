//
//  UINarmolViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonWithImage:@"navigation_Back.png" backgroundImage:nil target:self action:@selector(back)];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitRequestWithParams:(NSDictionary *)params withUrl:(NSString *)url{
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:url withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [self setDataDic:request.handleredResult toManager:nil];
        NSLog(@"request finish");
        [self responseSuccessWithResponse:request];
    
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
      
        NSLog(@"request cancel");
        [self responseFailWithResponse:request];

    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
        [self responseCancelWithResponse:request];
        NSLog(@"request fail");
        
    }];
}

#pragma mark - Response Success
- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{

}

#pragma mark - Response Fail
- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
}

#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request{
    [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
}

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    /**
     *  返回数据
     */
    NSLog(@"resultDic  %@", resultDic);
    if (resultDic[@"result"] && [resultDic[@"result"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.model];
        [tempArray addObjectsFromArray:resultDic[@"result"]];
        self.model = tempArray;
    }else if (resultDic[@"result"] && [resultDic[@"result"] isKindOfClass:[NSDictionary class]]){
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        self.emptyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.emptyView];
    }
}

// 当有数据是，移除空图
- (void)hideEmptyView{
    [self.emptyView removeFromSuperview];
}

@end
