//
//  AliPayHelper.m
//  test1
//
//  Created by 乐播 on 13-10-15.
//  Copyright (c) 2013年 乐播. All rights reserved.
//

#import "AliPayHelper.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"

@implementation Product
@synthesize price = _price;
@synthesize subject = _subject;
@synthesize body = _body;
@synthesize orderId = _orderId;

@end

@implementation AliPayHelper

@synthesize aliPayDelegate;
@synthesize result = _result;


static AliPayHelper *alipayHelper = nil;

+ (id)shareInstance{
    if (!alipayHelper) {
        alipayHelper = [[AliPayHelper alloc] init];
    }
    return alipayHelper;
}

- (void)payOrder:(NSString*)order AndScheme:(NSString*)scheme  seletor:(SEL)seletor target:(id)target{
    self.aliPayDelegate = target;
    [AlixLibService payOrder:order AndScheme:scheme seletor:seletor target:target];
}

- (void)setAliPayProduct:(Product *)product{
    /*
	 *生成订单信息及签名
	 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法
	 */
    
    NSString *appScheme = AppName;
//    Product *product = [_products objectAtIndex:indexPath.row];
    
    /*
	 *生成订单信息及签名
	 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法
	 */
#if __has_feature(objc_arc)
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
#else
    AlixPayOrder *order = [[[AlixPayOrder alloc] init] autorelease];
#endif
    
    order.partner = PartnerID;
    order.seller = SellerID;
    
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
	order.productName = product.subject; //商品标题
	order.productDescription = product.body; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f", product.price]; //商品价格
	order.notifyURL =  @"http%3A%2F%2Fwww.xxx.com"; //回调URL
    
    NSString *orderInfo = [order description];
    NSString *signedStr = [self doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", orderInfo, signedStr, @"RSA"];
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
}

//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            if (self.aliPayDelegate && [self.aliPayDelegate respondsToSelector:@selector(alixLibPaySuccess:)]) {
                [self.aliPayDelegate performSelector:@selector(alixLibPaySuccess:) withObject:resultd];
            }
            //交易成功
            NSString* key = @"签约帐户后获取到的支付宝公钥";
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
			}
        }
        else
        {
            //交易失败
            if (self.aliPayDelegate && [self.aliPayDelegate respondsToSelector:@selector(alixLibPayFail:)]) {
                [self.aliPayDelegate performSelector:@selector(alixLibPayFail:) withObject:resultd];
            }
        }
    }
    else
    {
        //失败
        if (self.aliPayDelegate && [self.aliPayDelegate respondsToSelector:@selector(alixLibPayFail:)]) {
            [self.aliPayDelegate performSelector:@selector(alixLibPayFail:) withObject:resultd];
        }
    }
    
}

-(NSString*)getOrderInfo:(NSInteger)index
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
	Product *product = [_products objectAtIndex:index];
	NSString* price = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
    
    NSMutableString * discription = [NSMutableString string] ;
	[discription appendFormat:@"partner=\"%@\"", PartnerID];
	[discription appendFormat:@"&seller=\"%@\"", SellerID];
	[discription appendFormat:@"&out_trade_no=\"%@\"", [self generateTradeNO]];
	[discription appendFormat:@"&subject=\"%@\"", product.subject];
	[discription appendFormat:@"&body=\"%@\"", product.body];
	[discription appendFormat:@"&total_fee=\"%@\"", price];
	[discription appendFormat:@"&notify_url=\"%@\"", @"www.xxx.com"];
	return discription;
}

- (NSString *)generateTradeNO
{
	const int N = 15;
	
	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init] ;
	srand(time(0));
	for (int i = 0; i < N; i++)
	{
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"%@",result);
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {

		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            NSLog(@"result.resultString:%@ \nresult.signString : %@", result.resultString, result.signString);
           
            //交易成功
            NSString* key = AlipayPubKey;    //签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            if (self.aliPayDelegate && [self.aliPayDelegate respondsToSelector:@selector(alixLibPaySuccess:)]) {
                [self.aliPayDelegate performSelector:@selector(alixLibPaySuccess:) withObject:result.resultString];
            }

			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                NSLog(@"pay seccess");
            }
        }
        else
        {
            if (self.aliPayDelegate && [self.aliPayDelegate respondsToSelector:@selector(alixLibPayFail:)]) {
                [self.aliPayDelegate performSelector:@selector(alixLibPayFail:) withObject:result.resultString];
            }
            //交易失败
        }
    }
    else
    {
        if (self.aliPayDelegate && [self.aliPayDelegate respondsToSelector:@selector(alixLibPayFail:)]) {
            [self.aliPayDelegate performSelector:@selector(alixLibPayFail:) withObject:result.resultString];
        }

        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end
