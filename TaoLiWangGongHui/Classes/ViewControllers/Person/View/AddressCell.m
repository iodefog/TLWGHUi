//
//  AddressCell.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AddressCell.h"
//#import "UserAddressDataBase.h"
#import "AddUserInfoViewController.h"
#import "AcceptAddressController.h"

@implementation AddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    if (isIOS7) {
        
    }else{
//        self.addressBackGroundView.hidden = YES;
//        for (UIView *subView in self.contentView.subviews) {
//            subView.left = subView.left - 10;
//        }
    }
}

// 设置为默认地址点击
- (IBAction)selectedClicked:(id)sender {
    if (self.selectBtn.isSelected) {
        return;
    }
    self.selectBtn.selected = !self.selectBtn.selected;
    [self updateDBWith];
}

// 赋值
- (void)setObject:(NSDictionary *)dict{
    userAddressModel = [[NewAddressModel alloc] initWithDataDic:dict];
    self.userName.text = userAddressModel.receiverName;
    self.phoneNum.text = userAddressModel.receiverPhone;
    self.detailAddress.text = userAddressModel.receiverAddress;
    if (userAddressModel.isDefault.boolValue == YES) {
        self.selectBtn.selected = YES;
        self.addressBackGroundView.image = [UIImage imageNamed:self.selectBtn.selected ? @"address_cell_selected.png" : @"address_cell_normal.png"];
        self.userName.textColor = self.phoneNum.textColor = self.detailAddress.textColor = [UIColor colorWithHex:0xee611f];
    }else{
        self.selectBtn.selected = NO;
        self.addressBackGroundView.image = [UIImage imageNamed:self.selectBtn.selected ? @"address_cell_selected.png" : @"address_cell_normal.png"];
        self.userName.textColor = self.phoneNum.textColor = [UIColor colorWithHex:0x49443e];
        self.detailAddress.textColor = [UIColor colorWithHex:0x938b83];
    }
}

// 更新数据 再把当前点击的修改为默认
- (void)updateDBWith{
    NSDictionary *params = @{@"memberId":[[UserHelper shareInstance] getMemberID],
                             @"city": userAddressModel.city?userAddressModel.city:@"",
                             @"isDefault": @"1",
                             @"receiverAddress": userAddressModel.receiverAddress?userAddressModel.receiverAddress:@"",
                             @"receiverAddressId": userAddressModel.receiverAddressId?userAddressModel.receiverAddressId:@"",
                             @"receiverName": userAddressModel.receiverName?userAddressModel.receiverName:@"",
                             @"receiverPhone": userAddressModel.receiverPhone?userAddressModel.receiverPhone:@"",
                             @"receiverPostalcode": userAddressModel.receiverPostalcode?userAddressModel.receiverPostalcode:@""};
    
    [ITTASIBaseDataRequest requestWithParameters:params withRequestUrl:[GlobalRequest addressAction_UpdateAddress_Url] withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        NSLog(@"request start");
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        //        [[TKAlertCenter defaultCenter] postAlertWithMessage:@""];
        NSLog(@"request finish");
        if (self.selectBtn.selected) {
            if (self.addressDelegate && [self.addressDelegate respondsToSelector:@selector(setCurrentCellToDefaultModel:)]) {
                [self.addressDelegate performSelector:@selector(setCurrentCellToDefaultModel:) withObject:userAddressModel];
            }
        }
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        NSLog(@"request cancel");
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        NSLog(@"request fail");
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"加载失败"];
        
    }];
}

// 编辑点击，然后传入当前cell上的所有数据
- (IBAction)editClicked:(UIButton *)sender {
    AddUserInfoViewController *addUserInfoVC = [[AddUserInfoViewController alloc] init];
    if ([selected_navigation_controller().visibleViewController isKindOfClass:[AcceptAddressController class]]) {
        addUserInfoVC.parent = selected_navigation_controller().visibleViewController;
    }
    addUserInfoVC.addressModel = userAddressModel;
    [selected_navigation_controller() pushViewController:addUserInfoVC animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
