//
//  EmptyView.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-4-11.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}


- (void)createUI{
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, 100, 76)];
    self.imageView.centerX = self.centerX;
    [self addSubview:self.imageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageView.bottom, self.width, 40)];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:self.titleLabel];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
