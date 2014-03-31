//
//  AddDocumentPathFile.h
//  TaoliWang
//
//  Created by Mac OS X on 14-2-19.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddDocumentPathFile : NSObject
+(NSString *)AddFileName:(NSString *)string andType:(NSString *)type;
+(void)WriteContent:(id)content andFilePath:(NSString *)string;
@end
