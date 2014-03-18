//
//  OrderDetailViewController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-12.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderGoodView.h"

@interface OrderDetailViewController ()

@property (nonatomic, strong) NSMutableArray *goodsArray;

@end

@implementation OrderDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.goodsArray = [NSMutableArray arrayWithObjects:[NSNull null], [NSNull null], [NSNull null], [NSNull null], nil];
    [self createUI];
    self.bottomView.top = 150+self.goodsArray.count*70;
    self.baseScrollView.contentSize = CGSizeMake(320, 140+self.goodsArray.count*70+260);
    
    self.navigationItem.title = @"订单详情";
}


- (void)createUI{
    for (int i = 0; i < [self.goodsArray count]; i++) {
        OrderGoodView *orderView = [[OrderGoodView alloc] initWithFrame:CGRectMake(10, 140+70*i, 300, 70)];
        orderView.image = [UIImage imageNamed:(i==0)?@"input_Top.png":((i==self.goodsArray.count-1)?@"input_Under.png":@"input_Middle.png")];
        [self.baseScrollView addSubview:orderView];
    }
}


//返回购物车点击
- (IBAction)backShoppingCartClicked:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
