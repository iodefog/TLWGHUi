//
//  ShoppingCartController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#define ExampleCellCount 4

#import "ShoppingCartController.h"
#import "ShoppingCartCell.h"
#import "UIKeyboardCoView.h"
#import "GoodsListModel.h"
#import "GoodsDetailDataBase.h"
#import "GoodsListModel.h"

@interface ShoppingCartController () <ShoppingDelegate>{
    BOOL showDeleteButton;
}

@end

@implementation ShoppingCartController
@synthesize shoppingCartTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.model removeAllObjects];
    [self getRequestShoppingCartData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // 初始化表
    self.shoppingCartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height - 49) style:UITableViewStylePlain];
    self.shoppingCartTableView.delegate = self;
    self.shoppingCartTableView.dataSource = self;
    self.shoppingCartTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.shoppingCartTableView];
    
    // UIKeyBoardCoView
    UIKeyboardCoView *keyBoardCoView = [[UIKeyboardCoView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height , 320, 35)];
    keyBoardCoView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:keyBoardCoView];
   
    UIButton *finishButton = [UIButton buttonWithFrame:CGRectMake(270, 0, 40, keyBoardCoView.height) title:@"完成" titleColor:[UIColor blackColor] titleHighlightColor:nil titleFont: [UIFont systemFontOfSize:16] image:nil tappedImage:nil target:self action:@selector(finishButtonClicked:) tag:100];
    [keyBoardCoView addSubview:finishButton];
    
    UIView *tempView = [[UIView alloc] init];
    [self.shoppingCartTableView setTableFooterView:tempView];
    
     self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"编辑" image:nil target:self action:@selector(editClicked:) font:[UIFont systemFontOfSize:14.0f] titleColor:[UIColor whiteColor]];
}

- (void)getRequestShoppingCartData{
    NSArray *dbArray = [[GoodsDetailDataBase shareDataBase] readTableName];
    NSMutableArray *idsArray = [NSMutableArray array];
    for (GoodsListModel *model in dbArray) {
        [idsArray addObject:model.productId];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:idsArray options:NSJSONWritingPrettyPrinted error:nil];
    // 请求数据
    NSDictionary *params = @{@"json":[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding],
                             @"pageNo":@"0",
                             @"pageSize":PAGESIZE
                             };
    [self commitRequestWithParams:params withUrl:[GlobalRequest productAction_QueryProductListByIds_Url]];
}

- (void)editClicked:(UIButton *)sender{
    [sender setTitle:@"完成" forState:UIControlStateSelected];
    sender.selected = !sender.selected;
    showDeleteButton = sender.selected;
    [self.shoppingCartTableView reloadData];
//    self.shoppingCartTableView.editing = !self.shoppingCartTableView.editing;
}

- (void)finishButtonClicked:(UIButton *)sender{
    [currentTextField resignFirstResponder];
}

#pragma mark - TableView method
- (ShoppingCartCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    // 多一个cell，当 indexpath.section == tableview的组数时 创建那个cell
    if (indexPath.row == [self.model count] ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *payMentBtn = [UIButton createButton:@selector(toPayment:) title:@"去结算" image:nil selectedBgImage:@"login_Select.png"  backGroundImage:@"login_Nomal.png"  backGroundTapeImage:nil frame:CGRectMake(10, 20, 300, 36) tag:100 target:self];
        [payMentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:payMentBtn];
    }else{
        static NSString *cellName = @"cellName";
        cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ShoppingCartCell" owner:nil options:nil] lastObject];
        }
        ShoppingCartCell *shoppingCell =  (id)cell;
        [shoppingCell showDeleteButton:showDeleteButton];
        shoppingCell.GoodQuantity.tag = 200+indexPath.row;
        shoppingCell.shoppingDelegate = self;
        [shoppingCell setObjectWithIndex:indexPath withData:self.model[indexPath.row]];

    }
    
    return (id)cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 多一个cell， 给结算按钮留位置
    return [self.model count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"总计：1768元";
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if ([currentTextField isFirstResponder]) {
//        [currentTextField resignFirstResponder];
//    }
//}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([currentTextField isFirstResponder]) {
        [currentTextField resignFirstResponder];
    }
}

#pragma mark - Class Method
- (void)toPayment:(id)sender{

}

#pragma mark - ShoppingDelegate
- (void)responseWithIndex:(NSIndexPath *)index withData:(id)data{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.model];
    [tempArray removeObject:data];
    self.model = tempArray;
    
    [self.shoppingCartTableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationRight];
    [self reloadNewData];
}

static UITextField *currentTextField = nil;
#pragma mark - RFNumberKeyBoard  数字键盘上横条加按钮
- (void)shoppingTextFieldDidBeginEditing:(UITextField *)textField{
    self.shoppingCartTableView.height = [UIScreen mainScreen].bounds.size.height - 49 - 218;
    
    currentTextField = textField;
}

- (void)shoppingTextFieldDidEndEditing:(UITextField *)textField{
    self.shoppingCartTableView.height = [UIScreen mainScreen].bounds.size.height - 49 ;
    
}

#pragma mark - Response Mothod
- (void)reloadNewData{
    UIImageView *emptyView = (id)[self.view viewWithTag:101];
    
    if ([self.model count ] < 1) {
        if (!emptyView.superview) {
            if (!emptyView) {
                emptyView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 76)];
                emptyView.center = CGPointMake(self.view.centerX, self.view.centerY - 30);
                emptyView.image = [UIImage imageNamed:@"shopping_empty.png"];
            }
            emptyView.tag = 101;
            emptyView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [self.view addSubview:emptyView];
        }
    }else{
        [emptyView removeFromSuperview];
    }
    [self.shoppingCartTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
