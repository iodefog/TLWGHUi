//
//  UpdatePhoneViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UpdatePhoneViewController.h"

@interface UpdatePhoneViewController (){
    NSTimer *codeTimer;
}

@end

@implementation UpdatePhoneViewController

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
    self.navigationItem.title  = @"修改手机号";
}

// 获取验证码
- (IBAction)getCodeClicked:(id)sender {
    if (![GlobalHelper isValidatePhone:self.phoneTextField.text]) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"手机号码格式不正确" withTag:0];
        return;
    }
    [self commitRequestWithParams:@{
                                    @"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"phone":self.phoneTextField.text
                                    } withUrl:[GlobalRequest userAction_QueryPasswordByMessage_Url]];
    
}

// 提交
- (IBAction)commitClicked:(id)sender {
    if (self.phoneTextField.text.length < 1 ) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"手机号码不能为空" withTag:0];
    }else if (self.phoneTextField.text.length != 11){
        [GlobalHelper handerResultWithDelegate:self withMessage:@"手机号码格式不正确" withTag:0];
    }else if (self.codeTextField.text.length < 1){
        [GlobalHelper handerResultWithDelegate:self withMessage:@"验证码不能为空" withTag:0];
    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [[UserHelper shareInstance] getMemberID],@"member",
                                self.phoneTextField.text ,@"phone",
                                self.codeTextField.text, @"code",  nil];
        
        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_UpdateMobile_Url]];
    }
}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    if ([request.handleredResult isKindOfClass:[NSDictionary class]]) {
        if (((NSNumber *)request.handleredResult[@"code"]).intValue == 0) {
            self.getCodeButton.enabled = YES;
            clickCount = 60;
            [codeTimer invalidate];
        }else{
            if (![codeTimer isValid]) {
                codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(codeTimerTrigger:) userInfo:nil repeats:YES];
            }
        }
        [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
    }
}

- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    if ([request.handleredResult isKindOfClass:[NSDictionary class]]) {
        [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
    }else{
        [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
    }
    self.getCodeButton.enabled = YES;
    clickCount = 60;
    [codeTimer invalidate];
}

// 点击一次验证码后，计时器触发60秒
static int clickCount = 59;
- (void)codeTimerTrigger:(NSTimer *)timer{
    [self.getCodeButton setTitle:[NSString stringWithFormat:@"%d秒后再发",60] forState:UIControlStateDisabled];
    self.getCodeButton.enabled = NO;
    
    if (-- clickCount > 0) {
        [self.getCodeButton setTitle:[NSString stringWithFormat:@"%d秒后再发",clickCount] forState:UIControlStateDisabled];
        self.getCodeButton.enabled = NO;
    }else{
        self.getCodeButton.enabled = YES;
        clickCount = 60;
        [codeTimer invalidate];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
