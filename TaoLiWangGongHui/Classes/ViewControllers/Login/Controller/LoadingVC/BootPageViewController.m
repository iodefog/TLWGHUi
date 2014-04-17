//
//  BootPageViewController.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-24.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#define PageCount       4


#import "BootPageViewController.h"
#import "AppDelegate.h"

@interface BootPageViewController ()

@end

@implementation BootPageViewController
{
    __weak IBOutlet UIScrollView *I5ScrollView;
    __weak IBOutlet UIPageControl *I5Page;
    __weak IBOutlet UIView *I5LoginButton;
    __weak IBOutlet UIButton *I5HomeButton;
    
    __weak IBOutlet UIScrollView *I4ScrollView;
    __weak IBOutlet UIPageControl *I4Page;
    __weak IBOutlet UIButton *I4LoginButton;
    __weak IBOutlet UIButton *I4HomeButton;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarHidden = YES;
    [self iphone5Andiphone4];
}
-(void)iphone5Andiphone4{
    UIScrollView *tempScrollView = iPhone5?I5ScrollView:I4ScrollView;
        for (int i =0; i<PageCount; i++) {
            tempScrollView.contentSize = CGSizeMake(Screen_width*PageCount, Screen_height);
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_width*i, 0, Screen_width, Screen_height)];
            NSString *imageStr = [NSString stringWithFormat:@"loading%d%@.png",i+1,iPhone5?@"_five":@""];
            image.image = [UIImage imageNamed:imageStr];
            [tempScrollView addSubview:image];
        }
}
    
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    I5Page.currentPage = scrollView.contentOffset.x/Screen_width;
    I4Page.currentPage = scrollView.contentOffset.x/Screen_width;
    if (scrollView.contentOffset.x/Screen_width>=3) {
        I5LoginButton.hidden = NO;
        I5HomeButton.hidden = NO;
        I4HomeButton.hidden = NO;
        I4LoginButton.hidden = NO;
    }else{
        I5LoginButton.hidden = YES;
        I5HomeButton.hidden = YES;
        I4HomeButton.hidden = YES;
        I4LoginButton.hidden = YES;
    }
}

- (IBAction)loginButtonClicked:(id)sender{
    AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
    [[NSUserDefaults standardUserDefaults] setObject:@"BootPage_Value" forKey:@"BootPage_key"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [delegate chageRootVC];
}


//- (IBAction)HomeButtonAction:(id)sender {
//
//}

@end
