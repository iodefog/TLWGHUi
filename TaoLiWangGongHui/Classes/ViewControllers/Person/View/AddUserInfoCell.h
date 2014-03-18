//
//  AddUserInfoCell.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-10.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserInfoCell : UITableViewCell <UITextViewDelegate, UITextFieldDelegate>
{
    UIButton *doneInKeyboardButton;
}
// textFieldView
@property (strong, nonatomic) IBOutlet UIView *textFieldView;
@property (strong, nonatomic) IBOutlet UITextField *textField;

// textView
@property (strong, nonatomic) IBOutlet UIView *textView;
@property (strong, nonatomic) IBOutlet UITextView *addUserInfoTextView;

// 显示哪种类型的cell
- (void)showTextViewHidden:(BOOL)textViewHidden withTextFieldHidden:(BOOL)textFieldHidden;

@end
