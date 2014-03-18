//
//  MyAddressDataBase.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-17.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "DataBase.h"
#import "AddressModel.h"
@interface UserAddressDataBase : DataBase
+(UserAddressDataBase *)shareDataBase;
//插入数据
-(BOOL)insertItem:(id)item;
-(void)insertItemArray:(NSArray *)array;
//读取数据
-(NSMutableArray *)readTableName;
//更新首选地址
-(BOOL)updateItem:(id)item defaultType:(BOOL)defaultType;
@end
