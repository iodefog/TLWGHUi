//
//  PersonController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "PersonController.h"
#import "PersonCell.h"
#import "LBHarpy.h"
@interface PersonController ()

@property (nonatomic, strong) NSMutableArray *cellNameArray;
@property (nonatomic, strong) NSMutableArray *classNameArray;

@end

@implementation PersonController
@synthesize personTableView;
@synthesize cellNameArray, classNameArray;

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
	// Do any additional setup after loading the view.
    
    self.personTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    self.personTableView.delegate = self;
    self.personTableView.dataSource = self;
    self.personTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.personTableView];
    
    // 每个cell的文字，形成的一个数组
    cellNameArray = [NSMutableArray arrayWithObjects:
                     @"我的订单",
                     @"配送信息维护",
                     @"用户信息维护",
                     @"意见反馈",
                     @"软件版本信息",
                     @"关于我们", nil];
    classNameArray = [NSMutableArray arrayWithObjects:
                      @"MyOrderController",
                      @"AcceptAddressController",
                      @"UserInfoUpdateViewController",
                      @"FeedbackViewController",
                      @"",
                      @"AboutViewController",nil];
     self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"退出" image:nil target:self action:@selector(logout) font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor]];
}

- (void)logout{
    UIAlertView *logoutAlert = [[UIAlertView alloc] initWithTitle:@"\n确定要退出吗\n\n" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    logoutAlert.delegate = self;
    [logoutAlert show];
}

#pragma mark - UITableView Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [cellNameArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (PersonCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"personCellName";
    PersonCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellName];
    if (!cell) {
        cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = [self.cellNameArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.customImage.image = [UIImage imageNamed:@"input_Top.png"];
    }else if (indexPath.row == [cellNameArray count] - 1){
        cell.customImage.image = [UIImage imageNamed:@"input_Under.png"];
    }else
        cell.customImage.image = [UIImage imageNamed:@"input_Middle.png"];
    cell.indentationLevel = 1;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {  //检查版本信息
        [LBHarpy checkVersion];
    }else{
        UIViewController *viewController = [[(id)NSClassFromString([self.classNameArray objectAtIndex:indexPath.row]) alloc] init];
        viewController.navigationItem.title = self.cellNameArray[indexPath.row];
        [viewController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - UIAlertView Delegate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        [[UserHelper shareInstance] removeMemberID];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate chageLoginVC];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
