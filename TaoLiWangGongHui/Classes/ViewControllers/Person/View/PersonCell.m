//
//  PersonCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-4.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "PersonCell.h"

@implementation PersonCell
@synthesize customImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}

- (void)createUI{
       customImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, self.height)];
        customImage.tag = 101;
        [self addSubview:customImage];
        [self sendSubviewToBack:customImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
