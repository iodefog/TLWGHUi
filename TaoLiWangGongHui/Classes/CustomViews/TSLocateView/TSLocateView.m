//
//  UICityPicker.m
//  DDMates
//
//  Created by ShawnMa on 12/16/11.
//  Copyright (c) 2011 TelenavSoftware, Inc. All rights reserved.
//

#import "TSLocateView.h"
#import "AddDocumentPathFile.h"
#define kDuration 0.3

@implementation TSLocateView

@synthesize titleLabel;
@synthesize locatePicker;
@synthesize locate;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"TSLocateView" owner:self options:nil] objectAtIndex:0];
    if (self = [super init]) {
        self.delegate = delegate;
        self.titleLabel.text = title;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        //加载数据
//        provinces = [[NSArray alloc] initWithContentsOfFile:[AddDocumentPathFile AddFileName:@"test02.plist" andType:@"plist"]];
//        cities = [[provinces objectAtIndex:0] objectForKey:@"Cities"];
        
       
    }
    return self;
}

- (void)setObjectWithProvince:(NSArray *)myprovinces withCity:(NSArray *)mycities{
    //初始化默认数据
    provinces = myprovinces;
    cities = mycities;
    self.locate = [[TSLocation alloc] init];
    self.locate.dm = [[provinces objectAtIndex:0] objectForKey:@"dm"];
    self.locate.mc = [[provinces objectAtIndex:0] objectForKey:@"mc"];
    self.locate.dm01 = [[cities objectAtIndex:0] objectForKey:@"dm"];
    self.locate.mc01 = [[cities objectAtIndex:0] objectForKey:@"mc"];
}

- (void)showInView:(UIView *) view
{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [self setAlpha:1.0f];
    [self.layer addAnimation:animation forKey:@"DDLocateView"];
    
    self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    
    [view addSubview:self];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[provinces objectAtIndex:row] objectForKey:@"mc"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"mc"];
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            cities = [[provinces objectAtIndex:row] objectForKey:@"Cities"];
            [self.locatePicker selectRow:0 inComponent:1 animated:NO];
            [self.locatePicker reloadComponent:1];
            
            self.locate.mc = [[provinces objectAtIndex:row] objectForKey:@"mc"];
            self.locate.mc01 = [[cities objectAtIndex:0] objectForKey:@"mc"];
            self.locate.dm = [[provinces objectAtIndex:row] objectForKey:@"dm"];
            self.locate.dm01 = [[cities objectAtIndex:0] objectForKey:@"dm"];
            break;
        case 1:
            self.locate.dm01 = [[cities objectAtIndex:row] objectForKey:@"dm"];
            self.locate.mc01 = [[cities objectAtIndex:row] objectForKey:@"mc"];
            break;
        default:
            break;
    }
}


#pragma mark - Button lifecycle

- (IBAction)cancel:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:0];
    }
}

- (IBAction)locate:(id)sender {
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [self setAlpha:0.0f];
    [self.layer addAnimation:animation forKey:@"TSLocateView"];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:kDuration];
    if(self.delegate) {
        [self.delegate actionSheet:self clickedButtonAtIndex:1];
    }
    
}

@end
