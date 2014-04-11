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
@synthesize delicateLifeTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    self.dailyLable = [[RTLabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];
//    self.dailyLable.text = @"2014-03-12";
    self.dailyLable.font = [UIFont systemFontOfSize:14.0];
    self.dailyLable.textColor = [UIColor lightGrayColor];
    [self.dailyLable setTextAlignment:RTTextAlignmentCenter];
    [self addSubview:self.dailyLable];
    
    self.timeLable = [[RTLabel alloc] initWithFrame:CGRectMake(200, self.dailyLable.top, 110, self.dailyLable.height)];
    self.timeLable.font = [UIFont systemFontOfSize:14.0f];
//    self.timeLable.text = @"8:00";
    self.timeLable.textColor = [UIColor lightGrayColor];
    [self.timeLable setTextAlignment:RTTextAlignmentRight];
    self.timeLable.backgroundColor = [UIColor clearColor];
    [self addSubview:self.timeLable];

    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.dailyLable.bottom -3 , self.dailyLable.width, 0)];
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
    
    self.delicateWebView = [[UIWebView alloc] initWithFrame:CGRectMake(20, 40, self.delicateLifeTitle.width, 40)];
    self.delicateWebView.backgroundColor = [UIColor clearColor];
    self.delicateWebView.opaque = NO;
    self.delicateWebView.userInteractionEnabled = NO;
    self.delicateWebView.delegate = self;
    [self addSubview:self.delicateWebView];
}
/*
 &nbsp;44sdfsfsdfdsf&nbsp:&nbsp:
 */
- (void)setObject:(NSDictionary *)dict{
    JokeListModel *model = [[JokeListModel alloc] initWithDataDic:dict];
    self.dailyLable.text = model.publishDatetime;
    self.delicateLifeTitle.text = model.activityTitle;
    if (![model.description isEqualToString:webStr]) {
        [self.delicateWebView loadHTMLString:model.description baseURL:nil];
        webStr = model.description;
    }
}

static float Height = 0.0f;

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *jsString = @"document.body.style.fontSize=14";
    [webView stringByEvaluatingJavaScriptFromString:jsString];
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    [webView setFrame:frame];
    
    self.frame = CGRectMake(self.left, self.top, self.width, 40+frame.size.height);
    Height =  40+frame.size.height;
    self.cellHeight = Height;
    self.bgImageView.height = Height;

    if (self.delegate && [self.delegate respondsToSelector:@selector(reloadTableViewWithCell:)]) {
        [self.delegate performSelector:@selector(reloadTableViewWithCell:) withObject:self];
    }
}

+ (CGFloat)getCellHeight:(NSDictionary *)dict{
//    NSLog(@"%.2f", ([DelicateLifeCell class]).height);
    return Height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
