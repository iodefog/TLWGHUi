//
//  BaseDTo.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTOBase.h"

@interface BaseDTo : DTOBase
@property (nonatomic, assign) NSInteger code;   //状态码
@property (nonatomic, strong) NSString *msg;    //状态中文说明
- (void)parse:(NSDictionary *)result;
@end
