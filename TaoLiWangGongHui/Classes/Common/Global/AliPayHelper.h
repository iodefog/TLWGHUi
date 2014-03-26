//
//  AliPayHelper.h
//  test1
//
//  Created by 乐播 on 13-10-15.
//  Copyright (c) 2013年 乐播. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AlixLibService.h"

@protocol AlixLibPayDelegate <NSObject>

- (void)alixLibPaySuccess:(id)response;
- (void)alixLibPayFail:(id)response;

@end

@interface Product : NSObject{
@private
	float _price;
	NSString *_subject;
	NSString *_body;
	NSString *_orderId;
}

@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *orderId;
@end


@interface AliPayHelper : NSObject{
    SEL _result;
    NSMutableArray *_products;
}

@property (nonatomic ,assign) id aliPayDelegate;
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。

+ (id)shareInstance;
- (void)setAliPayProduct:(Product *)product;

-(void)paymentResult:(NSString *)result;

- (void)parse:(NSURL *)url application:(UIApplication *)application;

- (void)payOrder:(NSString*)order AndScheme:(NSString*)scheme  seletor:(SEL)seletor target:(id)target;

@end
