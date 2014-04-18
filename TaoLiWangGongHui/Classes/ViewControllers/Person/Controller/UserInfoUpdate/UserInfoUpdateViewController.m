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
#import "UserInfoModel.h"

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
//    imagePicker = [[ImagePicker alloc] init];
//    imagePicker.parent = self;
    
    // 请求用户信息
    [self commitRequestWithParams:@{@"memberId":[[UserHelper shareInstance] getMemberID]} withUrl:[GlobalRequest userAction_queryUserInfo_Url]];
    
//   NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_head",[[UserHelper shareInstance] getMemberID]]];
//    self.userHeadImage.image = [UIImage imageWithData:imageData];
}

// 头像点击
- (IBAction)headTapGesture:(id)sender {
//    NSLog(@"头像点击");
//    [imagePicker tap:self inView:self.view inController:self toCut:YES];
}


#pragma mark - ImagePicker Delegate
- (void)setViewPhoto:(NSString *)path sender:(id)sender{
//    [self.userHeadImage setImageWithURL:[NSURL fileURLWithPath:path]];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]] forKey:[NSString stringWithFormat:@"%@_head",[[UserHelper shareInstance] getMemberID]]];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
//    [self commitRequestWithParams:@{
//                                    @"memberId": [[UserHelper shareInstance] getMemberID],
//                                    @"head": UIImageJPEGRepresentation(self.userHeadImage.image, 0.8f),
//                                   } withUrl:<#(NSString *)#>]}
}


// 100 手机号码点击
// 101 邮箱地址
// 102 修改密码
- (IBAction)actionClicked:(UIButton *)sender {
    Class class = NSClassFromString(self.classNamesArray[sender.tag - 100]);
    UIViewController *viewController = [[class alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Response Delegate
- (void)reloadNewData{
    if ([self.model isKindOfClass:[NSDictionary class]]) {
        UserInfoModel *userModel = [[UserInfoModel alloc] initWithDataDic:self.model];
        self.phoneNum.text = userModel.phone;
        self.emailLabel.text = userModel.email;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
