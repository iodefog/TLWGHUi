//
//  HomeViewController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : ViewController  // 首页
{
    BOOL  isBirthDay;
}

@property (strong, nonatomic) IBOutlet UIScrollView *baseScroll; // 首页 底层scroll ，所有的view都添加到这上面
@property (strong, nonatomic) IBOutlet UIScrollView *headScroll; // 首页上部，轮播的scroll
@property (strong, nonatomic) IBOutlet UIImageView *jokeImageView;

@property (strong, nonatomic) IBOutlet UILabel *headLabelView;   // 首页上部scroll 上的文字视图
@property (strong, nonatomic) IBOutlet UILabel *delicateLifeLable; //首页下部，精致生活的文字视图，点击可进入下一页
@property (strong, nonatomic) IBOutlet UILabel *jokeTitle; // 笑话标题
@property (strong, nonatomic) IBOutlet UIWebView *jokeDescription;

@end
