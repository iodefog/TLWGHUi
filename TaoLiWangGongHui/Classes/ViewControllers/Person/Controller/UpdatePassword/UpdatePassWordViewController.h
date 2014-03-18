//
//  UpdateViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePassWordViewController : ViewController // 修改密码
@property (strong, nonatomic) IBOutlet UITextField *prePassWord; // 原密码
@property (strong, nonatomic) IBOutlet  UITextField *passWord; // 新密码
@property (strong, nonatomic) IBOutlet UITextField *againPassWord; // 确认密码
@end
