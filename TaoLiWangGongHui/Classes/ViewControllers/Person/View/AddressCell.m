//
//  AddressCell.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-18.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AddressCell.h"
#import "UserAddressDataBase.h"
#import "AddUserInfoViewController.h"

@implementation AddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

// 设置为默认地址点击
- (IBAction)selectedClicked:(id)sender {
    [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"accept_good_selected"] forState:UIControlStateSelected];
    self.selectBtn.selected = !self.selectBtn.selected;
    self.addressBackGroundView.image = [UIImage imageNamed:self.selectBtn.selected ? @"address_cell_selected.png" : @"address_cell_normal.png"];
    [self updateDBWith];

    if (self.selectBtn.selected) {
        if (self.addressDelegate && [self.addressDelegate respondsToSelector:@selector(setCurrentCellToDefaultModel:)]) {
            [self.addressDelegate performSelector:@selector(setCurrentCellToDefaultModel:) withObject:self.indexPath];
        }
    }
}

// 赋值
- (void)setObject:(AddressModel *)addressModel{
    userAddressModel = addressModel;
    self.userName.text = addressModel.Name;
    self.phoneNum.text = addressModel.Phone;
    self.detailAddress.text = addressModel.Address;
    if (addressModel.Type.intValue == 1) {
        self.selectBtn.selected = YES;
        self.addressBackGroundView.image = [UIImage imageNamed:self.selectBtn.selected ? @"address_cell_selected.png" : @"address_cell_normal.png"];
        self.userName.textColor = self.phoneNum.textColor = self.detailAddress.textColor = [UIColor orangeColor];
    }else{
        self.selectBtn.selected = NO;
        self.addressBackGroundView.image = [UIImage imageNamed:self.selectBtn.selected ? @"address_cell_selected.png" : @"address_cell_normal.png"];
        self.userName.textColor = self.phoneNum.textColor = [UIColor blackColor];
        self.detailAddress.textColor = [UIColor lightGrayColor];
    }
}

// 更新数据，把第一个值先修改为不默认，再把当前点击的修改为默认
- (void)updateDBWith{
    NSMutableArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];
    AddressModel *addressModel = nil;
    if ([dbArray count]> 0) {
        addressModel = [dbArray objectAtIndex:0];
    }
    [[UserAddressDataBase shareDataBase] updateItem:addressModel defaultType:NO];
    if (self.selectBtn.selected) {
        [[UserAddressDataBase shareDataBase] updateItem:userAddressModel defaultType:YES];
        userAddressModel.Type = @"1";
    }
}

// 编辑点击，然后传入当前cell上的所有数据
- (IBAction)editClicked:(UIButton *)sender {
    AddUserInfoViewController *addUserInfoVC = [[AddUserInfoViewController alloc] init];
    addUserInfoVC.addressModel = userAddressModel;
    [selected_navigation_controller() pushViewController:addUserInfoVC animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
