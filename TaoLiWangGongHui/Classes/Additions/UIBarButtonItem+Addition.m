//
//  UIBarButtonItemAddition.m
//  lebo
//
//  Created by yong wang on 13-3-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"
@implementation UIBarButtonItem (Addition)

+ (UIBarButtonItem*)barButtonWithTitle:(NSString *)title image:(NSString*)imageName target:(id)target action:(SEL)action font:(UIFont *)font titleColor:(UIColor *)titleColor withRightBarItem:(BOOL)right
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 29)];

    if(title)
    {
        [button setFrame:CGRectMake(0, 2, 60, 40)];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:font];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        if (right) {
            if (title.length <= 2) {
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 21, 0, -21)];
            }
        }else{
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
        }
        //[button.titleLabel setShadowColor:[UIColor blackColor]];
        //[button.titleLabel setShadowOffset:CGSizeMake(0, -1)];
        [button.titleLabel setTextColor:titleColor];
//        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    else
    {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_tape",imageName]] forState:UIControlStateHighlighted];
        [button setFrame:CGRectMake(0, 0, 60, 32)];
        
    }

    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

+ (UIBarButtonItem*)barButtonWithImage:(NSString *)imageName backgroundImage:(NSString*)backgroundImage target:(id)target action:(SEL)action withRightBarItem:(BOOL)right
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 30)];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (!right && isIOS7) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 14)];
    }else{
    
    }
    [button setBackgroundImage:[UIImage imageNamed:backgroundImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_tape",backgroundImage]] forState:UIControlStateHighlighted];
    if (target && action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

@end


