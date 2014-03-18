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
#import "AddressModel.h"
@interface WelfareConfirmViewController (){
    AddressModel *addressModel;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"信息确认";
    NSArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];
    if ([dbArray count] > 0) {  // 条件避免
        addressModel = dbArray[0];
    }
    if (addressModel.Type) {  // 检查是否有默认地址，如果有就赋值
        self.head1View.hidden = YES;
        self.head2View.hidden = NO;
        self.userName.text = addressModel.Name;
        self.phoneNum.text = addressModel.Phone;
        self.detailAddress.text = addressModel.Address;
    }
    
    self.goodImage.image = self.goodPic;
    self.goodTitle.text = self.goodText;
    self.goodID.text = self.goodIDText;
}

// 创建收货人信息
- (IBAction)addReceiverInfo:(id)sender {
    AcceptAddressController *activitiesVC = [[AcceptAddressController alloc] init];
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

// 提交点击
- (IBAction)commitClicked:(id)sender {

}

// 点击默认地址头视图部分
- (IBAction)head2ViewClicked:(id)sender {
    [self addReceiverInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
