//
//  BaseDTo.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "BaseDTo.h"

@implementation BaseDTo

- (void)parse:(NSMutableDictionary *)result{
    [super parse:result];
    self.dtoResult = result;
    self.code = [self getIntValue:result[@"code"]];
    self.msg = [self getStrValue:result[@"msg"]];
}

@end
