//
//  MyOrderDetailViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "OrdelModel.h"
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
    self.navigationItem.title = self.orderSuccess?@"订单交易成功":@"订单详情";
    self.enterButton.hidden = !self.orderSuccess;
    
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"orderCode": self.orderCode
                                    } withUrl:[GlobalRequest orderAction_QueryOrderInfo_Url]];
    if (!self.orderSuccess) {
        self.enterButton.hidden = YES;
    }
}

- (void)back{
    if ( self.orderSuccess) {
        UIViewController *viewController = nil;
        if ([self.navigationController.childViewControllers count] >1) {
            NSLog(@"%@", self.navigationController.childViewControllers);
           viewController = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 3];
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }else{
        [super back];
    }
}

- (void)enterOrder:(id)sender{
    [self back];
}

- (void)reloadNewData{
    if ([self.model isKindOfClass:[NSDictionary class]]) {
        OrdelModel *ordelModel = [[OrdelModel alloc] initWithDataDic:self.model];
        self.orderNum.text = ordelModel.orderCode;
        self.orderTime.text = ordelModel.orderDate;
        NSArray *orderArray = ordelModel.orderProducts;
        if ([orderArray count] > 0) {
            [self.goodHeadImage setImageWithURL:orderArray[0][@"previewPicPath"]];
            self.goodTitle.text = [NSString stringWithFormat:@"%@",orderArray[0][@"productName"]];
            self.goodID.text = [NSString stringWithFormat:@"%@",orderArray[0][@"productId"]];
        }
        
        self.userName.text = [NSString stringWithFormat:@"%@",ordelModel.orderReceiver[@"receiverName"]];
        self.userPhone.text = [NSString stringWithFormat:@"%@",ordelModel.orderReceiver[@"phone"]];
        self.userDescription.text = [NSString stringWithFormat:@"%@",ordelModel.orderReceiver[@"address"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
