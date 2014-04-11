//
//  ShoppingCartController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartController : ViewController <UIScrollViewDelegate ,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;  // 购物车

@end
