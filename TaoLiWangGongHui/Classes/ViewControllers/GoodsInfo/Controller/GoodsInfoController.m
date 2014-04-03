//
//  GoodsInfoController.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-31.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "GoodsInfoController.h"
#import "GoodsInfoModel.h"
#import "PopCarView.h"
#import "GoodsListModel.h"

@interface GoodsInfoController ()<JoinCarDelegate>

@property (nonatomic, strong) GoodsListModel *goodsListModel;
/**
 *  UIScrollView上的控件
 */
@property (weak, nonatomic) IBOutlet UIScrollView    *ShowImageScrollView;
@property (weak, nonatomic) IBOutlet UILabel         *ShowImageNumberLable;
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
@property (nonatomic, strong)PopCarView             *Carview;
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
        self.goodsListModel = [[GoodsListModel alloc] initWithDataDic:self.model];
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self InitUI];
    [self startGoodsDetailRequest];
}
- (void)InitUI
{
    _GoodsTitleWebView.scrollView.scrollEnabled = NO;
    self.Carview = [[PopCarView alloc]init];
    if (isIOS7) {
        self.Carview.top = Screen_height - 50;
    }else{
        self.Carview.top = Screen_height - 70;
    }
    self.Carview.left = Screen_width - 50;
    self.Carview.delegate = self;
    [self.Carview SetCarNumber];
    [self.view addSubview:self.Carview];
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
////    GoodsListModel *listModel = [[GoodsListModel alloc]init];
////    listModel.GoodsId = [NSString stringWithFormat:@"%@", self.GoodsId];
////    listModel.chmc = _Detailmodel.chmc;
////    listModel.tlscj = _Detailmodel.tlscj;
////    listModel.cklsj = _Detailmodel.cklsj;
////    NSString *str = [[_Detailmodel.tpmc objectAtIndex:0] objectForKey:@"tpmc"];
////    listModel.tpmc = str;
////    listModel.GoodsNumber = @"1";
////    if ([self.GoodsType isEqualToString:isGoodsTypePoint]) {
////        listModel.Type = isGoodsTypePoint;
////    }else{
////        listModel.Type = isGoodsTypeMoney;
////    }
//    
//    //判断是否存在相同类型的商品
//    UIView *view = [[UIView alloc]initWithFrame:self.view.bounds];
//    view.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:view];
//    
//    CarHaveSameGoods oneSuc = [TimeObject isHaveTwoClassOfInCar:self.GoodsType];
//    if (oneSuc == CarHaveSameGoodsNomal) {
//        
//        BOOL success = [[GoodsDetailDataBase shareDataBase]insertItem:listModel];
//        if (success == YES) {
//            [ITTMessageView showMessage:@"已加入购物车" disappearAfterTime:1.0 andView:view];
//        }else{
//            [ITTMessageView showMessage:@"该商品已存在" disappearAfterTime:1.0 andView:view];
//        }
//    }
//    else
//    {
//        if (oneSuc == CarHaveSameGoodsPoint) {
//            [ITTMessageView showMessage:@"购物车中已存在积分商品,不能添加,请清空购物车后添加" disappearAfterTime:1.0 andView:view];
//        }else{
//            [ITTMessageView showMessage:@"购物车中已存在现金商品,不能添加,请清空购物车后添加" disappearAfterTime:1.0 andView:view];
//        }
//        
//    }
//    
//    
//    //设置tabbarlable显示
//    _ITTTabBarController = (ITTTabBarController *)self.tabBarController;
//    [_ITTTabBarController setNumberlable];
//    [self.Carview SetCarNumber];
    
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
