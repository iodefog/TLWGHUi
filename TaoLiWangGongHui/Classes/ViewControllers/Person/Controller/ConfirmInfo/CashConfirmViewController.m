//
//  CashConfirmViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "CashConfirmViewController.h"
#import "AcceptAddressController.h"
#import "CashOrderViewController.h"
#import "UserAddressDataBase.h"
#import "GoodsDetailDataBase.h"
#import "AliPayHelper.h"
#import "NewAddressModel.h"

@interface CashConfirmViewController ()<AlixLibPayDelegate>{
    AddressModel *addressModel;
    NewAddressModel *newAddressModel;
    NSString        *orderCode;      // 服务器返回订单号
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
    self.totalPrice.text = [NSString stringWithFormat:@"%.2f元",self.goodsSumPrice];
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest addressAction_QueryAddressList_Url]];

//    NSArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];
//    if ([dbArray count] > 0) {  // 条件避免
//        addressModel = dbArray[0];
//    }else{
//        self.head1.hidden = NO;
//        self.head2.hidden = YES;
//        return;
//    }
//    if (addressModel.Type) {  // 检查是否有默认地址，如果有就赋值
//        self.head1.hidden = YES;
//        self.head2.hidden = NO;
//        self.userName.text = addressModel.Name;
//        self.phoneNum.text = addressModel.Phone;
//        self.detailAddress.text = addressModel.Address;
//        if (shoppingShow) {
//            self.totalPrice.text = [NSString stringWithFormat:@"%.2f元",self.goodsSumPrice];
//        }else{
//            self.totalPrice.text = self.goodsModel.costPrice;
//        }
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"信息确认";
    NSArray *goodsArray = [[GoodsDetailDataBase shareDataBase] readTableName];
    self.goodsSumPrice = [self sumAllGoodsPriceWithArray:goodsArray];
    NSMutableArray *orderArray = [NSMutableArray array];
    for (GoodsListModel *goodsModel in goodsArray) {
        NSDictionary *dict = @{@"productId":[NSString stringWithFormat:@"%@",goodsModel.productId],
                               @"amount":goodsModel.productQuantity?goodsModel.productQuantity:@"1",
                               @"price":[NSString stringWithFormat:@"%@",goodsModel.costPrice],
                               @"score":@"0",};
        [orderArray addObject:dict];
    }
    NSDictionary *goodsDict = @{@"orderType":@"3",
                           @"totalMoney":[NSString stringWithFormat:@"%.2f",self.goodsSumPrice],
                           @"totalScore":@"0",
                           @"orderProducts":orderArray,};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:goodsDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self commitRequestWithParams:@{
                                    @"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"json":jsonStr} withUrl:[GlobalRequest orderAction_Pay_Url]];
    
    /****
     	用户id（memberId）
     以下部分全部放到json中
     	订单号(orderCode)
     	订单类型(orderType)  1：生日， 2： 节日  3 购物商品
     	总金额(totalMoney)
     	总积分(totalScore)
     	商品（数组）
     	商品ID(productId)
     	数量（amount）
     	单价（price）
     	积分(score)
     */
}

- (float)sumAllGoodsPriceWithArray:(NSArray *)dbArray{
    CGFloat sum = 0;
    for(GoodsListModel *goodsModel in dbArray){
        NSString *productId = goodsModel.productId;
        NSString *productQuality = [[GoodsDetailDataBase shareDataBase]readTableQualityWithProductID:productId];
        NSLog(@"************* %@", productQuality);
        float tempPrice = ((NSNumber *)goodsModel.costPrice).floatValue;
        sum += tempPrice * (productQuality?productQuality.intValue:1);
    }
    return sum;
}


// 创建收货人信息
- (IBAction)addAddressUser:(id)sender {
    AcceptAddressController *activitiesVC = [[AcceptAddressController alloc] init];
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

// 支付宝客户端支付点击
- (IBAction)aliPayClicked:(UIButton *)sender {
       /****
     	用户id（memberId）
     	地址id(receiverAddressId)
     	支付方式(payMode)
     	支付流水号(payFlowNo)
     	金额：totalMoney
     	积分(totalScore)
     */
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
//        [self aliPayMothod];
        [self alixLibPaySuccess:nil];
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
        product.subject = @"淘礼网购买商品付款";
        product.body = @"购买超值商品，就去淘礼网";
        product.price = self.goodsSumPrice;
        product.orderId = orderCode;
    }else{
        product.subject = self.welfareGoodsModel.productName;
        product.body = self.welfareGoodsModel.productDescribe;
        product.price = self.welfareGoodsModel.costPrice.floatValue;
        product.orderId = orderCode;
    }
    ((AliPayHelper *)[AliPayHelper shareInstance]).aliPayDelegate = self;
    [[AliPayHelper shareInstance] setAliPayProduct:product];
}

#pragma mark - request Response
- (void)setDataDic:(NSDictionary *)resultDic withRequest:(ITTBaseDataRequest *)request{
    NSLog(@"%@", request.handleredResult);
    if ([request.requestUrl isEqualToString:[GlobalRequest addressAction_QueryAddressList_Url]]) {
        [super setDataDic:resultDic withRequest:request];
        for (NSDictionary *dict in self.model) {
            NewAddressModel *tempModel = [[NewAddressModel alloc] initWithDataDic:dict];
            if (((NSNumber *)tempModel.isDefault).boolValue) {
                newAddressModel = tempModel;
                break;
            }
        }
        [self checkWithModel:newAddressModel];
    }else if ([request.requestUrl isEqualToString:[GlobalRequest orderAction_Submit_Url]]){
        NSLog(@"%@",request.handleredResult[@"msg"]);
        NSNumber *codeNum = request.handleredResult[@"code"];
        if (!codeNum.boolValue) {
            [GlobalHelper handerResultWithDelegate:nil withMessage:request.handleredResult[@"msg"] withTag:0];
        }else{
            [[GoodsDetailDataBase shareDataBase] cleanTabel];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cartDBChange" object:nil];
            
            CashOrderViewController *orderDetailVC = [[CashOrderViewController alloc] initWithNibName:@"CashOrderViewController" bundle:nil];
            orderDetailVC.orderCode = orderCode;
            orderDetailVC.model = resultDic;
            [self.navigationController pushViewController:orderDetailVC animated:YES];
        }
    }else if ( [request.requestUrl isEqualToString:[GlobalRequest orderAction_Pay_Url]]){
        if ([request.handleredResult[@"result"] isKindOfClass:[NSDictionary class]]) {
            orderCode = request.handleredResult[@"result"][@"orderCode"];
        }
    }
}

- (void)checkWithModel:(NewAddressModel *)newModel{
    if (!newModel) {  // 条件避免,没有地址，就显示添加地址视图
        self.head1.hidden = NO;
        self.head2.hidden = YES;
        return;
    }
    if (((NSNumber *)newModel.isDefault).boolValue) {  // 检查是否有默认地址，如果有就赋值
        self.head1.hidden = YES;
        self.head2.hidden = NO;
        self.userName.text = newModel.receiverName;
        self.phoneNum.text = newModel.receiverPhone;
        self.detailAddress.text = newModel.receiverAddress;
    }
}

#pragma mark - AliPayDelgate
- (void)alixLibPayFail:(id)response{
    [GlobalHelper handerResultWithDelegate:nil withMessage:@"支付失败" withTag:1000];
}

- (void)alixLibPaySuccess:(id)response{
    NSLog(@"%ld",    time(NULL));
    NSString *payFlowNo = [NSString stringWithFormat:@"%ld%@",time(NULL),[[UserHelper shareInstance] getMemberID]];
    if (!orderCode) {
        return;
    }
    NSDictionary *params = @{@"memberId":[[UserHelper shareInstance] getMemberID],
                             @"receiverAddressId":newAddressModel.receiverAddressId,
                             @"payMode":@"支付宝",
                             @"orderCode":orderCode,
                             @"payFlowNo":payFlowNo,
                             @"totalMoney":[NSString stringWithFormat:@"%.2f",self.goodsSumPrice],
                             @"totalScore":@"0"};
    [self commitRequestWithParams:params withUrl:[GlobalRequest orderAction_Submit_Url]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
