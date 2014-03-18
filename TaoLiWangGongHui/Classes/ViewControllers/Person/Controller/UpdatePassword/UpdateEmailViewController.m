//
//  UpdateEmailViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UpdateEmailViewController.h"

@interface UpdateEmailViewController ()

@end

@implementation UpdateEmailViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  = @"修改邮箱地址";
}

- (IBAction)commitClicked:(UIButton *)sender {
    if (self.emailTextField.text.length < 1) {
        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"邮件不能为空"];
    }else if (self.emailTextField.text.length != 11){
        if (![GlobalHelper isValidateEmail:self.emailTextField.text]) {
            [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"邮件格式不正确"];
        }
    }else{
        NSDictionary *params = @{@"member": [[UserHelper shareInstance] getMenberID], @"email":self.emailTextField.text};
        [self commitRequestWithParams:params];
    }
}

- (void)commitRequestWithParams:(NSDictionary *)params{
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:[GlobalRequest userAction_QueryPasswordByEmail_Url] withIndicatorView:self.view withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [self setDataDic:request.handleredResult toManager:nil];
        NSLog(@"request finish");
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        NSLog(@"request cancel");
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        NSLog(@"request fail");
    }];
}

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    /**
     *  保存用户信息
     */
    NSLog(@"resultDic  %@", resultDic);
//    [[UserHelper shareInstance] saveMenberID:resultDic];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
