//
//  UIButton+ITTAdditions.m
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "UIButton+ITTAdditions.h"

@implementation UIButton (ITTAdditions)

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title 
                   titleColor:(UIColor *)titleColor
          titleHighlightColor:(UIColor *)titleHighlightColor
                    titleFont:(UIFont *)titleFont
                        image:(UIImage *)image
                  tappedImage:(UIImage *)tappedImage
                       target:(id)target 
                       action:(SEL)selector 
                          tag:(NSInteger)tag{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = frame;
	if( title!=nil && title.length>0 ){
		[button setTitle:title forState:UIControlStateNormal];
		[button setTitleColor:titleColor forState:UIControlStateNormal];
		[button setTitleColor:titleHighlightColor forState:UIControlStateHighlighted];
		button.titleLabel.font = titleFont;
	}
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	button.tag = tag;
	if( image){
		[button setBackgroundImage:image forState:UIControlStateNormal];
	}
	if( tappedImage){
		[button setBackgroundImage:tappedImage forState:UIControlStateHighlighted];
	}
	
	return button;
}

#pragma mark - 创建控件
//创建按钮
+ (UIButton*)createButton:(SEL)selector title:(NSString*)title image:(NSString*)image selectedBgImage:(NSString *)selectedbgImage backGroundImage:(NSString*)backGroundImage backGroundTapeImage:(NSString*)backGroundTapeImage frame:(CGRect)frame tag:(int)tag target:(id)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backGroundImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedbgImage] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:selectedbgImage] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:143./255. green:143./255. blue:143./255. alpha:1.] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithHex:0xea804c] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//创建功能全的按钮
+ (UIButton*)createButtonWithSelector:(SEL)selector title:(NSString*)title selectedTitle:(NSString *)selectedTitle titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor font:(UIFont *)font image:(NSString*)image selectedImage:(NSString *)selectedImage selectedBgImage:(NSString *)selectedbgImage backGroundImage:(NSString*)backGroundImage backGroundTapeImage:(NSString*)backGroundTapeImage frame:(CGRect)frame tag:(int)tag target:(id)target withTitleEdge:(UIEdgeInsets)titleEdge withImageEdge:(UIEdgeInsets)imageEdge
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    [button setTag:tag];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateHighlighted];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:backGroundImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedbgImage] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:backGroundImage] forState:UIControlStateHighlighted];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateHighlighted];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    button.titleLabel.font = font;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleEdgeInsets:titleEdge];
    [button setImageEdgeInsets:imageEdge];
    return button;
}


@end
