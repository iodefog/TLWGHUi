//
//  CONSTS.h
//  Hupan
//
//  Copyright 2010 iTotem Studio. All rights reserved.
//


#define REQUEST_DOMAIN @"http://cx.itotemstudio.com/api.php" // default env

//text
#define TEXT_LOAD_MORE_NORMAL_STATE @"向上拉动加载更多..."
#define TEXT_LOAD_MORE_LOADING_STATE @"更多数据加载中..."


//other consts
typedef enum{
	kTagWindowIndicatorView = 501,
	kTagWindowIndicator,
} WindowSubViewTag;

typedef enum{
    kTagHintView = 101
} HintViewTag;
/**
 *  is InternetConnection
 */
#define isReachability                      [Reachability isNetWorkReachable]

// 所有网路请求url的前缀
#define BASE_REQUEST_URL        @"http://www.ugift.com.cn:8088/Interface/"

/**
 *  AppDelegate
 */
#define LOGIN_VIEW_CONTROLLER           0
#define HOME_VIEW_CONTROLLER            1
#define DISTRIBUTOR_VIEW_CONTROLLER     2
#define SharedApp                       ((AppDelegate*)[[UIApplication sharedApplication] delegate])
/**
 *  ios适配
 */
#define  isIOS7                              [[[UIDevice currentDevice]systemVersion]floatValue] >=7
#define Screen_height                        [[UIScreen mainScreen] bounds].size.height
#define Screen_width                         [[UIScreen mainScreen] bounds].size.width
#define iPhone5                              ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/**========================================================
 *  登录接口
 ===============================================================**/
#define USER_LOGIN_REQUEST [NSString stringWithFormat:@"%@%@",BASE_REQUEST_URL,@"UserAction!login.do"]

