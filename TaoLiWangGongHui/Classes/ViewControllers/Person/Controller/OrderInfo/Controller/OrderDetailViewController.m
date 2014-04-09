//
//  OrderDetailViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderProductModel.h"
#import "OrderGoodView.h"
#import "OrdelModel.h"

@interface OrderDetailViewController ()

@property (nonatomic, strong) NSMutableArray *goodsArray;

@end

@implementation OrderDetailViewController

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
    self.goodsArray = [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
//    [self createUI];
    
    self.navigationItem.title = @"订单详情";
    
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"orderCode": self.orderCode
                                    } withUrl:[GlobalRequest orderAction_QueryOrderInfo_Url]];
}

- (void)createUIWithProductArray:(NSArray *)productArray{
    for (int i = 0; i < [productArray count]; i++) {
        OrderGoodView *orderView = [[OrderGoodView alloc] initWithFrame:CGRectMake(10, 140+70*i, 300, 70)];
        orderView.image = [UIImage imageNamed:(i==0)?@"input_Top.png":((i==self.goodsArray.count-1)?@"input_Under.png":@"input_Middle.png")];
        OrderProductModel *orderModel = [[OrderProductModel alloc] initWithDataDic:productArray[i]];
        orderView.goodTitle.text = orderModel.productName;
        orderView.goodQuantity.text = [NSString stringWithFormat:@"x%@", orderModel.amount];
        orderView.goodPrice.text = [NSString stringWithFormat:@"%@元", orderModel.totalMoney];
        [orderView.goodHeadView setImageWithURL:[NSURL URLWithString:orderModel.previewPicPath]];
        [self.baseScrollView addSubview:orderView];
    }
    self.baseScrollView.contentSize = CGSizeMake(320, 140+productArray.count*70+260);
    self.bottomView.top = 150+productArray.count*70;

}

- (void)reloadNewData{
    if ([self.model isKindOfClass:[NSDictionary class]]) {
        OrdelModel *ordelModel = [[OrdelModel alloc] initWithDataDic:self.model];
        self.orderID.text = ordelModel.orderCode;
        self.orderTime.text = ordelModel.orderDate;
        
        [self createUIWithProductArray:ordelModel.orderProducts];
        self.orderPrice.text = [NSString stringWithFormat:@"%@元",ordelModel.totalMoney];
        self.orderUserName.text = [NSString stringWithFormat:@"%@",ordelModel.orderReceiver[@"receiverName"]];
        self.orderPhone.text = [NSString stringWithFormat:@"%@",ordelModel.orderReceiver[@"phone"]];
        self.orderDescription.text = [NSString stringWithFormat:@"%@",ordelModel.orderReceiver[@"address"]];
        self.orderTotalPrice.text = [NSString stringWithFormat:@"%@元",ordelModel.totalMoney];
    }
}

//返回购物车点击
- (IBAction)backShoppingCartClicked:(id)sender {
    UINavigationController *currentNavC = selected_navigation_controller();
    [currentNavC  popToRootViewControllerAnimated:NO];
    AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
    [delegate.baseViewController setSelectedIndex:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
