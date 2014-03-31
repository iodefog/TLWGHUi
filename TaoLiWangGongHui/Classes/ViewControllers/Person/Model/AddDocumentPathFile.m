//
//  AddDocumentPathFile.m
//  TaoliWang
//
//  Created by Mac OS X on 14-2-19.
//  Copyright (c) 2014年 Custom. All rights reserved.
//

#import "AddDocumentPathFile.h"

@implementation AddDocumentPathFile
/**
 *  创建文件在沙河目录
 */
+(NSString *)AddFileName:(NSString *)string andType:(NSString *)type{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filepath = [[path objectAtIndex:0] stringByAppendingPathComponent:string];
    if (![fm fileExistsAtPath: filepath]){
        if ([type isEqualToString:@"plist"]) {
            NSArray *dict = [[NSArray alloc]init];
            [fm createFileAtPath:filepath contents:dict attributes:nil];
        }else{
            [fm createFileAtPath:filepath contents:nil attributes:nil];
        }
    }
    return filepath;
}
/**
 *  把内容写入相应文件下
 */
+(void)WriteContent:(id)content andFilePath:(NSString *)string
{
    NSMutableArray *arr = (NSMutableArray *)content;
    [arr writeToFile:string atomically:YES];
}
@end
