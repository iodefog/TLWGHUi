//
//  ShoppingCartController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-2-28.
//  Copyright (c) 2014年 Mac OS X. All rights reserved.
//

#define ExampleCellCount 4

#import "ShoppingCartController.h"
#import "CashConfirmViewController.h"
#import "ShoppingCartCell.h"
#import "UIKeyboardCoView.h"
#import "GoodsListModel.h"
#import "GoodsDetailDataBase.h"
#import "GoodsListModel.h"
#import "EmptyView.h"

@interface ShoppingCartController () <ShoppingDelegate>{
    BOOL showDeleteButton;
    
    UILabel *headTitle;
    CGFloat allSum;
    
    UIKeyboardCoView *keyBoardCoView;
    
    EmptyView *emptyView;
}

@end

@implementation ShoppingCartController
//@synthesize shoppingCartTableView;

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
    NSArray *dbArray = [[GoodsDetailDataBase shareDataBase] readTableName];
    if (([dbArray count] != [self.model count])) {
        [self.model removeAllObjects];
        [self getRequestShoppingCartData];
    }
    if (keyBoardCoView) {
        [keyBoardCoView keyboardCoViewCommonInit];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [currentTextField resignFirstResponder];
    [keyBoardCoView keyboardCoViewRemoveObserver];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (isIOS7) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, self.view.width, self.view.height - 20 - 40) style:UITableViewStylePlain];
    }else{
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 36, self.view.width, self.view.height - 64 - 36) style:UITableViewStylePlain];
    }
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    [self.view addSubview:[self createHeadView]];
    
    if (!self.model) {
        [self getRequestShoppingCartData];
    }
    
    // UIKeyBoardCoView
    keyBoardCoView = [[UIKeyboardCoView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height , 320, 36)];
    keyBoardCoView.backgroundColor = [UIColor lightGrayColor];
    [[[UIApplication sharedApplication].windows firstObject] addSubview:keyBoardCoView];
   
    UIButton *finishButton = [UIButton buttonWithFrame:CGRectMake(270, 0, 40, keyBoardCoView.height) title:@"完成" titleColor:[UIColor blackColor] titleHighlightColor:nil titleFont: [UIFont systemFontOfSize:16] image:nil tappedImage:nil target:self action:@selector(finishButtonClicked:) tag:100];
    [keyBoardCoView addSubview:finishButton];
    
    UIView *tempView = [[UIView alloc] init];
    [self.tableView setTableFooterView:tempView];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"编辑" image:nil target:self action:@selector(editClicked:) font:[UIFont systemFontOfSize:14.0f] titleColor:[UIColor whiteColor] withRightBarItem:YES];
    self.navigationItem.leftBarButtonItem = nil;
//    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonWithTitle:@"结算" image:nil target:self action:@selector(toPaymentClicked:) font:[UIFont systemFontOfSize:14.0f] titleColor:[UIColor whiteColor]];
}

- (UIView *)createHeadView{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shopping_header.png"]];
    imageView.frame = CGRectMake(0, 0, self.tableView.width, 36);
    headTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.tableView.width-20, 36)];
    headTitle.backgroundColor = [UIColor clearColor];
    headTitle.font = [UIFont systemFontOfSize:13.f];
    headTitle.textColor = [UIColor colorWithHex:0x595450];
    headTitle.text = [NSString stringWithFormat:@"总计：%.2f元",allSum];
    [imageView addSubview:headTitle];
    return imageView;
}


#pragma mark - Class Method

- (void)getRequestShoppingCartData{
    NSArray *dbArray = [[GoodsDetailDataBase shareDataBase] readTableName];
    if ([dbArray count] == 0) {
        [self reloadNewData];
        [self checkShoppingData];
        return;
    }
    else if ([dbArray count] == [self.model count]) { // 避免每次刷新
        return;
    }else{ // 移除所有数据，避免重复显示
        [self.model removeAllObjects];
    }
    
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

static UIButton *leftButton = nil;

- (void)editClicked:(UIButton *)sender{
    if ([self.model count]<1) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"请先添加商品，才能编辑哦~" withTag:0];
        return;
    }
    leftButton = sender;
    [sender setTitle:@"完成" forState:UIControlStateSelected];
    sender.selected = !sender.selected;
    showDeleteButton = sender.selected;
    [self.tableView reloadData];
//    self.shoppingCartTableView.editing = !self.shoppingCartTableView.editing;
}

- (void)finishButtonClicked:(UIButton *)sender{
    if ([currentTextField isFirstResponder]) {
        [currentTextField resignFirstResponder];
    }
}


- (void)toPaymentClicked:(id)sender{
    if ([leftButton isSelected]) {
        [self editClicked:leftButton];
    }
    if ([self.model count] == 0) {
        [GlobalHelper handerResultWithDelegate:self withMessage:@"请先选择货物" withTag:0];
       
        return;
    }
    
    CashConfirmViewController *cashConfirmVC = [[CashConfirmViewController alloc] init];
    [cashConfirmVC setHidesBottomBarWhenPushed:YES];
    allSum = [self sumAllGoodsPrice];
    cashConfirmVC.goodsSumPrice = allSum;
    [cashConfirmVC shoppingPriceWithShow:YES];
    [self.navigationController pushViewController:cashConfirmVC animated:YES];
}

#pragma mark - TableView method
- (ShoppingCartCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = nil;
    // 多一个cell，当 indexpath.section == tableview的组数时 创建那个cell
    if (indexPath.row == [self.model count] ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *payMentBtn = [UIButton createButton:@selector(toPaymentClicked:) title:@"支付宝支付" image:nil selectedBgImage:@"login_Select.png"  backGroundImage:@"login_Nomal.png"  backGroundTapeImage:nil frame:CGRectMake(10, 20, 300, 36) tag:100 target:self];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 多一个cell， 给结算按钮留位置
    NSInteger cellCount = 0;
    if ([self.model count]>0) {
        cellCount = [self.model count]+1;
    }else{
        cellCount = [self.model count];
    }
    return cellCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99.;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    headView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 35)];
//    headView.textColor = [UIColor grayColor];
//    headView.backgroundColor = [UIColor colorWithHex:0xfaf7f3];
//    headView.text = [NSString stringWithFormat:@"总计：%.2f元",allSum];
//    return headView;
//}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self.model count] ) {
        
    }else{
        ShoppingCartCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
        [cell whenCellDidSelected];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([currentTextField isFirstResponder]) {
        [currentTextField resignFirstResponder];
    }
}

#pragma mark - ShoppingDelegate
- (void)responseWithIndex:(NSIndexPath *)index withData:(id)data{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.model];
    [tempArray removeObject:data];
    self.model = tempArray;
    if ([self.model count] >= 1) {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationRight];
    }else{
        NSLog(@"%@",self.navigationItem.rightBarButtonItem.customView);
        UIButton *button = (id)self.navigationItem.rightBarButtonItem.customView;
        button.selected = !button.selected;
        showDeleteButton = button.selected;
    }
    [self reloadNewData];
}

- (void)reduceGoodsQuantityWithPrice:(float)price{
    allSum -= price;
    headTitle.text = [NSString stringWithFormat:@"总计：%.2f元",allSum];
}

- (void)increaseGoodsQuantityWithPrice:(float)price{
    allSum += price;
    headTitle.text = [NSString stringWithFormat:@"总计：%.2f元",allSum];
}

static UITextField *currentTextField = nil;
#pragma mark - RFNumberKeyBoard  数字键盘上横条加按钮
- (void)shoppingTextFieldDidBeginEditing:(UITextField *)textField{
    self.tableView.height = [UIScreen mainScreen].bounds.size.height - 49 - 218 - 36;
    
    currentTextField = textField;
}

- (void)shoppingTextFieldDidEndEditing:(UITextField *)textField{
    self.tableView.height = [UIScreen mainScreen].bounds.size.height - 64 ;
    allSum = [self sumAllGoodsPrice];
    headTitle.text = [NSString stringWithFormat:@"总计：%.2f元",allSum];
}

#pragma mark - Response Mothod

- (UIImage *)emptyImage{
    return nil;
}

- (NSString *)emptyTitle{
    return nil;
}

- (NSString *)emptySubTitle{
    return nil;
}

- (void)reloadNewData{
    if ([self.model count ] < 1) {
        [super showEmptyView];
    }else{
        [super hideEmptyView];
    }
    allSum = [self sumAllGoodsPrice];
    [self checkShoppingData];
    headTitle.text = [NSString stringWithFormat:@"总计：%.2f元",allSum];
    [self.tableView reloadData];
}

- (float)sumAllGoodsPrice{
    CGFloat sum = 0;
    for(NSDictionary *dict in self.model){
        NSString *productId = dict[@"productId"];
        NSString *productQuality = [[GoodsDetailDataBase shareDataBase]readTableQualityWithProductID:productId];
       NSLog(@"************* %@", productQuality);
        float tempPrice = ((NSNumber *)dict[@"costPrice"]).floatValue;
        sum += tempPrice * (productQuality?productQuality.intValue:1);
    }
    return sum;
}

#pragma mark -- response
- (void)setDataDic:(NSDictionary *)resultDic withRequest:(id)request{
    [self.model removeAllObjects];
    [super setDataDic:resultDic withRequest:request];
    
    for (NSDictionary *dict in self.model) {
        GoodsListModel *goodsListModel = [[GoodsListModel alloc] initWithDataDic:dict];
        [[GoodsDetailDataBase shareDataBase] updateItem:goodsListModel];
    }
    [self checkShoppingData];
}

- (void)checkShoppingData{
    
    if ([self.model count] == 0 || !self.model) {
        if (!emptyView) {
            emptyView = [[EmptyView alloc] initWithFrame:self.view.bounds];
            emptyView.imageView.image = [UIImage imageNamed:@"shopping_empty.png"];
            emptyView.titleLabel.text = @"购物车空空如也，快去逛逛吧~";
        }
        if (!emptyView.superview) {
            [self.view addSubview:emptyView];
        }
    }else{
        [emptyView removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
