//
//  config.m
//  SideBarDemo
//
//  Created by ledmedia on 13-8-7.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import "Config.h"

@implementation UIDevice (Resolutions)

Boolean  iscustomer=YES;  //默认是客户账号
NSString *isHereToInfomationRegister;
NSString *isHereToMyCustomer;
NSString *isHereToApplyRecord;
NSString *isHereToVCard;
NSString *isHereToLogin;
NSString *trackViewUrl;
NSString *isShowGridmenu;
BOOL isOK;
NSMutableArray *ConnectionStatus;//连接状态
//NSArray *ftpxmlArr;//ftp上的项目文件
//项目名字
NSString *pname;

NSString *fanganname;//方案名称
NSInteger fangannum;//云屏数量
NSString *jianceip;
//一级目录数据
NSMutableArray *firstMenuArray;
//二级目录数据
NSMutableArray *_ColumnsDataArray;
//二级目录数据以字典形式存储
NSMutableDictionary *_ColumnsDictionary;
//人脉模块名片数据的二级目录
NSMutableArray *_NameCardColumnsArray;
//网格数据
NSMutableArray *gridVideoArray;
//九宫格数据
NSMutableArray *gridDataArray;
//广告链接数据
NSMutableArray *adDataArray;
//ip名称
NSMutableArray *ipNameArr;
//ip地址
NSMutableArray *ipAddressArr;
//选中路由
NSMutableArray *selectIpArr;
NSMutableArray *selectNameArr;
//是否显示下线警告窗口
NSInteger isAlert;
BOOL back;
//有求必应发布数据的类型
NSString *publishTypeString;

//帧数据字典
NSMutableDictionary *globalDictFramesInfo;
float globalDuration;
NSString *globalsVideoPath;
float globalWHScale;


/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        if ([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) {
            CGSize result = [[UIScreen mainScreen] bounds].size;
            result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
            if (result.height <= 480.0f)
                return UIDevice_iPhoneStandardRes;
            return (result.height > 960 ? UIDevice_iPhoneTallerHiRes : UIDevice_iPhoneHiRes);
        } else
            return UIDevice_iPhoneStandardRes;
    } else
        return (([[UIScreen mainScreen] respondsToSelector: @selector(scale)]) ? UIDevice_iPadHiRes : UIDevice_iPadStandardRes);
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5{
    if ([self currentResolution] == UIDevice_iPhoneTallerHiRes) {
        return YES;
    }
    return NO;
}

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

+(BOOL)isRunningOniPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+(BOOL)isRunningOniPod
{
    if ([self currentResolution] == UIDevice_iPhoneStandardRes) {
        return YES;
    }
    return NO;
}
@end





//验证新版本和下载新版的地址
NSString *trackViewUrl;


//设置语言为调用哪个函数的函数名
NSString  *languageString;
@implementation Config

/*自定义默认语言的方法*/
+ (NSString *)DPLocalizedString:(NSString *)translation_key {
    NSString * s = NSLocalizedString(translation_key, nil);
    NSString * path;
    if ([languageString isEqual:@"zh-Hans"]) {
        path = [[NSBundle mainBundle] pathForResource:@"zh-Hans" ofType:@"lproj"];
    }else if ([languageString isEqual:@"zh-Hant"]){
        path = [[NSBundle mainBundle] pathForResource:@"zh-Hant" ofType:@"lproj"];
    }else if ([languageString isEqual:@"en"]){
        path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
    }else if ([languageString isEqual:@"it"]){
        path = [[NSBundle mainBundle] pathForResource:@"it" ofType:@"lproj"];

    }
    
    NSBundle * languageBundle = [NSBundle bundleWithPath:path];
    s = [languageBundle localizedStringForKey:translation_key value:@"" table:nil];
    return s;
}
/*保存ip地址的字符串*/
NSString *ipAddressString;
/*ftp port*/
NSString *ftpPort;
NSString *playerNameString;
NSMutableArray *photoArr;

/*保存屏体选项的提示*/
NSString *screenOptionPromptString;




-(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    DLog(@"deviceType = %@", deviceType);
    
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}

+(NSInteger)currentOniPhoneHeight{
    if ([UIDevice isRunningOniPhone]) {
        if ([UIDevice isRunningOniPhone5]) {
            return 568-20;
        }else
        {
            return 480-20;
        }
    }else if ([UIDevice isRunningOniPad]){
        return 1024-20;
    }else{
        return 1024-20;
    }
}

/**
 *@brief 竖屏显示的Frame
 */
+(CGRect)currentViewPortraitFrame{
    float viewHeight;
    viewHeight = SCREEN_CGSIZE_HEIGHT;
    float Y;
    Y = 0.0;
    if (OS_VERSION_FLOAT < 7.0f) {
        viewHeight -= 20;
        viewHeight -=  [self currentTabBarHeight];
        viewHeight -=  [self currentNavigateHeight];
    }else{
        viewHeight -= 20;
    }
    
    CGRect tempRect = CGRectMake(0, Y, SCREEN_CGSIZE_WIDTH, viewHeight);
    return tempRect;
}

/**
 *@brief 竖屏显示的WebView的Frame
 */
+(CGRect)currentWebViewPortraitFrame{
    float viewHeight;
    viewHeight = SCREEN_CGSIZE_HEIGHT - [self currentNavigateHeight];

//    if (OS_VERSION_FLOAT < 7.0f) {
//        viewHeight -= 20;
        viewHeight -=  [self currentTabBarHeight];
//    }else{
//        viewHeight += 20;
//    }
    
    CGRect tempRect = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, viewHeight);
    return tempRect;
}

+(CGRect)currentNoTabBarViewPortraitFrame{
    float viewHeight;
    viewHeight = SCREEN_CGSIZE_HEIGHT - [self currentNavigateHeight];
    //    if ([UIDevice isRunningOniPhone5]) {
    //        viewHeight = SCREEN_CGSIZE_HEIGHT - 20 - 32;
    //    }
    //    if ([UIDevice isRunningOniPad]) {
    //        viewHeight = SCREEN_CGSIZE_HEIGHT - 20 - 39;
    //    }
    if (OS_VERSION_FLOAT < 7.0f) {
        viewHeight -= 20;
    }
    
    CGRect tempRect = CGRectMake(0, 0, SCREEN_CGSIZE_WIDTH, viewHeight);
    return tempRect;
}

/**
 *@brief 状态栏的高度
 */
+(NSInteger)currentNavigateHeight
{
    if (OS_VERSION_FLOAT >= 7.0) {
        return 64;
    }
    return 44;
}

/**
 *@brief 选项卡的高度
 */
+(NSInteger)currentTabBarHeight
{
    if (DEVICE_IS_IPAD) {
        return 56;
    }
    return 49;
}

+(NSInteger)leftMenuWidth
{
//    if ([UIDevice isRunningOniPad]) {
//        return 768*0.625;
//    }
//    return 320*0.625;
    
    //yxm modify 2013年09月24日09:37:47
    
    if ([UIDevice isRunningOniPad]) {
        return 768*0.825;
    }
    return 320*0.825;
}

+(NSInteger)rightSettingWidth
{
//    if ([UIDevice isRunningOniPad]) {
//        return 768*0.375;
//    }
//    return 320*0.375;
    
    //yxm modify 2013年09月24日09:37:47
    
    if ([UIDevice isRunningOniPad]) {
        return 768*0.175;
    }
    return 320*0.175;
}

+(NSInteger)leftColumnHeight
{
    return 45;
}

+(NSInteger)leftColumnWidth
{
    if ([UIDevice isRunningOniPad]) {
        return 768*0.35;
    }
    return 320*0.75;
}

/**
 *@brief 视图的起始位置的偏移
 */
+(NSInteger)topOffsetHeight{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    DLog(@"当前系统版本=%lf",version);
    if(version >= ((double)7.0)){
        return 20;
    }
    return 0;
}

+(float)currentStateBarHeight{
    return 20.0f;
}

/**
 *@brief 网格视图每一格的宽度
 */
+(float)CollectionCellBoxWidth{
    return SCREEN_CGSIZE_WIDTH/3.02;
}

/**
 *@brief 网格视图每一格的高度
 */
+(float)CollectionCellBoxHeight{
    return SCREEN_CGSIZE_WIDTH/3.05;
}

///**
// *@brief 视图切换动画的类别
// */
//+(NSString *)ViewTransitionStyle{
////    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_VIEW_TRANSITION_STYLE];
//}

/**
 *@brief 判断当前是否在iPhone上运行
 */
+(BOOL)isRunningOniPhone
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
}

/**
 *@brief 判断当前是否在iPad上运行
 */
+(BOOL)isRunningOniPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

/**
 *@brief 判断当前是否在iPod上运行
 */
+(BOOL)isRunningOniPod
{
    return [[UIDevice currentDevice].model isEqualToString:@"iPod touch"];
}

/**
 *@brief 返回值为当前运行的语言
 */
+(NSString *)isRunningOnLanguage
{
    return [[[NSUserDefaults standardUserDefaults]objectForKey:@"AppleLanguages"]objectAtIndex:0];
}

/**
 *@brief 返回值为当前运行的系统值iOS6/iOS7中6或7
 */
+(NSInteger)currentVersion
{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    return (int)version;
}


@end
