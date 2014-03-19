//
//  LoginViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-4.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "LoginViewController.h"
#import "ForgetPwdViewController.h"
#import "UserHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    self.navigationItem.title = @"工会自助服务平台";
    self.navigationItem.leftBarButtonItem = nil;
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Custom Method

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.userName resignFirstResponder];
    [self.passWord resignFirstResponder];
}

// 忘记密码
- (IBAction)forgotPassword:(id)sender {
    ForgetPwdViewController *forgotPwd = [[ForgetPwdViewController alloc] initWithNibName:@"ForgetPwdViewController" bundle:nil];
    [self.navigationController pushViewController:forgotPwd animated:YES];
}

// 登陆
- (IBAction)login:(id)sender {
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.userName.text,@"memberName", self.passWord.text,@"passwd",nil];
    
    [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_Login_Url]];
   }

- (void)setDataDic:(NSDictionary *)resultDic toManager:(NSMutableArray *)baseManager
{
    /**
     *  保存用户信息
     */
    NSLog(@"resultDic  %@", resultDic);
    [[UserHelper shareInstance] saveMemberID:resultDic];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate chageRootVC];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    

    
//    if ([[resultDic[@"code"]stringValue] isEqualToString:@"1"]) {
    
//        NSDictionary *dict = [resultDic objectForKey:@"result"];
        
//        self.UserModel.Point = dict[@"jfye"];
//        self.UserModel.UserName = dict[@"username"];
//        self.UserModel.UserId = dict[@"yhid"];
//        [SaveAndGetUserInformation saveUserDefaultsWithTheUserInformation:self.UserModel];
//        [self dismissViewControllerAnimated:YES completion:^{}];
//        [SharedApp showViewController:HOME_VIEW_CONTROLLER];
//        return ;
//    }
//    [UIAlertView popupAlertByDelegate:self andTag:0 title:@"提示" message:@"您输入的密码或者账号有误!"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
