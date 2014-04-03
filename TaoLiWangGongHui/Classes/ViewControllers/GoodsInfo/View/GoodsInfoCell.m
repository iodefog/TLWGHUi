//
//  GoodsInfoCell.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-5.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#define GoodsImageExampleCount 5
#import "GoodsDetailDataBase.h"
#import "GoodsInfoCell.h"

@implementation GoodsInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)createUI{
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor grayColor],[UIColor blackColor],[UIColor blueColor],[UIColor yellowColor],[UIColor greenColor], nil];
    self.goodsScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, 230)];
    self.goodsScroll.pagingEnabled = YES;
    self.goodsScroll.delegate = self;
    self.goodsScroll.contentSize = CGSizeMake(320 * GoodsImageExampleCount, 230);
    for (int i = 0; i < GoodsImageExampleCount ; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * i, 0, self.width, 230)];
        imageView.backgroundColor = colorArray[i];
        [self.goodsScroll addSubview:imageView];
    }
    [self addSubview:self.goodsScroll];
    self.imagePage = [[UILabel alloc] initWithFrame:CGRectMake(270, 200, 40, 20)];
    self.imagePage.backgroundColor = [UIColor grayColor];
    self.imagePage.textColor = [UIColor whiteColor];
    self.imagePage.textAlignment = NSTextAlignmentCenter;
    self.imagePage.text = [NSString stringWithFormat:@"%d/%d",1,GoodsImageExampleCount];
    [self addSubview:self.imagePage];
}

- (void)tapClicked:(UITapGestureRecognizer *)gesture{

}

- (void)setObject:(NSDictionary *)params{
   GoodsListModel *discountModel = [[GoodsListModel alloc] initWithDataDic:params];
    self.goodsDescription.text = discountModel.productName;
    if (!discountModel.costPrice) {
        self.sperateLine.hidden = YES;
    }else{
        self.sperateLine.hidden = NO;
    }
    self.discount.text = discountModel.costPrice;
    self.originalPrice.text =discountModel.basicPrice;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addToCart:(UIButton *)sender {
    
    
    
//    if ([[GoodsDetailDataBase shareDataBase] insertItem:self.goodsListModel]) {
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"已加入购物车"];
//    }else{
//        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"购物车里已存在"];
//    }
}

#pragma mark - ScrollDelegate Method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentPage = (NSInteger)scrollView.contentOffset.x /self.width;
    self.imagePage.text = [NSString stringWithFormat:@"%d/%d",(int)currentPage+1,GoodsImageExampleCount];
}

@end
