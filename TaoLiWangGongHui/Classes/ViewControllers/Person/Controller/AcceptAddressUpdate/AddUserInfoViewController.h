//
//  AddUserInfoViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
//新增信息
@interface AddUserInfoViewController : ViewController<UIScrollViewDelegate ,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) AddressModel *addressModel;

@end
