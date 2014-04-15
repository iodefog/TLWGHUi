//
//  AboutViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (!iPhone5) {
        self.aboutDescription.height = 355 - 44*3;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self commitRequestWithParams:@{@"companyId":@"1"} withUrl:[GlobalRequest activityAction_QueryWebSiteInfo_Url]];
}

- (void)reloadNewData{
    if ([self.model isKindOfClass:[NSString class]]) {
        self.aboutDescription.text = self.model;
    }else if ([self.model isKindOfClass:[NSArray class]] && [self.model count] > 0){
        NSDictionary *dict = self.model[0];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            self.aboutDescription.text = dict[@"shopName"];
        }
    }
}

- (void)setEmptyView:(TKEmptyView *)emptyView{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
