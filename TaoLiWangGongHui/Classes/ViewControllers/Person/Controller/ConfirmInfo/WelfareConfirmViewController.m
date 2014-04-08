//
//  WelfareConfirmViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "WelfareConfirmViewController.h"
#import "AcceptAddressController.h"
#import "UserAddressDataBase.h"
//#import "AddressModel.h"
#import "NewAddressModel.h"
@interface WelfareConfirmViewController (){
    AddressModel *addressModel;
    NewAddressModel *newAddressModel;
    NSString        *orderCode;
}

@end

@implementation WelfareConfirmViewController

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
    [self commitRequestWithParams:@{@"memberId": [[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest addressAction_QueryAddressList_Url]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"信息确认";
    NSDictionary *dict = @{@"productId":[NSString stringWithFormat:@"%@",self.goodsListModel.productId],
                           @"amount":self.goodsListModel.productQuantity?self.goodsListModel.productQuantity:@"1",
                           @"price":[NSString stringWithFormat:@"%@",self.goodsListModel.costPrice],
                           @"score":@"0",};

    NSDictionary *goodsDict = @{@"orderType":@"3",
                                @"totalMoney":@"0",
                                @"totalScore":[NSString stringWithFormat:@"%@f",self.goodsListModel.costPrice],
                                @"orderProducts":@[dict],};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:goodsDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self commitRequestWithParams:@{
                                    @"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"json":jsonStr} withUrl:[GlobalRequest orderAction_Pay_Url]];
}

// 创建收货人信息
- (IBAction)addReceiverInfo:(id)sender {
    AcceptAddressController *activitiesVC = [[AcceptAddressController alloc] init];
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

// 提交点击
- (IBAction)commitClicked:(id)sender {
    NSLog(@"%ld",    time(NULL));
    NSString *payFlowNo = [NSString stringWithFormat:@"%ld%@",time(NULL),[[UserHelper shareInstance] getMemberID]];
    if (!orderCode) {
        return;
    }
    NSDictionary *params = @{@"memberId":[[UserHelper shareInstance] getMemberID],
                             @"receiverAddressId":newAddressModel.receiverAddressId,
                             @"payMode":@"福利",
                             @"orderCode":orderCode,
                             @"payFlowNo":payFlowNo,
                             @"totalMoney":@"0",
                             @"totalScore":self.goodsListModel.costPrice,};
    [self commitRequestWithParams:params withUrl:[GlobalRequest orderAction_Submit_Url]];
    
    /****
     	用户id（memberId）
     	地址id(receiverAddressId)
     	支付方式(payMode)
     	支付流水号(payFlowNo)
     	金额：totalMoney
     	积分(totalScore)
     */

}

// 点击默认地址头视图部分
- (IBAction)head2ViewClicked:(id)sender {
    [self addReceiverInfo:nil];
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
//        NSNumber *codeNum = request.handleredResult[@"code"];
//        if (!codeNum.boolValue) {
            [GlobalHelper handerResultWithDelegate:nil withMessage:request.handleredResult[@"msg"] withTag:0];
//        }else{
//            
//        }
    }else if ( [request.requestUrl isEqualToString:[GlobalRequest orderAction_Pay_Url]]){
        if([request.handleredResult[@"result"] isKindOfClass:[NSDictionary class]])
        orderCode = request.handleredResult[@"result"][@"orderCode"];
    }
}



- (void)checkWithModel:(NewAddressModel *)newModel{
    // 商品信息
    self.goodImage.image = self.goodPic;
    self.goodTitle.text = self.goodText;
    self.goodID.text = self.goodIDText;

    
    if (!newModel) {  // 条件避免,没有地址，就显示添加地址视图
        self.head1View.hidden = NO;
        self.head2View.hidden = YES;
        return;
    }
    if (((NSNumber *)newModel.isDefault).boolValue) {  // 检查是否有默认地址，如果有就赋值
        self.head1View.hidden = YES;
        self.head2View.hidden = NO;
        self.userName.text = newModel.receiverName;
        self.phoneNum.text = newModel.receiverPhone;
        self.detailAddress.text = newModel.receiverAddress;
    }
 }

- (void)showEmptyView{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
