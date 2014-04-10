//
//  UpdateViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UpdatePassWordViewController.h"

@interface UpdatePassWordViewController ()

@end

@implementation UpdatePassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改密码";
    self.againPassWord.delegate = self;
    if (notNeedShow) {
        self.head.hidden = YES;
        self.bottom.top = 0;
    }
}
- (IBAction)commitClicked:(id)sender {
    
    if (self.prePassWord.text.length < 1){
     [GlobalHelper handerResultWithDelegate:nil withMessage:@"原密码不能为空" withTag:0];
    }
    else if (self.passWord.text.length < 6){
        [GlobalHelper handerResultWithDelegate:nil withMessage:@"新密码不能为空，且长度至少为6位" withTag:0];
    }
    else if (![self.passWord.text isEqualToString:self.againPassWord.text]){
        [GlobalHelper handerResultWithDelegate:self withMessage:@"新密码二者不一致，请检查" withTag:0];
    }
    else{
        if (notNeedShow) {
            [self commitRequestWithParams:@{@"newpasswd": self.passWord.text} withUrl:[GlobalRequest userAction_UpdatePasswordNotOld_Url]];
        }else{
            NSDictionary *params = @{
                                  @"memberId":[[UserHelper shareInstance] getMemberID],
                                  @"oldpasswd":self.prePassWord.text,
                                  @"newpasswd":self.passWord.text};
            [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_UpdatePassword_Url]];
        }
    }
}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    NSNumber *codeNum = request.handleredResult[@"code"];
    if (codeNum.intValue == 1) {
        [GlobalHelper handerResultWithDelegate:nil withMessage:@"密码修改成功" withTag:0];
        self.passWord.text = self.prePassWord.text = self.againPassWord.text = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (request.handleredResult[@"msg"] && [request.handleredResult[@"msg"] isKindOfClass:[NSString class]]) {
            [GlobalHelper handerResultWithDelegate:nil withMessage:request.handleredResult[@"msg"] withTag:0];
        }else{
            [GlobalHelper handerResultWithDelegate:self withMessage:@"密码修改失败" withTag:0];
        }
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 101) {
        for (UIView *mView in self.view.subviews) {
            mView.top -= 40;
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 101) {
        for (UIView *mView in self.view.subviews) {
            mView.top += 40;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.againPassWord resignFirstResponder];
    }
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.prePassWord resignFirstResponder];
    [self.passWord resignFirstResponder];
    [self.againPassWord resignFirstResponder];
}

- (void)notShowHeadViewWithShow:(BOOL)notshow{
    notNeedShow = notshow;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
