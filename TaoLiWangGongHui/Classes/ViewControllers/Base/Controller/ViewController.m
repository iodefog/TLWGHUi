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
        self.model = [[NSMutableArray alloc ] init ];
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
    [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"提示" message:request.handleredResult[@"msg"]];
}

#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request{
     [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"提示" message:request.handleredResult[@"msg"]];
}

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    /**
     *  返回数据
     */
    NSLog(@"resultDic  %@", resultDic);
    if (resultDic[@"result"] && [resultDic[@"result"] isKindOfClass:[NSArray class]]) {
        [self.model addObjectsFromArray:resultDic[@"result"]];
    }else if (resultDic[@"result"] && [resultDic[@"result"] isKindOfClass:[NSDictionary class]]){
        self.model = resultDic[@"result"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
