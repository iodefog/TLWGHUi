//
//  DelicateLifeCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-3.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "DelicateLifeCell.h"
#import "JokeListModel.h"

@implementation DelicateLifeCell
@synthesize delicateLifeTitle, delicateLifeDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.dailyLable = [[RTLabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
    self.dailyLable.text = @"2014-03-12";
    self.dailyLable.font = [UIFont systemFontOfSize:14.0];
    self.dailyLable.textColor = [UIColor lightGrayColor];
    [self.dailyLable setTextAlignment:RTTextAlignmentCenter];
    [self addSubview:self.dailyLable];
    
    self.timeLable = [[RTLabel alloc] initWithFrame:CGRectMake(200, self.dailyLable.top, 110, self.dailyLable.height)];
    self.timeLable.font = [UIFont systemFontOfSize:14.0f];
    self.timeLable.text = @"8:00";
    self.timeLable.textColor = [UIColor lightGrayColor];
    [self.timeLable setTextAlignment:RTTextAlignmentRight];
    self.timeLable.backgroundColor = [UIColor clearColor];
    [self addSubview:self.timeLable];

    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.dailyLable.bottom , self.dailyLable.width, 134)];
    self.bgImageView.image = [UIImage imageNamed:@"joke_background.png"];
    self.bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgImageView];
    
    self.delicateLifeTitle = [[RTLabel alloc] initWithFrame:CGRectMake(20, self.timeLable.bottom, 280, 20)];
    self.delicateLifeTitle.font = [UIFont systemFontOfSize:14];
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.delicateLifeTitle];
    
    UIImageView *dividingView = [[UIImageView alloc] initWithFrame:CGRectMake(self.delicateLifeTitle.left, self.delicateLifeTitle.bottom - 3, self.delicateLifeTitle.width, 1)];
    dividingView.backgroundColor = RGBCOLOR(221, 215, 207);
    [self addSubview:dividingView];
    
    self.delicateLifeDescription = [[RTLabel alloc] initWithFrame:CGRectMake(20, 50, self.delicateLifeTitle.width, 40)];
    self.delicateLifeDescription.backgroundColor = [UIColor clearColor];
    self.delicateLifeDescription.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.delicateLifeDescription];
}

- (void)setObject:(NSDictionary *)dict{
    JokeListModel *model = [[JokeListModel alloc] initWithDataDic:dict];
    self.dailyLable.text = model.publishDatetime;
    self.delicateLifeTitle.text = model.activityTitle;
    self.delicateLifeDescription.text = model.description;
    self.delicateLifeTitle.height = self.delicateLifeTitle.optimumSize.height + 4;
    self.delicateLifeDescription.top = self.delicateLifeTitle.bottom;
    self.delicateLifeDescription.height = self.delicateLifeDescription.optimumSize.height + 5;
    self.bgImageView.height = self.delicateLifeDescription.height + self.delicateLifeTitle.height + 10;
}

+ (CGFloat)getCellHeight:(NSDictionary *)dict{
    CGFloat height = 0;
    RTLabel *tempLabel = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, 280, 0)];
    tempLabel.font = [UIFont systemFontOfSize:14];
    JokeListModel *model = [[JokeListModel alloc] initWithDataDic:dict];
    tempLabel.text = model.activityTitle;
    height = 10 + tempLabel.optimumSize.height;
    tempLabel.text = model.description;
    height += 10 + tempLabel.optimumSize.height ;
    return height + 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
