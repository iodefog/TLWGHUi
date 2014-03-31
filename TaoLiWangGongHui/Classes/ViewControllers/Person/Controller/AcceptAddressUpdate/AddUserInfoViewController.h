//
//  AddUserInfoViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAddressModel.h"
#import "TSLocateView.h"

//新增信息
@interface AddUserInfoViewController : ViewController<UIScrollViewDelegate ,UITextFieldDelegate, UITextViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSArray      *provinces;
@property (nonatomic, strong) NSArray      *cities;
@property (nonatomic, strong) TSLocateView *locateView ;
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) NewAddressModel *addressModel;

@end
