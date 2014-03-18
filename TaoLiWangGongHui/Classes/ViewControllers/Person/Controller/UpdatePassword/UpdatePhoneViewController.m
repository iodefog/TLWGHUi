//
//  UpdatePhoneViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UpdatePhoneViewController.h"

@interface UpdatePhoneViewController ()

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
    
}

// 提交
- (IBAction)commitClicked:(id)sender {
    if (self.phoneTextField.text.length < 1 ) {
        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"手机号码不能为空"];
    }else if (self.phoneTextField.text.length != 11){
        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"手机号码格式不正确"];
    }else if (self.codeTextField.text.length < 1){
        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"验证码不能为空"];
    }else{
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [[UserHelper shareInstance] getMenberID],@"member",
                                self.phoneTextField.text ,@"phone",
                                self.codeTextField.text, @"code",  nil];
        //   @{@"member": [[UserHelper shareInstance] getMenberID], @"phone":self.phoneTetxField.text};
        
        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_UpdateMobile_Url]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
