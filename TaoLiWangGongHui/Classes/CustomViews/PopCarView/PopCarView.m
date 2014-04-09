//
//  PopCarView.m
//  TaoliWang
//
//  Created by Mac OS X on 14-3-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "PopCarView.h"
#import "GoodsDetailDataBase.h"
#import "AppDelegate.h"

@implementation PopCarView

- (id)init
{
    if (self = [super init]) {
      self = [PopCarView loadFromXib];
    }
    return self;
}

-(void)SetCarNumber{
    NSArray *array = [[GoodsDetailDataBase shareDataBase] readTableName];
    if ([array count] == 0) {
        self.NumLable.text = @"";
        self.numBgView.hidden = YES;
        return;
    }
    self.numBgView.hidden = NO;
    self.NumLable.text = [NSString stringWithFormat:@"%d",array.count];

}
- (IBAction)JoinCarButtonClick:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(JoinCarButtonClick:)]) {
//        [self.delegate performSelector:@selector(JoinCarButtonClick:) withObject:sender];
//    }
    UINavigationController *currentNavC = selected_navigation_controller();
    [currentNavC  popToRootViewControllerAnimated:NO];
    AppDelegate *delegate = (id)[UIApplication sharedApplication].delegate;
    [delegate.baseViewController setSelectedIndex:1];
    [self removeFromSuperview];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}
@end
