//
//  BaseViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-27.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import "BaseViewController.h"
//#import "HomeController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//

- (id)viewControllerWithTabTitle:(NSString*) title image:(UIImage*)image finishedSelectedImage:(UIImage*)finishedSelectedImage viewClass:(NSString*)viewClass
{
    Class viewControllerClass = NSClassFromString(viewClass);
    UIViewController* viewController = [[viewControllerClass alloc] init];
    viewController.title = title;
    [viewController.tabBarItem setFinishedSelectedImage:finishedSelectedImage withFinishedUnselectedImage:image];
    [viewController.tabBarItem setTitle:nil];
    [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor colorWithRed:1. green:102./225. blue:0 alpha:1.] forKey:UITextAttributeTextColor];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    return navigationController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tabBarController.delegate = self;
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"首页" image:[UIImage imageNamed:@"home"] finishedSelectedImage:[UIImage imageNamed:@"home_tap"] viewClass:@"HomeViewController"],
                            [self viewControllerWithTabTitle:@"购物车" image:[UIImage imageNamed:@"shopping_cart"]  finishedSelectedImage:[UIImage imageNamed:@"shopping_cart_tap"] viewClass:@"ShoppingCartController"],
                            [self viewControllerWithTabTitle:@"推送消息" image:[UIImage imageNamed:@"message"] finishedSelectedImage:[UIImage imageNamed:@"message_tap.png"]  viewClass:@"MessageController"],
                            [self viewControllerWithTabTitle:@"工会活动" image:[UIImage imageNamed:@"activities"] finishedSelectedImage:[UIImage imageNamed:@"activities_tap"]  viewClass:@"ActivitiesController"],
                            [self viewControllerWithTabTitle:@"个人中心" image:[UIImage imageNamed:@"person.png"] finishedSelectedImage:[UIImage imageNamed:@"person_tap.png"]  viewClass:@"PersonController"],
                            nil];
    [self setSelectedViewController:self.viewControllers[0]];

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
//    if (!viewController) {
//        NSArray *controllerArray = [NSArray arrayWithObjects:@"HomeViewController",@"ShoppingCartController", @"MessageController", @"TeamController", @"PersonController", nil];
//    self.tabBarController.
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
