//
//  UserInfoUpdateViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UserInfoUpdateViewController.h"
#import "UpdatePhoneViewController.h"
#import "UpdateEmailViewController.h"
#import "UpdatePassWordViewController.h"
#import "ImagePicker.h"

@interface UserInfoUpdateViewController () <ImagePickerDelegate>{
    ImagePicker *imagePicker;
}

@property (nonatomic, strong) NSMutableArray *classNamesArray;

@end

@implementation UserInfoUpdateViewController

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
    self.classNamesArray = [NSMutableArray arrayWithObjects:
                            @"UpdatePhoneViewController",
                            @"UpdateEmailViewController",
                            @"UpdatePassWordViewController",nil];
    imagePicker = [[ImagePicker alloc] init];
    imagePicker.parent = self;
}

// 头像点击
- (IBAction)headTapGesture:(id)sender {
    NSLog(@"头像点击");
    [imagePicker tap:self inView:self.view inController:self toCut:YES];
}


#pragma mark - ImagePicker Delegate
- (void)setViewPhoto:(NSString *)path sender:(id)sender{
    [self.userHeadImage setImageWithURL:[NSURL fileURLWithPath:path]];
}

// 100 手机号码点击
// 101 邮箱地址
// 102 修改密码
- (IBAction)actionClicked:(UIButton *)sender {
    Class class = NSClassFromString(self.classNamesArray[sender.tag - 100]);
    UIViewController *viewController = [[class alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
