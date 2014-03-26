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
        [GlobalHelper handerResultWithDelegate:self withMessage:@"邮件不能为空" withTag:0];
    }else if (![GlobalHelper isValidateEmail:self.emailTextField.text]){
        [GlobalHelper handerResultWithDelegate:self withMessage:@"邮件格式不正确" withTag:0];
    }else{
        NSDictionary *params = @{@"member": [[UserHelper shareInstance] getMemberID], @"email":self.emailTextField.text};
        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_QueryPasswordByEmail_Url]];
    }
}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
}

- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
