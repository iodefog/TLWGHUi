//
//  GloablHelper.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GlobalHelper.h"

@implementation GlobalHelper

UINavigationController *selected_navigation_controller()
{
    NSLog(@"%@", [UIApplication sharedApplication].keyWindow);
    NSLog(@"%@", [UIApplication sharedApplication].keyWindow.rootViewController);
    if (![[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        return nil;
    }
    
    if((UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController.presentedViewController)
        return (UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController.modalViewController;
    else
        return  (UINavigationController *)((UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController).selectedViewController;
}
// 检查邮箱是否格式正确
+ (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

// 检查手机号码格式正确
+ (BOOL)isValidatePhone:(NSString *)phone{
    NSString *phoneRegex = @"1\\d{10}";
    NSPredicate *PhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",phoneRegex];
    return [PhoneTest evaluateWithObject:phone];
}

// 检查邮编格式正确
+ (BOOL)isValidateZipCode:(NSString *)zipCode{
    NSString *zipRegex = @"[1-9]\\d{5}";
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",zipRegex];
    return [zipCodeTest evaluateWithObject:zipCode];
}

@end
