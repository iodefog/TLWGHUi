//
//  CashConfirmViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "CashConfirmViewController.h"
#import "AcceptAddressController.h"
#import "UserAddressDataBase.h"
#import "AliPayHelper.h"

@interface CashConfirmViewController (){
    AddressModel *addressModel;
}

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

static bool shoppingShow = NO;
- (void)shoppingPriceWithShow:(BOOL)show{
    shoppingShow = show;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];
    if ([dbArray count] > 0) {  // 条件避免
        addressModel = dbArray[0];
    }
    if (addressModel.Type) {  // 检查是否有默认地址，如果有就赋值
        self.head1.hidden = YES;
        self.head2.hidden = NO;
        self.userName.text = addressModel.Name;
        self.phoneNum.text = addressModel.Phone;
        self.detailAddress.text = addressModel.Address;
        if (shoppingShow) {
            self.totalPrice.text = [NSString stringWithFormat:@"%.2f元",self.goodsSumPrice];
        }else{
            self.totalPrice.text = self.goodsModel.costPrice;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"信息确认";
}

// 创建收货人信息
- (IBAction)addAddressUser:(id)sender {
    AcceptAddressController *activitiesVC = [[AcceptAddressController alloc] init];
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

// 支付宝客户端支付点击
- (IBAction)aliPayClicked:(UIButton *)sender {
    if (self.aliPayButton == sender && self.aliPayButton.selected) {
        return;
    }
    self.unionpayButton.selected = sender.selected;
    self.aliPayButton.selected = !sender.selected;
}

// 银联支付点击
- (IBAction)unionpayClicked:(UIButton *)sender {
    if (self.unionpayButton == sender && self.unionpayButton.selected) {
        return;
    }
    self.aliPayButton.selected = sender.selected;
    self.unionpayButton.selected = !sender.selected;
}

// 提交
- (IBAction)commitClicked:(id)sender {
    if (!self.aliPayButton.selected && !self.unionpayButton.selected) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"请选择您的付款方式" withTag:0];
    }
    else if (self.aliPayButton.selected) {
        [self aliPayMothod];
    }else if(self.unionpayButton.selected){
    
    }
}

// 头部视图2点击
- (IBAction)head2ViewClicked:(id)sender {
    [self addAddressUser:nil];
}

#pragma mark - 支付宝参数
- (void)aliPayMothod{
    Product *product = [[Product alloc] init];
    
    if (shoppingShow) {
        product.subject = @"淘礼网付款";
        product.body = @"购买超值商品，就取淘礼网";
        product.price = self.goodsSumPrice;
    }else{
        product.subject = self.goodsModel.productName;
        product.body = self.goodsModel.productDescribe;
        product.price = self.goodsModel.costPrice.floatValue;
    }
    [[AliPayHelper shareInstance] setAliPayProduct:product];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
