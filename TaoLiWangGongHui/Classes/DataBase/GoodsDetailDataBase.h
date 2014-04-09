//
//  GoodsDetailDataBase.h
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DataBase.h"
#import "GoodsListModel.h"
@interface GoodsDetailDataBase : DataBase
+(GoodsDetailDataBase *)shareDataBase;
//插入数据
-(BOOL)insertItem:(id)item;
//读取数据
-(NSMutableArray *)readTableName;
// 根据商品id查询购物车里个数
- (NSString *)readTableQualityWithProductID:(NSString *)productId;
// 更新一些网络获取数据
- (void)updateItem:(id)item;
//更新数据
-(void)updateItem:(id)item andProNumber:(NSString *)num;
//删除数据
-(void)deleteTableProductId:(id)item;
// 清空表数据
- (BOOL)cleanTabel;
@end
