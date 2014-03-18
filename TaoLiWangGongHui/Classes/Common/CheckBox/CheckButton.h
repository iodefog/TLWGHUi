//
//  CheckButton.h
//  CheckBox
//
//  Created by apple on 14-3-7.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CheckButtonStyleDefault = 0 ,
    CheckButtonStyleBox = 1 ,
    CheckButtonStyleRadio = 2
} CheckButtonStyle;

@interface CheckButton : UIControl{
    //UIControl* control;
    UILabel * label ;
    UIImageView * icon ;
    BOOL checked ;
    id value , delegate ;
    CheckButtonStyle style ;
    NSString * checkname ,* uncheckname ; // 勾选／反选时的图片文件名
}
@property ( retain , nonatomic ) id value,delegate;
@property ( retain , nonatomic )UILabel* label;
@property ( retain , nonatomic )UIImageView* icon;
@property ( assign )CheckButtonStyle style;
@property (assign) BOOL checked;
- (CheckButtonStyle)style;
- (void)setStyle:(CheckButtonStyle)st;
- (BOOL)isChecked;
//- (void)setChecked:(BOOL)b;

@end
