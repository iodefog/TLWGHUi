//
//  GoodsDetailDataBase.m
//  TaoliWang
//
//  Created by Mac OS X on 14-1-16.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "GoodsDetailDataBase.h"
#import "FMDatabaseAdditions.h"

static GoodsDetailDataBase *gl_DataBse = nil;
static NSString *tableName = nil;
@implementation GoodsDetailDataBase
+(GoodsDetailDataBase *)shareDataBase
{
    if (!gl_DataBse) {
        gl_DataBse = [[GoodsDetailDataBase alloc]init];
    }
    return gl_DataBse;
}
-(id)init
{
    if (self = [super init]) {
        if ([mdataBase open]) {
            NSDictionary *fileName = @{@"productId":@"VARCHAR",
                                       @"productName":@"VARCHAR",
                                       @"productDescribe":@"VARCHAR",
                                       @"previewPicPath":@"VARCHAR",
                                       @"productQuantity":@"VARCHAR",
                                       @"basicPrice":@"VARCHAR",
                                       @"costPrice":@"VARCHAR",
                                       @"productType":@"VARCHAR"};
             tableName = [NSString stringWithFormat:@"CarsList_%@",[[UserHelper shareInstance] getMemberID]];
            [super createTable:tableName fieldName:fileName];
        }
        [self closeDB];
    }
    return self;
}

-(BOOL)insertItem:(id)item
{
        /**
         *  判断是否有数据  有就不插入  没有就插入
         */
    @synchronized(self){
        GoodsListModel *newItem = (GoodsListModel *)item;
        [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            NSString *sql01 = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE productId='%@'", tableName,newItem.productId];
            FMResultSet *rs = [mdataBase executeQuery:sql01];
            if ([rs next])
            {
                return NO;
            }
            else
            {
                NSString *sql02 = [NSString stringWithFormat:@"INSERT INTO %@ (productId, productName, productDescribe, previewPicPath, productQuantity, basicPrice, costPrice, productType) VALUES (?,?,?,?,?,?,?,?)",tableName];
                BOOL success = [mdataBase executeUpdate:sql02,
                                newItem.productId,
                                newItem.productName,
                                newItem.productDescribe,
                                newItem.previewPicPath,
                                newItem.productQuantity,
                                newItem.basicPrice,
                                newItem.costPrice,
                                newItem.productType];
                [self closeDB];
                return success;
            }
        }
        else
        {
            [self closeDB];
            return NO;
        }
    }
}

-(NSMutableArray *)readTableName
{
    @synchronized(self){
        NSString *sql = nil;
      
    sql = [NSString stringWithFormat:@"SELECT productId,productName,productDescribe,previewPicPath,productQuantity,basicPrice,costPrice,productType FROM %@",tableName];
        if (sql) {
            [mdataBase open];
            FMResultSet *rs = [mdataBase executeQuery:sql];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            while ([rs next]) {
                GoodsListModel *item = [[GoodsListModel alloc]init];
                item.productId = [rs stringForColumn:@"productId"];
                item.productName = [rs stringForColumn:@"productName"];
                item.productDescribe = [rs stringForColumn:@"productDescribe"];
                item.previewPicPath = [rs stringForColumn:@"previewPicPath"];
                item.productQuantity = [rs stringForColumn:@"productQuantity"];
                item.basicPrice = [rs stringForColumn:@"basicPrice"];
                item.costPrice = [rs stringForColumn:@"costPrice"];
                item.productType = [rs stringForColumn:@"productType"];
                [resultArray addObject:item];
            }
            [self closeDB];
            return resultArray;
        }
        return nil;
    }
}


/***
 * 根据商品id查询购物车里个数
 */
- (NSString *)readTableQualityWithProductID:(NSString *)productId{
    @synchronized(self){
        NSString *sql = nil;
        NSString * productQuantity = nil;
        sql = [NSString stringWithFormat:@"SELECT productQuantity FROM %@ where productId=%@",tableName, productId];
        if (sql) {
            [mdataBase open];
            NSLog(@"----%@",[mdataBase stringForQuery:sql]);
            productQuantity = [mdataBase stringForQuery:sql];
        }
        [self closeDB];
        return productQuantity;
    }
}


/**
 *  更新数据
 *
 *  @param item
 *  @param num
 */
-(void)updateItem:(id)item andProNumber:(NSString *)num
{
    @synchronized(self){
        [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            GoodsListModel *model =(GoodsListModel *)item;
            NSString *sql = [NSString stringWithFormat:@"update %@ set productQuantity='%@' where productId='%@'", tableName ,num ,model.productId];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"更新失败");
            }
        }
        [self closeDB];
    }
}

- (void)updateItem:(id)item{
    @synchronized(self){
        [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            GoodsListModel *model =(GoodsListModel *)item;
            NSString *sql = [NSString stringWithFormat:@"update %@ set productName='%@',productDescribe='%@',previewPicPath='%@',basicPrice='%@',costPrice='%@',productType=%@ where productId='%@'", tableName ,model.productName,model.productDescribe,model.previewPicPath,model.basicPrice,model.costPrice,model.productType ,model.productId];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"更新失败");
            }
        }
        [self closeDB];
    }
    //    productName, productDescribe, previewPicPath, productQuantity, basicPrice, costPrice, productType

}

/**
 *  删除数据
 */

-(void)deleteTableProductId:(id)item
{
    @synchronized(self){
    [mdataBase open];
        if ([item isKindOfClass:[GoodsListModel class]]) {
            GoodsListModel *model =(GoodsListModel *)item;
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where productId='%@'",tableName ,model.productId];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"删除失败");
            }
        }
        [self closeDB];
    }
}

// 清空表数据
- (BOOL)cleanTabel{
    BOOL mm = YES;
    @synchronized(self){
        [mdataBase open];
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM %@", tableName];
        if (![mdataBase executeUpdate:sqlstr])
        {
            NSLog(@"Erase table error!");
            mm = NO;
        }else{
            mm = YES;
        }
    [self closeDB];
    }
    return  mm;
}

@end
