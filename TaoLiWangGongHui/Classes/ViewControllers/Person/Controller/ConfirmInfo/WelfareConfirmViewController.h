//
//  WelfareConfirmViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ViewController.h"
#import "GoodsListModel.h"
@interface WelfareConfirmViewController : ViewController // 信息确认
// 头部视图1
@property (strong, nonatomic) IBOutlet UIView *head1View;

@property (strong, nonatomic) IBOutlet UIImageView *goodImage;// 商品图片
@property (strong, nonatomic) IBOutlet UILabel *goodTitle; //商品概要
@property (strong, nonatomic) IBOutlet UILabel *goodID; // 商品编码
@property (nonatomic, strong) UIImage  *goodPic;
@property (nonatomic, strong) NSString *goodText;
@property (nonatomic, strong) NSString *goodIDText;

// 头部视图2
@property (strong, nonatomic) IBOutlet UIView *head2View;

@property (strong, nonatomic) IBOutlet UIButton *commitButton; // 提交按钮
@property (strong, nonatomic) IBOutlet UILabel *userName; //用户名
@property (strong, nonatomic) IBOutlet UILabel *phoneNum; // 手机号码
@property (strong, nonatomic) IBOutlet UILabel *detailAddress;// 详细地址

@property (strong, nonatomic) GoodsListModel *goodsListModel;

@end
