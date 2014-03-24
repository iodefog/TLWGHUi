//
//  GloablHelper.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GlobalHelper.h"
#import "SIAlertView.h"
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

+ (void)handerResultWithDelegate:(id)delegate withMessage:(NSString *)message{
    if ([message isKindOfClass:[NSString class]]) {
        [UIAlertView popupAlertByDelegate:delegate andTag:1001 title:@"提示" message:message];
    }else if([message isKindOfClass:[NSString class]]){
        [UIAlertView popupAlertByDelegate:delegate andTag:1001 title:@"提示" message:@"获取信息错误"];
    }
}

// 自定义AlertView
+ (void)showWithTitle:(NSString *)title withMessage:(NSString *)message withCancelTitle:(NSString *)cancelTitle withOkTitle:(NSString *)okTitle withSelector:(SEL)selector withTarget:(id)target{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    if (cancelTitle) {
        [alertView addButtonWithTitle:cancelTitle
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  
                              }];
    }
    if (okTitle) {
        [alertView addButtonWithTitle:okTitle
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  if ([target respondsToSelector:selector]) {
                                       [target performSelector:selector];
                                  }
                              }];
    }
    
    alertView.titleColor = [UIColor blueColor];
    alertView.messageColor = [UIColor blackColor];
    alertView.messageFont = [UIFont systemFontOfSize:14.0];
    alertView.cornerRadius = 10;
    //    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler2", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler2", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler2", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler2", alertView);
    };
    
    [alertView show];
}

@end
