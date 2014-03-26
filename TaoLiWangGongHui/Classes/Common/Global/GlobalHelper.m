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

static GlobalHelper *helper = nil;

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

+ (id)shareInstance{
    if (!helper) {
        helper = [[GlobalHelper alloc] init];
    }
    return helper;
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

+ (void)handerResultWithDelegate:(id)delegate withMessage:(NSString *)message withTag:(int)tag{
    if ([message isKindOfClass:[NSString class]]) {
        [GlobalHelper showWithTitle:@"提示" withMessage:message withCancelTitle:@"确定" withOkTitle:nil withSelector:nil withTarget:delegate];
//        [UIAlertView popupAlertByDelegate:delegate andTag:tag title:@"提示" message:message];
    }else if([message isKindOfClass:[NSString class]]){
        [GlobalHelper showWithTitle:@"提示" withMessage:@"获取信息失败" withCancelTitle:@"确定" withOkTitle:nil withSelector:nil withTarget:delegate];
//        [UIAlertView popupAlertByDelegate:delegate andTag:tag title:@"提示" message:@"获取信息失败"];
    }
}

// 自定义AlertView
+ (void)showWithTitle:(NSString *)title withMessage:(NSString *)message withCancelTitle:(NSString *)cancelTitle withOkTitle:(NSString *)okTitle withSelector:(SEL)selector withTarget:(id)target{
    helper = [GlobalHelper shareInstance];
    helper.helperDelegate = target;
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
                                  if (helper.helperDelegate && [helper.helperDelegate respondsToSelector:selector]) {
                                      SuppressPerformSelectorLeakWarning([helper.helperDelegate performSelector:selector withObject:nil]);
                                  }
                              }];
    }
    
    alertView.titleColor = [UIColor blackColor];
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
