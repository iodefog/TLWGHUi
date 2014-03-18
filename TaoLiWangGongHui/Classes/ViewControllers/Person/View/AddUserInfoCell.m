//
//  AddUserInfoCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "AddUserInfoCell.h"

@implementation AddUserInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.textField.delegate = self;
    self.addUserInfoTextView.delegate = self;
    
    //先注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)handleKeyboardWillHide:(NSNotification *)notification
{
    if (doneInKeyboardButton.superview)
    {
        [doneInKeyboardButton removeFromSuperview];
    }
    
}

- (void)handleKeyboardDidShow:(NSNotification *)notification
{
//    NSDictionary *info = [notification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
//    normalKeyboardHeight = kbSize.height;
    
    
    // create custom button
    if (doneInKeyboardButton == nil)
    {
        doneInKeyboardButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        doneInKeyboardButton.frame = CGRectMake(0, 480 - 53, 106, 53);
        [doneInKeyboardButton setTitle:@"完成" forState:UIControlStateNormal];
        doneInKeyboardButton.adjustsImageWhenHighlighted = NO;
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"numPadDoneUp.png"] forState:UIControlStateNormal];
        [doneInKeyboardButton setImage:[UIImage imageNamed:@"numPadDoneDown.png"] forState:UIControlStateHighlighted];
//        [doneInKeyboardButton addTarget:self action:@selector(finishAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // locate keyboard view
    UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
    
    
    
    if (doneInKeyboardButton.superview == nil)
    {
        [tempWindow addSubview:doneInKeyboardButton];	// 注意这里直接加到window上
    }
    
}

- (void)showTextViewHidden:(BOOL)textViewHidden withTextFieldHidden:(BOOL)textFieldHidden{
    self.textFieldView.hidden = textFieldHidden;
    self.textView.hidden = textViewHidden;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.textField resignFirstResponder];
        [self.addUserInfoTextView resignFirstResponder];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [self.textField resignFirstResponder];
        [self.addUserInfoTextView resignFirstResponder];
    }
    return YES;
}

@end
