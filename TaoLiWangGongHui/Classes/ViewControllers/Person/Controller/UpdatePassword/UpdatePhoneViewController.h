//
//  UpdatePhoneViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdatePhoneViewController : ViewController //修改手机号码
@property (strong, nonatomic) IBOutlet UITextField *phoneTextField; //手机号码输入框
@property (strong, nonatomic) IBOutlet UITextField *codeTextField; // 验证码输入框
@property (strong, nonatomic) IBOutlet UIButton *getCodeButton; // 获取验证码按钮


@end
