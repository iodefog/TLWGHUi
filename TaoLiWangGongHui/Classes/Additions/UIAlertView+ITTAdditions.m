//
//  UIAlertView+ITTAdditions.m
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "UIAlertView+ITTAdditions.h"

@implementation UIAlertView (ITTAdditions)

+ (void) popupAlertByDelegate:(id)delegate andTag:(int)tag title:(NSString *)title message:(NSString *)msg {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:delegate
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil];
    alert.tag = tag;
    [alert show];
}

+ (void) popupAlertByDelegate:(id)delegate andTag:(int)tag title:(NSString *)title message:(NSString *)msg cancel:(NSString *)cancel others:(NSString *)others, ...{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:delegate
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:others, nil];
    alert.tag = tag;
    [alert show];
}

@end
