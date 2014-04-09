//
//  WelfareController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WelfareBirthDay,
    WelfareHoliday
} WelfareType;

@interface WelfareController : TableViewController

@property (nonatomic, assign) WelfareType welfareType;

- (id)initWithWelfareType:(WelfareType)myWelfareType;


@end
