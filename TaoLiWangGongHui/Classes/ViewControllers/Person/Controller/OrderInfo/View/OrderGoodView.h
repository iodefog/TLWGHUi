//
//  OrderGoodView.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderGoodView : UIImageView

@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;
@property (strong, nonatomic) IBOutlet UIImageView *goodHeadView;
@property (strong, nonatomic) IBOutlet UILabel *goodTitle;
@property (strong, nonatomic) IBOutlet UILabel *goodPrice;
@property (strong, nonatomic) IBOutlet UILabel *goodQuantity;

@end
