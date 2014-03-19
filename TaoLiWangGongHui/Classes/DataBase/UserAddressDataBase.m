//
//  MyAddressDataBase.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "UserAddressDataBase.h"
static UserAddressDataBase *gl_DataBse = nil;
@implementation UserAddressDataBase
+(UserAddressDataBase *)shareDataBase
{
    if (!gl_DataBse) {
        gl_DataBse = [[UserAddressDataBase alloc]init];
    }
    return gl_DataBse;
}

static NSString *tableName = nil;

-(id)init
{
    if (self = [super init]) {
        if ([mdataBase open]) {
            NSDictionary *fileName = @{@"Name":@"VARCHAR",
                                       @"AddressId":@"INTEGER",
                                       @"Address":@"VARCHAR",
                                       @"Phone":@"VARCHAR",
                                       @"Email":@"VARCHAR",
                                       @"ZipCode":@"VARCHAR",
                                       @"Type":@"VARCHAR",
                                       @"City":@"VARCHAR"};
            tableName = [NSString stringWithFormat:@"UserAddress_%@",[[UserHelper shareInstance] getMemberID]];
            [super createTable:tableName fieldName:fileName];
        }
    }
    return self;
}
-(BOOL)insertItem:(id)item
{
    @synchronized(self){
        AddressModel *newItem = (AddressModel *)item;
        [mdataBase open];
        if ([item isKindOfClass:[AddressModel class]]) {
            
            NSString *sql01 = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE AddressId='%d'", tableName,newItem.AddressId.intValue];
            FMResultSet *rs = [mdataBase executeQuery:sql01];
            if ([rs next])
            {
                return NO;
            }
            else
            {
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (Name,AddressId,Address,Phone,Email,ZipCode,Type,City) VALUES (?,?,?,?,?,?,?,?)",tableName];
                BOOL success = [mdataBase executeUpdate:sql,
                                newItem.Name,
                                newItem.AddressId,
                                newItem.Address,
                                newItem.Phone,
                                newItem.Email,
                                newItem.ZipCode,
                                newItem.Type,
                                newItem.City];
                return success;
            }
            [self closeDB];
        }
        else
        {
            return NO;
        }
    }

}
-(void)insertItemArray:(NSArray *)array
{
    [mdataBase beginTransaction];
    for (id object in array) {
        [self insertItem:object];
    }
    [mdataBase commit];
}
/**
 *  判断是否有数据  有就不插入  没有就插入
 */

-(NSMutableArray *)readTableName
{
    @synchronized(self){
        NSString *sql = nil;
            sql = [NSString stringWithFormat:@"SELECT Name,AddressId,Address,Phone,Email,ZipCode,Type,City FROM %@ ORDER BY Type desc",tableName];
        if (sql) {
            [mdataBase open];
            FMResultSet *rs = [mdataBase executeQuery:sql];
            NSMutableArray *resultArray = [NSMutableArray arrayWithCapacity:0];
            while ([rs next]) {
                AddressModel *item = [[AddressModel alloc]init];
                item.Name = [rs stringForColumn:@"Name"];
                item.Address = [rs stringForColumn:@"Address"];
                item.AddressId = [NSNumber numberWithInt:[rs intForColumn:@"AddressId"]];
                item.Phone = [rs stringForColumn:@"Phone"];
                item.Email = [rs stringForColumn:@"Email"];
                item.ZipCode = [rs stringForColumn:@"ZipCode"];
                item.type = [rs stringForColumn:@"Type"];
                item.city = [rs stringForColumn:@"City"];
                [resultArray addObject:item];
            }
            return resultArray;
        }
        return nil;
        [self closeDB];
    }
}
/**
 *  更新数据
 *
 *  @param item
 *  @param num
 */
-(BOOL)updateItem:(id)item defaultType:(BOOL)defaultType
{
    BOOL success01 = YES;
    @synchronized(self){
        [mdataBase open];
        if ([item isKindOfClass:[AddressModel class]]) {
            AddressModel *model =(AddressModel *)item;
            
//            NSString *sql01 = [NSString stringWithFormat:@"update %@ set Type='%@' where AddressId='%d'",tableName , [NSString stringWithFormat:@"%d",defaultType] ,model.AddressId.intValue];
//             success01 = [mdataBase executeUpdate:sql01];
//            if (!success01) {
//                NSLog(@"更新失败01");
//            }
            
            NSString *sql = [NSString stringWithFormat:@"update %@ set Name='%@',Address='%@',Phone='%@', Email='%@',ZipCode='%@',Type='%@',City='%@' where AddressId='%d'", tableName, model.Name, model.Address, model.Phone, model.Email,model.ZipCode, [NSString stringWithFormat:@"%d",defaultType], model.City, model.AddressId.intValue];
            BOOL success = [mdataBase executeUpdate:sql];
            if (!success) {
                NSLog(@"更新失败");
            }
        }
        [self closeDB];
    }
    return success01;
}

@end
