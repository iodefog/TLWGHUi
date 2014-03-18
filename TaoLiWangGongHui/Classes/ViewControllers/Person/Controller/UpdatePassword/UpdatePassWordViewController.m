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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)commitClicked:(id)sender {
    if (self.passWord.text.length < 6){
        [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"新密码不能为空，且长度至少为6位"];
    }else{
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"memberId", [[UserHelper shareInstance] getMenberID],
                              @"oldpasswd", self.prePassWord.text,
                              @"newpasswd", self.passWord.text, nil];
        [self commitRequestWithParams:dict withUrl:[GlobalRequest userAction_UpdatePassword_Url]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end