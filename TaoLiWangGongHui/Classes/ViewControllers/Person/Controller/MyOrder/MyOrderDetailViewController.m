//
//  MyOrderDetailViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "MyOrderDetailViewController.h"

@interface MyOrderDetailViewController ()

@end

@implementation MyOrderDetailViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单详情";
    self.enterButton.hidden = YES;
    
    /*
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"orderId": self.orderId
                                    } withUrl:[GlobalRequest orderAction_QueryOrderList_Url]];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
