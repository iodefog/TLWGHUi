//
//  GoodsInfoController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GoodsInfoController.h"
#import "WelfareConfirmViewController.h"
#import "CashConfirmViewController.h"
#import "GoodsInfoModel.h"
#import "GoodsDetailDataBase.h"
//
@interface GoodsInfoController ()
/**
 *  UIScrollView上的控件
 */
@property (weak, nonatomic) IBOutlet UIScrollView    *ShowImageScrollView;
@property (weak, nonatomic) IBOutlet UILabel         *ShowImageNumberLable;
// 购买或加入购物车按钮
@property (strong, nonatomic) IBOutlet UIButton     *PayOrJoinCartBtn;
@property (nonatomic, assign) int                    ImageCount;
/**
 *  商品名称
 */
@property (weak, nonatomic) IBOutlet UILabel         *GoodsNewPriceLable;
@property (weak, nonatomic) IBOutlet UILabel         *GoodsNameLable;
@property (weak, nonatomic) IBOutlet UILabel         *GoodsOldPriceLable;
@property (weak, nonatomic) IBOutlet UIScrollView    *ContentScrollView;

/**
 *  商品图解
 */
@property (weak, nonatomic) IBOutlet UIWebView        *GoodsTitleWebView;
@property (nonatomic, strong)GoodsInfoModel         *goodsInfoModel;
@end

@implementation GoodsInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ImageCount = 0;
    }
    return self;
}
/**
 *  数据请求
 *
 *  @param void 需要传的参数
 *
 *  @return void
 */
#pragma mark -
#pragma mark StartRequest
-(void)startGoodsDetailRequest{
    [self commitRequestWithParams:@{
                                    @"memberId": [[UserHelper shareInstance] getMemberID],
                                    @"productId": self.productID
                                    } withUrl:
     [GlobalRequest productAction_QueryProducInfo_Url]];
}


- (void)reloadNewData{
    if ([self.model isKindOfClass:[NSDictionary class]]) {
        self.goodsInfoModel = [[GoodsInfoModel alloc] initWithDataDic:self.model];
    }
    if ((self.goodsInfoType==GoodsType_BirthDay) || (self.goodsInfoType==GoodsType_Holiday)) {
        [self.PayOrJoinCartBtn setTitle:@"立即领取" forState:UIControlStateNormal];
    }
    self.ShowImageNumberLable.text = [NSString stringWithFormat:@"1/%d",[self.goodsInfoModel.productPictures count]];
    self.GoodsNameLable.text = self.goodsInfoModel.productName;
    self.GoodsNewPriceLable.text = [NSString stringWithFormat:@"%@元",self.goodsInfoModel.costPrice];
      self.GoodsOldPriceLable.text = [NSString stringWithFormat:@"%@元",self.goodsInfoModel.basicPrice];
    
}


- (void)addImageArray:(NSArray *)imagesArray{
    for (NSString *imageUrl in imagesArray) {
        
    }
}

/**
 *  UI加载
 *
 *  @param void
 *
 *  @return void
 */
#pragma mark -
#pragma mark ViewDidLoad

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [GlobalHelper showCarViewInNavC:self.navigationController withVC:self];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [GlobalHelper hiddenCarView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"商品详情";
    [self startGoodsDetailRequest];
}

-(void)JoinCarButtonClick:(id)sender{
//    [SharedApp showViewController:HOME_VIEW_CONTROLLER andIndex:1];
}
#pragma mark -
#pragma mark UIScrollView
-(void)setHomeheadView:(GoodsInfoModel *)model
{
    /**
     *  图片展示
     */
    [_ShowImageScrollView setContentSize:CGSizeMake(320*[model.productPictures count], 167)];
    _ImageCount = [model.productPictures count];
    if ([model.productPictures count] == 0) {
        _ShowImageNumberLable.hidden = YES;
    }else{
        _ShowImageNumberLable.text = [NSString stringWithFormat:@"1/%d",[model.productPictures count]];
    }
    for (int i = 0; i < [model.productPictures count]; i++) {
        ITTImageView *ScroImageView = [[ITTImageView alloc]init];
        ScroImageView.contentMode = UIViewContentModeScaleAspectFit;
        [ScroImageView loadImage:[[model.productPictures objectAtIndex:i] objectForKey:@"tpmc"]];
        ScroImageView.frame = CGRectMake(i*320, 0, 320, 230);
        ScroImageView.userInteractionEnabled = YES;
        [_ShowImageScrollView addSubview:ScroImageView];
    }
}
-(void)setHomeMiddelView:(GoodsInfoModel *)model
{
    /**
     *  判断是积分还是现金商品
     */
    if (self.goodsInfoType == GoodsType_Discount) {
        _GoodsNewPriceLable.text = [NSString stringWithFormat:@"%@元",model.costPrice];
        _GoodsOldPriceLable.text = [NSString stringWithFormat:@"%@元",model.basicPrice];
        _GoodsNameLable.text = model.productName;
    }
    else {
        _GoodsNewPriceLable.text = [NSString stringWithFormat:@"%@积分",model.costPrice];
        _GoodsOldPriceLable.text = [NSString stringWithFormat:@"%@元",model.basicPrice];
        _GoodsNameLable.text = model.productName;
    }
    
    
}
-(void)setHomeSmallView:(GoodsInfoModel *)model
{
    /**
     *  把xml格式字符串写入test.html 在用webview 展示
     */
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [path objectAtIndex:0];
    NSString *htmlPath = [filePath stringByAppendingPathComponent:@"test.html"];
    [fm createFileAtPath:htmlPath contents:nil attributes:nil];
    [model.productDescribe writeToFile:htmlPath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    NSString *htmlstring=[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:NULL];
    [self.GoodsTitleWebView loadHTMLString:htmlstring baseURL:[NSURL fileURLWithPath:htmlPath]];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //顶部图片scrollview的delegate
    if (scrollView.tag == 1001) {
        int page = _ShowImageScrollView.contentOffset.x/320+1;
        _ShowImageNumberLable.text = [NSString stringWithFormat:@"%d/%d",page,_ImageCount];
    }
}


/**
 *  分享
 *
 *  @param IBAction void
 *
 *  @return void
 */
#pragma mark -
#pragma mark WeiBoShare
//- (IBAction)WeiboShareButtonClick:(id)sender {
//    ITTShareView *view = [[ITTShareView alloc]init];
//    view.delegate = self;
//    [view ShowShareView];
//}
//-(void)SinaShareBtnClick:(UIButton *)sender{
//    [ShareCommon SinaShare];
//}
//-(void)WeiXinShareBtnClick:(UIButton *)sender{
//    [ShareCommon WeixinShare];
//}
//-(void)QQSpaceShareBtnCLick:(UIButton *)sender{
//    [ShareCommon QQSpaceShare];
//}




/**
 *  加入购物车
 *
 *  @param IBAction Button
 *
 *  @return void
 */
#pragma mark -
#pragma mark CardsBuy
- (IBAction)InsertCardButtonClick:(id)sender {
    if ((self.goodsInfoType == GoodsType_BirthDay) || (self.goodsInfoType == GoodsType_Holiday)) {
        WelfareConfirmViewController *welfareConfirmVC = [[WelfareConfirmViewController alloc] initWithNibName:@"WelfareConfirmViewController" bundle:nil];
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:self.goodsListModel.previewPicPath]];
        welfareConfirmVC.goodPic = imageView.image;
        welfareConfirmVC.goodText = self.goodsListModel.productName;
        welfareConfirmVC.goodIDText = self.goodsListModel.productId;
        [selected_navigation_controller() pushViewController:welfareConfirmVC animated:YES];
    }else if (self.goodsInfoType == GoodsType_Discount){
//        CashConfirmViewController *cashConfirmVC = [[CashConfirmViewController alloc] initWithNibName:@"CashConfirmViewController" bundle:nil];
//        cashConfirmVC.goodsModel = self.goodsListModel;
//        [selected_navigation_controller() pushViewController:cashConfirmVC animated:YES];
        if ([[GoodsDetailDataBase shareDataBase] insertItem:self.goodsListModel]) {
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已加入购物车"];
        }else{
            [[TKAlertCenter defaultCenter] postAlertWithMessage:@"购物车里已存在"];
        }
        
        [GlobalHelper showCarViewInNavC:nil withVC:nil];
    }
}




/**
 *  webView的delegate
 *
 *  @param webView 所要显示的内容
 */
#pragma mark -
#pragma mark WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //图片缩放
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=320;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    //webView的高度
    NSString *string = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"];
    CGRect frame = [webView frame];
    frame.size.height = [string floatValue]+10;
    if (iPhone5) {
        _ContentScrollView.contentSize = CGSizeMake(320, frame.size.height+320);
        
    }else{
        _ContentScrollView.contentSize = CGSizeMake(320, frame.size.height+415);
    }
    [webView setFrame:frame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
