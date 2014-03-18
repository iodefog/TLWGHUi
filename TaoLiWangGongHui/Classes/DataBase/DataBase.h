//
//  DataBase.h
//  ANgene
//
//  Created by Mac on 13-11-29.
//  Copyright (c) 2013年 lilinkai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DataBase : NSObject
{
    NSString *filePath;
    FMDatabase *mdataBase;
}

+(DataBase *)shareDataBase;
-(id)init;

//创建表
- (BOOL)createTable:(NSString *)tableName fieldName:(NSDictionary *)fieldName;

//基本查询
-(id)baseSeclectItem:(NSString *)tableName;

-(NSString *)filePathByName:(NSString *)fileName;

- (BOOL)deleteTable:(NSString *)tableName;

//关闭数据库
- (BOOL)closeDB;

@end
