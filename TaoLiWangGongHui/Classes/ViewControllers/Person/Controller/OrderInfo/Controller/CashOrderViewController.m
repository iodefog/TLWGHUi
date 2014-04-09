//
//  CashOrderViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "CashOrderViewController.h"
#import "OrderDetailViewController.h"

@interface CashOrderViewController ()

@end

@implementation CashOrderViewController

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
    self.navigationItem.title = @"订单交易成功";
    NSDictionary *dataDict = self.model[@"result"];
    if ([dataDict isKindOfClass:[NSDictionary class]]) {
        self.cashOrderNum.text = [NSString stringWithFormat:@"%@",dataDict[@"orderCode"]];
        self.cashOrderPrice.text = [NSString stringWithFormat:@"%@元",dataDict[@"totalMoney"]];
        self.cashPaymentStyle.text = [NSString stringWithFormat:@"%@",dataDict[@"companyName"]];
    }
}


//查看订单详情
- (IBAction)viewOrderDetailClicked:(id)sender {
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
    orderDetailVC.orderCode = self.orderCode;
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}


- (void)back{
    UIViewController *viewController = nil;
    if ([self.navigationController.childViewControllers count] >1) {
        NSLog(@"%@", self.navigationController.childViewControllers);
        viewController = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
        [self.navigationController popToViewController:viewController animated:YES];
    }
}

// 返回购物车
- (IBAction)gobackShoppingCartClicked:(id)sender {
    UIViewController *viewController = nil;
    if ([self.navigationController.childViewControllers count] >1) {
        NSLog(@"%@", self.navigationController.childViewControllers);
        viewController = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
        [self.navigationController popToViewController:viewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
