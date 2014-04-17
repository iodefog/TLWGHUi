//
//  AddUserInfoViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "AddUserInfoViewController.h"
#import "AcceptAddressController.h"
#import "UserAddressDataBase.h"
#import "AddressModel.h"
#import "AddDocumentPathFile.h"
#import "GetCityDataRequest.h"

@interface AddUserInfoViewController (){
    UILabel *placeHolderLabel;
    UIView  *tempView;
    
    UITextField *nameTextField;
    UITextField *cityTextField;
    UITextField *phoneTextField;
    UITextField *zipCodeTextField;
    UITextView *detailAddressTextField;
}

@property (nonatomic, strong) NSArray *headTitleArray;
@property (nonatomic, strong) NSArray *headPlaceHolderArray;

@end

@implementation AddUserInfoViewController

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
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.addressModel) {
        self.navigationItem.title = @"编辑信息";
    }else{
        self.navigationItem.title = @"新增信息";
    }
    self.headTitleArray = [NSArray arrayWithObjects:
                           @"收货人姓名",
                           @"所在地区",
                           @"手机号码",
                           @"邮政编码",
                           @"详细地址",nil];
    self.headPlaceHolderArray = [NSArray arrayWithObjects:
                                 @"请输入收货人姓名",
                                 @"请选择所在地区",
                                 @"请输入手机号码",
                                 @"请输入邮政编码",
                                 @"请输入收货的详细地址",nil];
    [self createUI];
    
    nameTextField = (id)[self.view viewWithTag:100];
    nameTextField.text = self.addressModel.receiverName;
    cityTextField = (id)[self.view viewWithTag:101];
    cityTextField.text = self.addressModel.city;
    phoneTextField = (id)[self.view viewWithTag:102];
    phoneTextField.text = self.addressModel.receiverPhone;
    zipCodeTextField = (id)[self.view viewWithTag:103];
    zipCodeTextField.text = self.addressModel.receiverPostalcode;
    detailAddressTextField = (id)[self.view viewWithTag:104];
    detailAddressTextField.text = self.addressModel.receiverAddress;
    if (detailAddressTextField.text.length > 0) {
        placeHolderLabel.hidden = YES;
    }
    
    self.provinces = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProviedataArray"];
    self.cities = [[NSUserDefaults standardUserDefaults] objectForKey:@"ProviedataResult"];
    [self.locateView setObjectWithProvince:self.provinces withCity:self.cities];

    // 请求省份数据
    [GetCityDataRequest requestWithParameters:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {

    } onRequestFinished:^(ITTBaseDataRequest *request) {
        if (!self.provinces || !self.cities ) {
            self.provinces = request.handleredResult[@"ProviedataArray"];
            self.cities = request.handleredResult[@"result"];
            [self.locateView setObjectWithProvince:self.provinces withCity:self.cities];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.provinces forKey:@"ProviedataArray"];
         [[NSUserDefaults standardUserDefaults] setObject:self.cities forKey:@"ProviedataResult"];
       
        NSLog(@"request finish");
        [self responseSuccessWithResponse:request];
        
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
        NSLog(@"request cancel");
//        [self responseFailWithResponse:request];
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
//        [self responseCancelWithResponse:request];
        NSLog(@"request fail");
    }];
    
    NSMutableArray *arr = [self ProviceAndCityWithDm01:self.addressModel.city andDm02:self.self.addressModel.city];
    if ([arr count] > 1) {
        cityTextField.text = [NSString stringWithFormat:@"%@ %@",[arr objectAtIndex:0],[arr objectAtIndex:1]];
    }
}

- (void)createUI{
    self.mScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [self.mScrollView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.mScrollView];
    
    for (int i = 0; i < self.headTitleArray.count; i ++) {
        if(i == self.headTitleArray.count - 1){
            UIView *mView = [self createItemTextViewWithTitle:self.headTitleArray[i] withPlaceHolder:self.headPlaceHolderArray[i]  withTag:100+i];
            mView.frame = CGRectMake(0, 70*i, self.view.width, 100);
            [self.mScrollView addSubview:mView];
        }else{
            UIView *mView = [self createItemViewWithTitle:self.headTitleArray[i] withPlaceHolder:self.headPlaceHolderArray[i] withTag:100+i];
            mView.frame = CGRectMake(0, 70*i, self.view.width, 70);
            [self.mScrollView addSubview:mView];
        }
    }
    
    if(self.addressModel){
    UIButton *commitBtn = [UIButton createButton:@selector(commitClicked:) title:@"提交" image:nil selectedBgImage:@"login_Select.png" backGroundImage:@"login_Nomal.png" backGroundTapeImage:nil frame:CGRectMake(10, 70*[self.headTitleArray count]+50, 300, 35) tag:110 target:self];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mScrollView addSubview:commitBtn];
    self.mScrollView.contentSize = CGSizeMake(self.view.width, 510) ;
    }else{
        
       UIBarButtonItem *barItem = [UIBarButtonItem barButtonWithTitle:@"提交" image:nil target:self action:@selector(commitClicked:) font:[UIFont systemFontOfSize:14] titleColor:[UIColor whiteColor] withRightBarItem:YES];
        self.navigationItem.rightBarButtonItem = barItem;
    self.mScrollView.contentSize = CGSizeMake(self.view.width, 500) ;
    }
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapClicked:(UITapGestureRecognizer *)gesture{
    [tempView resignFirstResponder];
    [self resetScrollView];
}

#pragma mark - Custom View
//创建小的组，详细地址组除外
- (UIView *)createItemTextViewWithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withTag:(NSInteger)tag{
    UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    mView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.text = title;
    [mView addSubview:titleLabel];
    
    placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left+8, 30, titleLabel.width, 30)];
    placeHolderLabel.textColor = [UIColor grayColor];
    placeHolderLabel.font = titleLabel.font;
    placeHolderLabel.text = placeHolder;
    placeHolderLabel.tag = 1000;
    placeHolderLabel.backgroundColor = [UIColor clearColor];
    [mView addSubview:placeHolderLabel];
    
    UIImageView *textBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 300, 70)];
    textBgView.backgroundColor = [UIColor clearColor];
    textBgView.image = [UIImage imageNamed:@"input.png"];
    [mView addSubview:textBgView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 30, textBgView.width, textBgView.height)];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = titleLabel.font;
    textView.returnKeyType = UIReturnKeyDone;
    textView.delegate = self;
    textView.tag = tag;
    [mView addSubview:textView];
    return mView;
}

//创建小的组，详细地址组除外
- (UIView *)createItemViewWithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withTag:(NSInteger)tag{
    UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 70)];
    mView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.text = title;
    [mView addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
    textField.placeholder = placeHolder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.background = [UIImage imageNamed:@"input.png"];
    textField.font = titleLabel.font;
    textField.returnKeyType = UIReturnKeyNext;

    if(tag == 102 || tag == 103){
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    if (tag == 104) {
        textField.returnKeyType = UIReturnKeyDone;
    }
    textField.delegate = self;
    textField.tag = tag;
    [mView addSubview:textField];
    return mView;
}

// 提交点击
- (void)commitClicked:(UIButton *)sender{
    if (nameTextField.text.length <1 || cityTextField.text.length < 1 || detailAddressTextField.text.length < 1) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请填写正确收货信息"];
        if (detailAddressTextField.text.length < 1) [detailAddressTextField becomeFirstResponder];
        if (cityTextField.text.length < 1)          [cityTextField becomeFirstResponder];
        if (nameTextField.text.length < 1)          [nameTextField becomeFirstResponder];
        return;
    }
    else if (phoneTextField.tag == 102) {
        if (![GlobalHelper isValidatePhone:phoneTextField.text]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确的手机号码"];
            return;
        }
    }else if (zipCodeTextField.tag == 103){
        if (![GlobalHelper isValidateZipCode:zipCodeTextField.text]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确地的邮编"];
            return;
        }
    }
    
//    NSArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];;
    NSString *receiverAddressId = self.addressModel.receiverAddressId;
    if (!receiverAddressId) {
        receiverAddressId = @"";
    }
    NSDictionary *params =  @{@"receiverName":nameTextField.text,
                              @"city":cityTextField.text,
                              @"memberId": [[UserHelper shareInstance] getMemberID],
                              @"receiverPhone":phoneTextField.text,
                              @"receiverAddress":detailAddressTextField.text,
                               @"receiverAddressId":receiverAddressId,
                              @"receiverPostalcode":zipCodeTextField.text,
                             
                              @"isDefault":  @"1",
                              };
    AddressModel *addModel = [[AddressModel alloc] initWithDataDic:params];
    if (self.addressModel) {
            // 更新提交到服务器
        [self commitRequestWithParams:params withUrl:[GlobalRequest addressAction_UpdateAddress_Url]];
    }
    else if ([[UserAddressDataBase shareDataBase] insertItem:addModel]) {
        // 添加提交到服务器
        [self commitRequestWithParams:params withUrl:[GlobalRequest addressAction_AddAddress_Url]];
    }
}

#pragma mark - UITextField delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        if ( (textField.tag < 100+self.headTitleArray.count-2)) {
            NSInteger tag = textField.tag + 1;
            UITextField *nextTextField = (id)[self.view viewWithTag:tag];
            [nextTextField becomeFirstResponder];
            
        }else{
            [textField resignFirstResponder];
            [self resetScrollView];
        }
    }else{
        if ( (textField.tag == 103) && (textField.text.length >= 6) && (![string isEqualToString:@""])) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 101) {
        [tempView resignFirstResponder];
        if (!self.locateView) {
            self.locateView = [[TSLocateView alloc] initWithTitle:@"城市选择" delegate:self];
            [self.locateView setObjectWithProvince:self.provinces withCity:self.cities];
        }
        self.locateView.alpha = 1;
        self.locateView.bottom = self.view.bottom;
        if (!self.locateView.superview) {
            [self.view addSubview:self.locateView];
        }
        return NO;
    }else{
        [self.locateView removeFromSuperview];
//        if (textField.tag == 103) {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.mScrollView.contentOffset = CGPointMake(self.mScrollView.contentOffset.x, 300);
//            }];
//        }
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        if ( (textView.tag < 100+self.headTitleArray.count-2)) {
            NSInteger tag = textView.tag + 1;
            UITextField *nextTextField = (id)[self.view viewWithTag:tag];
            [nextTextField becomeFirstResponder];
            
        }else{
            [textView resignFirstResponder];
            [self resetScrollView];
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length < 1) {
        placeHolderLabel.hidden = NO;
    }else{
        placeHolderLabel.hidden = YES;
    }
}

- (void)resetScrollView{
    self.mScrollView.frame = self.view.bounds;
    self.mScrollView.contentSize = CGSizeMake(self.view.width, self.view.height + 50) ;
//    [self.mScrollView scrollRectToVisible:CGRectMake(0,100, self.mScrollView.width, self.mScrollView.height) animated:YES];
}

- (void)changeScrollView{
    self.mScrollView.height = self.view.height - 216;
    self.mScrollView.contentSize = CGSizeMake(self.view.width, 400) ;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    tempView = textField;
    [self changeScrollView];
    if (textField.tag == 103 && !iPhone5) {
        if (isIOS7) {
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(self.mScrollView.contentOffset.x, 300);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.mScrollView.contentOffset = CGPointMake(self.mScrollView.contentOffset.x, 200);
            }];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 102) {
        if (![GlobalHelper isValidatePhone:textField.text]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确的手机号码"];
        }
    }else if (textField.tag == 103){
        if (![GlobalHelper isValidateZipCode:textField.text]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确地的邮编"];
        }
    }
//    [self resetScrollView];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    tempView = textView;
    if (textView.superview.bottom > self.view.height - 244) {
        [self changeScrollView];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.mScrollView.contentOffset = CGPointMake(self.mScrollView.contentOffset.x, 250);
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
//    [self resetScrollView];
}

- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    if ([request.requestUrl isEqualToString:[GlobalRequest addressAction_QueryProvinceAndRegionList_Url]]) {
        
    }else{
        if (self.addressModel) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        if (self.parent && [self.parent respondsToSelector:@selector(refreshHeaderView)]) {
            [self.parent  performSelector:@selector(refreshHeaderView) withObject:nil];
        }
    }
}

- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
}

#pragma mark Method
-(NSMutableArray *)ProviceAndCityWithDm01:(NSString *)dm01 andDm02:(NSString *)dm02
{
    NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:[AddDocumentPathFile AddFileName:@"test01.plist" andType:@"plist"]];
    NSMutableArray *arr01 = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in arr) {
        if ([dm01 isEqualToString:[dict objectForKey:@"dm"]]) {
            [arr01 addObject:[dict objectForKey:@"mc"]];
        }
        if ([dm02 isEqualToString:[dict objectForKey:@"dm"]]) {
            [arr01 addObject:[dict objectForKey:@"mc"]];
        }
    }
    return arr01;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (!self.locateView.locate.mc ) self.locateView.locate.mc = @"";
        if (!self.locateView.locate.mc01) self.locateView.locate.dm01 = @"";
        cityTextField.text = [NSString stringWithFormat:@"%@ %@",self.locateView.locate.mc, self.locateView.locate.mc01];
    }
    [self resetScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
