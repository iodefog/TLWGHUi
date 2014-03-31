//
//  MessageModel.h
//  TaoLiWangGongHui
//
//  Created by apple on 14-3-19.
//  Copyright (c) 2014年 Hongli. All rights reserved.
//

#import "ITTBaseModelObject.h"

@interface MessageModel : ITTBaseModelObject

/****
 	广告id(newsId)
 	广告图片(newsPicPath)
 	广告名称(newsTitle)
 */

/****  或
	栏目id（newsId）
	栏目图片(newsPicPath)
	栏目名称(newsTitle)
	订阅状态（0为未订阅，1为订阅）(newsType)
*/

@property (nonatomic, strong) NSString *newsId;
@property (nonatomic, strong) NSString *newsPicPath;
@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSString *newsType;

@end
