//
//  ShoppingCartController.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartController : ViewController <UITableViewDataSource, UITableViewDelegate ,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView * shoppingCartTableView;  // 购物车

@end
