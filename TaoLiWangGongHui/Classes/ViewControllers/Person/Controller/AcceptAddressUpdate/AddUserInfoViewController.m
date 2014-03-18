//
//  AddUserInfoViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "AddUserInfoViewController.h"
#import "UserAddressDataBase.h"
#import "AddressModel.h"

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
    self.navigationItem.title = @"新增信息";
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
    nameTextField.text = self.addressModel.Name;
    cityTextField = (id)[self.view viewWithTag:101];
    cityTextField.text = self.addressModel.City;
    phoneTextField = (id)[self.view viewWithTag:102];
    phoneTextField.text = self.addressModel.Phone;
    zipCodeTextField = (id)[self.view viewWithTag:103];
    zipCodeTextField.text = self.addressModel.ZipCode;
    detailAddressTextField = (id)[self.view viewWithTag:104];
    detailAddressTextField.text = self.addressModel.Address;
    if (detailAddressTextField.text.length > 0) {
        placeHolderLabel.hidden = YES;
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
    
    UIButton *commitBtn = [UIButton createButton:@selector(commitClicked:) title:@"提交" image:nil selectedBgImage:@"login_Select.png" backGroundImage:@"login_Nomal.png" backGroundTapeImage:nil frame:CGRectMake(10, 70*[self.headTitleArray count]+50, 300, 35) tag:110 target:self];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mScrollView addSubview:commitBtn];
    self.mScrollView.contentSize = CGSizeMake(self.view.width, 600) ;
}


- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tapClicked:(UITapGestureRecognizer *)gesture{
    [tempView resignFirstResponder];
}

#pragma mark - Custom View
//创建小的组，详细地址组除外
- (UIView *)createItemTextViewWithTitle:(NSString *)title withPlaceHolder:(NSString *)placeHolder withTag:(NSInteger)tag{
    UIView *mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    mView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.text = title;
    [mView addSubview:titleLabel];
    
    placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.left, 30, titleLabel.width, 30)];
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
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.text = title;
    [mView addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
    textField.placeholder = placeHolder;
    textField.background = [UIImage imageNamed:@"input.png"];
    textField.font = titleLabel.font;
    if(tag == 102 || tag == 103){
        textField.keyboardType = UIKeyboardTypeNumberPad;
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
    
    NSArray *dbArray = [[UserAddressDataBase shareDataBase] readTableName];;
    AddressModel *addModel = [[AddressModel alloc] initWithDataDic:
                              @{@"receiverName":nameTextField.text,
                                @"city":cityTextField.text,
                                @"id": self.addressModel? self.addressModel.AddressId: [NSNumber numberWithInt:1000+[dbArray count]],
                                @"receiverPhone":phoneTextField.text,
                                @"receiverAddress":detailAddressTextField.text,
                                @"receiverPostalcode":zipCodeTextField.text,
                                @"email":self.addressModel?self.addressModel.Email:@"",
                                @"Type":self.addressModel?self.addressModel.Type:@"0",
                                }
                              ];
    if (self.addressModel) {
        if ([[UserAddressDataBase shareDataBase] updateItem:addModel defaultType:addModel.Type.boolValue]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
        }
    }
    else if ([[UserAddressDataBase shareDataBase] insertItem:addModel]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"添加失败"];
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
    self.mScrollView.contentSize = CGSizeMake(self.view.width, 600) ;
    self.mScrollView.frame = self.view.bounds;
    [self.mScrollView scrollRectToVisible:CGRectMake(0,100, self.mScrollView.width, self.mScrollView.height) animated:YES];
}

- (void)changeScrollView{
    self.mScrollView.height = self.view.height - 216;
    self.mScrollView.contentSize = CGSizeMake(self.view.width, 400) ;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    tempView = textField;
    [self changeScrollView];
    if (textField.tag == 103 && !iPhone5) {
        [self.mScrollView scrollRectToVisible:CGRectMake(0, 250, self.mScrollView.width, self.mScrollView.height) animated:YES];
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
    [self resetScrollView];
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    tempView = textView;
    if (textView.superview.bottom > self.view.height - 244) {
        [self changeScrollView];
    }
    [self.mScrollView scrollRectToVisible:CGRectMake(0, 200, self.mScrollView.width, self.mScrollView.height) animated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    [self resetScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
