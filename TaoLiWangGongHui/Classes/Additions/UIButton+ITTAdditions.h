//
//  UIButton+ITTAdditions.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ITTAdditions)

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title 
                   titleColor:(UIColor *)titleColor
          titleHighlightColor:(UIColor *)titleHighlightColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)imageName
                  tappedImage:(UIImage *)tappedImageName
                       target:(id)target 
                       action:(SEL)selector 
                          tag:(NSInteger)tag;

#pragma mark - 创建控件
// 创建button
+ (UIButton*)createButton:(SEL)selector title:(NSString*)title image:(NSString*)image selectedBgImage:(NSString *)selectedbgImage backGroundImage:(NSString*)backGroundImage backGroundTapeImage:(NSString*)backGroundTapeImage frame:(CGRect)frame tag:(int)tag target:(id)target;

//创建功能全的按钮
+ (UIButton*)createButtonWithSelector:(SEL)selector title:(NSString*)title selectedTitle:(NSString *)selectedTitle titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor font:(UIFont *)font image:(NSString*)image selectedImage:(NSString *)selectedImage selectedBgImage:(NSString *)selectedbgImage backGroundImage:(NSString*)backGroundImage backGroundTapeImage:(NSString*)backGroundTapeImage frame:(CGRect)frame tag:(int)tag target:(id)target withTitleEdge:(UIEdgeInsets)titleEdge withImageEdge:(UIEdgeInsets)imageEdge;

@end
