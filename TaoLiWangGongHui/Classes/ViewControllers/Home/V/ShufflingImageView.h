//
//  ShufflingImageView.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

@interface ShufflingImageView : UIImageView // 轮播图

@property (nonatomic, strong) HomeListModel *homeListModel;

- (void)createSubViewsWithModel:(HomeListModel *)myHomeListModel;

@end
