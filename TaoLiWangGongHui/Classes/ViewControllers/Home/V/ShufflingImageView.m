//
//  ShufflingImageView.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ShufflingImageView.h"
#import "ActivitiesDetailController.h"

@implementation ShufflingImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createSubViewsWithModel:(HomeListModel *)myHomeListModel{
    self.homeListModel = myHomeListModel;
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@", [GlobalRequest getBaseServiceUrl], self.homeListModel.activityPic];
    [self setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.userInteractionEnabled = YES;
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, self.bottom - 30, self.width-20*2, 20)];
    title.text = self.homeListModel.activityTitle;
    title.font = [UIFont systemFontOfSize:14];
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    [self addSubview:title];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)tapClicked:(UITapGestureRecognizer *)gesture{
    ActivitiesDetailController *activitiesDetailVC = [[ActivitiesDetailController alloc] initWithActivityType:TypeNone withID:self.homeListModel.activityId];
    activitiesDetailVC.navigationItem.title = @"活动详情";
    [activitiesDetailVC setHidesBottomBarWhenPushed:YES];
    [selected_navigation_controller() pushViewController:activitiesDetailVC animated:YES];
}

@end
