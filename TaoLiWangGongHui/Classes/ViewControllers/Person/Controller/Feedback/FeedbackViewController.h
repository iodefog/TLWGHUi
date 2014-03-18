//
//  FeedbackViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackViewController : ViewController <UITextViewDelegate>  // 意见反馈

@property (strong, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (strong, nonatomic) IBOutlet UILabel *placeholder;

@end
