//
//  PopCarView.h
//  TaoliWang
//
//  Created by Mac OS X on 14-3-20.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "ITTXibView.h"

@protocol JoinCarDelegate <NSObject>
@optional
-(void)JoinCarButtonClick:(id)sender;

@end

@interface PopCarView : ITTXibView
@property (nonatomic, assign)id <JoinCarDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIImageView *numBgView;
@property (weak, nonatomic) IBOutlet UILabel *NumLable;
-(void)SetCarNumber;
@end
