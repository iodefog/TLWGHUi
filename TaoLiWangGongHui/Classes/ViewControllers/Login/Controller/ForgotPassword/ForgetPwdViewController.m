//
//  ForgetPwdViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//
#import "ForgetPwdViewController.h"
#import "UpdatePassWordViewController.h"

@interface ForgetPwdViewController (){
    NSTimer *codeTimer;
}
/**
 *  通过不同方式找回密码
 */
@property (weak, nonatomic) IBOutlet UIButton *bySMSButton;
@property (weak, nonatomic) IBOutlet UIButton *byEmailButton;
@property (strong, nonatomic) IBOutlet UIButton *byCodeButton;

/**
 *  邮箱手机界面
 */
@property (weak, nonatomic) IBOutlet UIView *bySMSGetView;
@property (weak, nonatomic) IBOutlet UIView *byEmailGetView;

/**
 *  邮箱验证码手机号输入框
 */
@property (weak, nonatomic) IBOutlet UITextField *phoneTetxField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation ForgetPwdViewController

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
    self.navigationItem.title = @"找回密码";
    [self.bySMSButton setBackgroundImage:[UIImage imageNamed:@"mobile_selected.png"] forState:UIControlStateSelected];
    //   self.ByEmailButton.imageEdgeInsets = self.BySMSButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    [self.byEmailButton setBackgroundImage:[UIImage imageNamed:@"email_selected.png"] forState:UIControlStateSelected];
    self.bySMSButton.selected = YES;
    [self bySMSButtonClick:self.bySMSButton];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.codeTextField resignFirstResponder];
    [self.phoneTetxField resignFirstResponder];
}

#pragma mark -
#pragma mark ByDifferent type GetPwd Button
- (IBAction)bySMSButtonClick:(UIButton *)sender {
    [self.emailTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    [self.phoneTetxField resignFirstResponder];
    self.byEmailGetView.hidden = self.bySMSButton.selected = YES;
    self.bySMSGetView.hidden = self.byEmailButton.selected = NO;
}
- (IBAction)byEmailButtonClick:(UIButton *)sender {
    [self.emailTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    [self.phoneTetxField resignFirstResponder];
    self.byEmailGetView.hidden = self.bySMSButton.selected = NO;
    self.bySMSGetView.hidden = self.byEmailButton.selected = YES;
}

#pragma mark -
#pragma mark BySMSGetInformation
// 获取验证码
- (IBAction)getCodeButtonClick:(id)sender {
    if([GlobalHelper isValidatePhone:self.phoneTetxField.text]){
        NSDictionary *params = @{@"phone":self.phoneTetxField.text};
        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_QueryPasswordByMessage_Url]];
        [self.byCodeButton setTitle:[NSString stringWithFormat:@"%d秒后再发",60] forState:UIControlStateDisabled];
        self.byCodeButton.enabled = NO;
        
        if (![codeTimer isValid]) {
            codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(codeTimerTrigger:) userInfo:nil repeats:YES];
        }
    }else{
        [GlobalHelper handerResultWithDelegate:self withMessage:@"手机号码格式不正确" withTag:0];
    }
}

// 点击一次验证码后，计时器触发60秒
static int clickCount = 59;
- (void)codeTimerTrigger:(NSTimer *)timer{
    if (-- clickCount > 0) {
        [self.byCodeButton setTitle:[NSString stringWithFormat:@"%d秒后再发",clickCount] forState:UIControlStateDisabled];
        self.byCodeButton.enabled = NO;
    }else{
        self.byCodeButton.enabled = YES;
        clickCount = 60;
        [codeTimer invalidate];
    }
}


// 通过短信找回密码
- (IBAction)submitSMSInfomation:(id)sender {
    if (self.phoneTetxField.text.length < 1 ) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"手机号码不能为空" withTag:0];
    }else if (self.phoneTetxField.text.length != 11){
        [GlobalHelper handerResultWithDelegate:self withMessage:@"手机号码格式不正确" withTag:0];
    }else if (self.codeTextField.text.length < 1){
        [GlobalHelper handerResultWithDelegate:self withMessage:@"验证码不能为空" withTag:0];
    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.phoneTetxField.text ,@"phone",
                                self.codeTextField.text, @"code",  nil];

        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_QueryPasswordByMessage_Url]];
    }
}

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    /**
     *  保存用户信息
     *	code：状态码
     *	msg：状态中文说明
     *	result：0
     */
    NSLog(@"resultDic  %@", resultDic);
}

#pragma mark -
#pragma mark ByEmailGetInformation
// 通过邮件找回密码
- (IBAction)sendEmailBtnClick:(id)sender {
    
    if (self.emailTextField.text.length < 1) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"邮件不能为空" withTag:0];
    }else if (![GlobalHelper isValidateEmail:self.emailTextField.text]) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"邮件格式不正确" withTag:0];
    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"email",self.emailTextField.text,nil];
        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_QueryPasswordByEmail_Url]];
    }
}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    NSNumber *codeNum = request.handleredResult[@"code"];
    if ([request.requestUrl.lastPathComponent isEqualToString:@"UserAction!queryPasswordByMessage.do"]) {
            if (codeNum.intValue ==  1) {
                
            }else{
                [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
            }
        }else if ([request.requestUrl.lastPathComponent isEqualToString:@"UserAction!queryPasswordByEmail.do"]){
            if (codeNum.intValue == 1) {
                UpdatePassWordViewController *updatePassWord = [[UpdatePassWordViewController alloc] initWithNibName:@"UpdatePassWordViewController" bundle:nil];
                [updatePassWord notShowHeadViewWithShow:YES];
                [self.navigationController pushViewController:updatePassWord animated:YES];
            }else{
                [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
            }
        }
}

- (IBAction)loginEmail:(id)sender {

}


@end
