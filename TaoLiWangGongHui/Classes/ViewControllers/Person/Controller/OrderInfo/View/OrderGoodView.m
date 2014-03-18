//
//  OrderGoodView.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "OrderGoodView.h"

@implementation OrderGoodView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createUI];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)createUI{
    self.goodHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 45, 45)];
    self.goodHeadView.backgroundColor = [UIColor grayColor];
    
    self.goodTitle = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 26)];
    self.goodTitle.text = @"爱丽尚法乡村手工艺将军金甲夜不脱";
    self.goodTitle.font = [UIFont systemFontOfSize:14];
    self.goodTitle.textColor = [UIColor blackColor];
    
    self.goodPrice = [[UILabel alloc] initWithFrame:CGRectMake(73, 40, 103, 21)];
    self.goodPrice.text = @"10000.0元";
    self.goodQuantity = [[UILabel alloc] initWithFrame:CGRectMake(228, 40, 60, 20)];
    self.goodPrice.font = self.goodQuantity.font = [UIFont systemFontOfSize:12.0f];
    self.goodQuantity.text = @"x1000";
    self.goodPrice.textColor = self.goodQuantity.textColor = [UIColor darkGrayColor];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 25, 9, 16)];
    rightImageView.image = [UIImage imageNamed:@"arrow_right.png"];
    
    UIButton *coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    coverButton.frame = self.bounds;
    [coverButton addTarget:self action:@selector(coverButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.goodHeadView];
    [self addSubview:self.goodTitle];
    [self addSubview:self.goodPrice];
    [self addSubview:self.goodQuantity];
    [self addSubview:rightImageView];
    [self addSubview:coverButton];
}

- (void)coverButtonClicked:(UIButton *)sender{

}

@end
