//
//  FeedbackViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-6.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

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
    self.feedbackTextView.delegate = self;
}


// 提交意见反馈
- (IBAction)propertystrongnonatomicIBOutletUIButtonfeedbackCommitfeedbackCommit:(id)sender {
    NSString *feedstr = [GlobalHelper quKongGeAndEnder:self.feedbackTextView.text];

    if (feedstr.length > 0) {
        NSDictionary *params = @{
                                 @"memberId":[[UserHelper shareInstance] getMemberID],
                                 @"message":self.feedbackTextView.text
                                 };
       
        [self commitRequestWithParams:params withUrl:[GlobalRequest userAction_Feedback_Url]];
    }else{
        [GlobalHelper handerResultWithDelegate:self withMessage:@"您还没有填写意见，请先填写" withTag:0];
    }
}

#pragma mark - Response Success
- (void)responseSuccessWithResponse:(ITTBaseDataRequest *)request{
    self.feedbackTextView.text = nil;
    [GlobalHelper handerResultWithDelegate:nil withMessage:request.handleredResult[@"msg"] withTag:0];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Response Fail
- (void)responseFailWithResponse:(ITTBaseDataRequest *)request{
    [GlobalHelper handerResultWithDelegate:self withMessage:request.handleredResult[@"msg"] withTag:0];
}

#pragma mark - Response Cancel
- (void)responseCancelWithResponse:(ITTBaseDataRequest *)request{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:@"提交失败"];
}


#pragma mark - TextViewDelegate Mothod

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        self.placeholder.hidden = YES;
    }else{
        self.placeholder.hidden = NO;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.feedbackTextView resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
