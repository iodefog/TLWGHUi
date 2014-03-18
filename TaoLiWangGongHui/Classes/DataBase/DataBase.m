//
//  DataBase.m
//  ANgene
//
//  Created by Mac on 13-11-29.
//  Copyright (c) 2013年 lilinkai. All rights reserved.
//

#import "DataBase.h"
static DataBase *gl_DataBse = nil;
@implementation DataBase
{
     BOOL isSuccess;
}

+(DataBase *)shareDataBase
{
    if (!gl_DataBse) {
        gl_DataBse = [[DataBase alloc]init];
    }
    return gl_DataBse;
}

-(NSString *)filePathByName:(NSString *)fileName{

    NSString *path=NSHomeDirectory();
    path=[path stringByAppendingPathComponent:@"/Documents"];
    
    if (fileName&& [fileName length]!=0) {
        path=[path stringByAppendingPathComponent:fileName];
    }
    return path;
}

-(id)init{
    if (self = [super init]) {
        filePath = [self filePathByName:@"TaoLiWangGongHui.db"];
        mdataBase = [FMDatabase databaseWithPath:filePath];
        [mdataBase open];
    }
    return self;
}

/*
 * 创建表
 */

- (BOOL)createTable:(NSString *)tableName fieldName:(NSDictionary *)fieldName
{
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE if not exists %@ ", tableName];
    NSString *keyStr = @" ";
    int dicCount = (int)[fieldName count];
    int i = 0;
    for(id key in fieldName)
    {
        i++;
        if (i == dicCount)
        {
            keyStr = [keyStr stringByAppendingString:[NSString stringWithFormat:@"%@ %@ ", key, [fieldName objectForKey:key]]];
        }
        else
        {
            keyStr = [keyStr stringByAppendingString:[NSString stringWithFormat:@"%@ %@, ", key, [fieldName objectForKey:key]]];
        }
    }
    sql = [sql stringByAppendingFormat:@"(%@)", keyStr];
    if ([mdataBase open])
    {
        isSuccess = [mdataBase executeUpdate:sql];
    }
    return isSuccess;
}

/*
 * 基本查询
 */

-(id)baseSeclectItem:(NSString *)tableName
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", tableName];
    FMResultSet *rs=[mdataBase executeQuery:sql];
    return rs;
}

/*
 * 基本删除
 */

- (BOOL)deleteTable:(NSString *)tableName
{
    return [mdataBase executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", tableName]];;
}

/*
 * 关闭数据库
 */

- (BOOL)closeDB
{
    return [mdataBase close];
}

@end
