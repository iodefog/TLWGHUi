//
//  WelfareOrderViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "WelfareOrderViewController.h"
#import "GoodsInfoController.h"
@interface WelfareOrderViewController ()


@end

@implementation WelfareOrderViewController

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
}
- (IBAction)enterOrder:(id)sender {
}

// 商品点击
- (IBAction)goodTapGesture:(id)sender {
    if (!self.goodID.text || [self.goodID.text isEqualToString:@""]) {
        return;
    }
    GoodsInfoController *goodsInfoVC = [[GoodsInfoController alloc] initWithNibName:@"GoodsInfoController" bundle:nil];
    goodsInfoVC.productID = self.goodID.text;
    [self.navigationController pushViewController:goodsInfoVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
