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
    self.head.hidden = YES;
    self.bottom.top = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改密码";
}
- (IBAction)commitClicked:(id)sender {
    if (self.passWord.text.length < 6){
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"新密码不能为空，且长度至少为6位"];
    }
    else if (![self.passWord.text isEqualToString:self.againPassWord.text]){
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"新密码二者不一致，请检查"];
    }
    else{
        if (notNeedShow) {
            [self commitRequestWithParams:@{@"newpasswd": self.passWord.text} withUrl:[GlobalRequest userAction_UpdatePasswordNotOld_Url]];
        }else{
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                  @"memberId", [[UserHelper shareInstance] getMemberID],
                                  @"oldpasswd", self.prePassWord.text,
                                  @"newpasswd", self.passWord.text, nil];
            [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_UpdatePassword_Url]];
        }
    }
}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    NSNumber *codeNum = request.handleredResult[@"code"];
    if (codeNum.intValue == 1) {
        [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"提示" message:@"密码修改成功"];
        self.passWord.text = self.prePassWord.text = self.againPassWord.text = nil;
    }else{
        if (request.handleredResult[@"msg"] && [request.handleredResult[@"msg"] isKindOfClass:[NSString class]]) {
            [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"提示" message:request.handleredResult[@"msg"]];
        }else{
            [UIAlertView popupAlertByDelegate:self andTag:1000 title:@"提示" message:@"密码修改失败"];
        }
    }
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
