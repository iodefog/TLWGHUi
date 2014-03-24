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

///淘宝支付
#import "AlixLibService.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"

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
    }
    self.totalPrice.text = self.goodsModel.costPrice;
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
    self.unionpayButton.selected = sender.selected;
    self.aliPayButton.selected = !sender.selected;
}

// 银联支付点击
- (IBAction)unionpayClicked:(UIButton *)sender {
    self.aliPayButton.selected = sender.selected;
    self.unionpayButton.selected = !sender.selected;
}

// 提交
- (IBAction)commitClicked:(id)sender {
    NSArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];
    if ([dbArray count] < 1) {
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"提示" message:@"请选择您的付款方式"];
        return;
    }
    
    [self aliPayMothod];
}

// 头部视图2点击
- (IBAction)head2ViewClicked:(id)sender {
    [self addAddressUser:nil];
}

#pragma mark - 支付宝参数
- (void)aliPayMothod{
    /*
     *生成订单信息及签名
     *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起见，在条件允许的前提下，我们推荐从商户服务器获取完整的订单信息)
     */
    NSString *appScheme = AppName;
//    NSString* orderInfo = [self getOrderInfo:request.handleredResult[@"result"]];
     NSString* orderInfo = [self getOrderInfo:nil];
    NSString* signedStr = [self doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo, signedStr, @"RSA"];
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:nil target:self];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

#pragma mark 支付宝支付
/**
 *  支付宝传参
 */
-(NSString*)getOrderInfo:(NSString*)orderID
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
    
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = orderID;//订单ID（由商家自行制定）
	order.productName = @"goodTitle";//商品标题
	order.productDescription = @"goodDescription"; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",100.]; //商品价格
	order.notifyURL =  @"http://wwww.xxx.com"; //回调URL
	return [order description];
}

/**
 *  支付宝
 *
 *  @return web回调函数
 */
-(void)paymentResult:(NSString *)resultd
{
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
            //小额支付
//            [self StartSubmitRequest:self.OrderBH andType:@"支付宝"];
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
//                [self StartSubmitRequest:self.OrderBH andType:@"支付宝"];
			}
        }
        else
        {
            //交易失败
            [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"支付未完成~"];
        }
    }
    else
    {
        //失败
        [UIAlertView popupAlertByDelegate:self andTag:1001 title:@"信息" message:@"支付未完成~"];
    }
    
}
/**
 *  支付宝
 *
 *  @return 支付宝客服端回调函数
 */
-(void)paymentResultSuccees
{
//    [self StartSubmitRequest:self.OrderBH andType:@"支付宝"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
