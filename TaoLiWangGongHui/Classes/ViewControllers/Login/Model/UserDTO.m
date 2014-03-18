//
//  UserDTO.m
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-13.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "UserDTO.h"  //

@implementation UserDTO

@synthesize memberID;

- (void)parse:(NSDictionary *)result{
    [super parse:result];
    self.memberID = result[@"result"];
}

@end
