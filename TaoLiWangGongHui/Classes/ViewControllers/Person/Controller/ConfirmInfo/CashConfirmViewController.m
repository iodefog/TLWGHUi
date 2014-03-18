//
//  CashConfirmViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "CashConfirmViewController.h"

@interface CashConfirmViewController ()

@end

@implementation CashConfirmViewController

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
    self.navigationItem.title = @"信息确认";
}

// 支付宝客户端支付点击
- (IBAction)aliPayClicked:(UIButton *)sender {
    self.aliPayButton.selected = !sender.selected;
    self.unionpayButton.selected = sender.selected;
}

// 银联支付点击
- (IBAction)unionpayClicked:(UIButton *)sender {
    self.aliPayButton.selected = sender.selected;
    self.unionpayButton.selected = !sender.selected;
}

// 提交
- (IBAction)commitClicked:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
