//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088001337775931"
//收款支付宝账号
#define SellerID  @"info@ugift.com.cn"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"5jzycc01yooashiu8dodhqgxs7rhj4ja"

//应用的名字
#define AppName @"TaoliWang"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKoNzMihhc6TRJCblLh8FNsv+XO4BDRDItlCVQD2mamOcbpHu06RmEp4zHn57QBIjyNTOrtOJnuJ+S9lDPYuGqhuOQRQK3YC9NtgOuw0yizxQ1ROWTaKwyl5GMeuij2p2lnwuIJQfDQkpbRXnLEzIxh1E3HX3UgCvn5bB04yvCUxAgMBAAECgYBZ4hFrunRPS+fhx1pEaNFdSW5Ai/Ms7I9u5nCnobB2vqO+IkwOq0YjltX9YuyySafetA9HEXeltLfRJUhElvnfT+tL7Qipyp1IY6HXdwHn/47cOvVpuV1Ff3RrFIolMbKTlyV8KVjsRF6USx3EuS5Se3pBJDpu8zqlhICOFhRwQQJBAN2dQnhwLX+ln/k2Tvs7EPU0dQKo7NzT2HzNH2AZhO50xeSme1+V34JFHvXYl8cNr+KN6MyGdWriu6DYy+vUJ+MCQQDEcIKjbvcEnfX8Z2KCkKdiaEvj24finszP4WVQSyqDpWQ0UyfSWuDkg6Nhoe2AhHjvmrnj/w++N5J9W+VRLMLbAkEAq1B0H/Jn2bNJNTd8Ws3QUB1bDtFTOWoygld3F6zijAuNJzJjUQLkoymXw2jJ+8Bi5PnaqrCOeDAJ509wZD+/DQJBAK9iBEEGgWSN42FGrJ0FqWwi0h7NkbSzMwkmo93cPkjrEVvmIlec680Z+nTgrbtgitjhu7Xjs5qQ4ykpMsQWwqECQBUmQMdmRMDtXVBumSVWKlcK0GigD7v6m4zr+q+/uJEwEyv72k6Z6NWnILhBN4R0WzeEvkNivzvYB278Zn2lYjo="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCPMEJ3ZIU5SBPPuuaw9i1BuvmQAMxIlvftSwQR7/wCf+PZGU0KlTxxRCCONYatnK/NgFXkaWmvhfKitpCA1EhZJNNzUqsWUdJc+BFhbDw//YPol6Fvb2Sv2UboU89A1c7R+x8rzeQoZ5SR8HPq9ohlcNtBWKco5DoY1QTVZRs7eQIDAQAB"

#endif
