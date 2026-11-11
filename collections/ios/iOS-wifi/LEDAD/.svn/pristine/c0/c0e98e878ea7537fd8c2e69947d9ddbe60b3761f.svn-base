//
//  config.h
//  SideBarDemo
//
//  Created by ledmedia on 13-8-7.
//  Copyright (c) 2013年 JianYe. All rights reserved.
//

#import <Foundation/Foundation.h>

extern Boolean  iscustomer;
extern NSString *isHereToInfomationRegister;//服务中心中相同页面 现场支持登记信息 和 远程支持登记信息
extern NSString *isHereToMyCustomer; //到我的用户
extern NSString *isHereToApplyRecord;//到维修记录列表
extern NSString *isHereToVCard;      //电子名片
extern NSString *isHereToLogin;  
extern NSString *isShowGridmenu;//是否显示主页面

//extern NSArray *ftpxmlArr;//ftp上的项目文件

extern NSString *trackViewUrl;//版本监测里的
extern BOOL isOK;
extern NSMutableArray *ConnectionStatus;//连接状态
extern NSString *pname;//项目名称
extern NSString *fanganname;//方案名称
extern NSInteger fangannum;//云屏数量
extern NSString *jianceip;
extern NSMutableArray *selectNameArr;
//一级目录数据
extern NSMutableArray *firstMenuArray;
//二级目录数据
extern NSMutableArray *_ColumnsDataArray;
//二级目录数据以字典形式存储
extern NSMutableDictionary *_ColumnsDictionary;
//人脉模块名片数据的二级目录
extern NSMutableArray *_NameCardColumnsArray;
//网格数据
extern NSMutableArray *gridVideoArray;
//九宫格数据
extern NSMutableArray *gridDataArray;
//广告链接数据
extern NSMutableArray *adDataArray;
//ip名称
extern NSMutableArray *ipNameArr;
//ip地址
extern NSMutableArray *ipAddressArr;
//选中路由
extern NSMutableArray *selectIpArr;

//是否显示下线警告窗口
extern NSInteger isAlert;
extern BOOL back;
//有求必应发布数据的类型
extern NSString *publishTypeString;
enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5
}; typedef NSUInteger UIDeviceResolution;



@interface UIDevice (Resolutions){
    
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution;

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5;

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone;

+(BOOL)isRunningOniPad;

+(BOOL)isRunningOniPod;



//设置语言为调用哪个函数的函数名
extern NSString  *languageString;

//帧信息
extern NSMutableDictionary *globalDictFramesInfo;
extern float globalDuration;
extern NSString *globalsVideoPath;
//宽高比
extern float globalWHScale;

@end


@interface Config : NSObject
/*自定义默认语言的方法*/
+ (NSString *)DPLocalizedString:(NSString *)translation_key;

/*保存ip地址的字符串*/
extern NSString *ipAddressString;
extern NSString *ftpPort;
extern NSString *playerNameString;
/*保存屏体选项的提示*/
extern NSString *screenOptionPromptString;
extern NSMutableArray *photoArr;

+(NSInteger)currentOniPhoneHeight;
+(NSInteger)currentNavigateHeight;
/**
 *@brief 竖屏显示的Frame
 */
+(CGRect)currentViewPortraitFrame;
+(CGRect)currentNoTabBarViewPortraitFrame;
/**
 *@brief 竖屏显示的WebView的Frame
 */
+(CGRect)currentWebViewPortraitFrame;
/**
 *@brief 选项卡的高度
 */
+(NSInteger)currentTabBarHeight;
+(NSInteger)leftMenuWidth;
+(NSInteger)rightSettingWidth;
+(NSInteger)leftColumnHeight;//左侧横条的高度
+(NSInteger)leftColumnWidth;//左侧横条的宽度
+(float)currentStateBarHeight;
+(NSInteger)currentOniPhoneHeight;
+(NSInteger)currentNavigateHeight;
/**
 *@brief 竖屏显示的Frame
 */
+(CGRect)currentViewPortraitFrame;
+(CGRect)currentNoTabBarViewPortraitFrame;
/**
 *@brief 竖屏显示的WebView的Frame
 */
+(CGRect)currentWebViewPortraitFrame;

/**
 *@brief 视图的起始位置的偏移
 */
+(NSInteger)topOffsetHeight;//顶部偏移的高度，在ios7以下为0，在ios7中为20
/**
 *@brief 网格视图每一格的宽度
 */
+(float)CollectionCellBoxWidth;

/**
 *@brief 网格视图每一格的高度
 */
+(float)CollectionCellBoxHeight;

/**
 *@brief 判断当前是否在iPhone上运行
 */
+(BOOL)isRunningOniPhone;

/**
 *@brief 判断当前是否在iPad上运行
 */
+(BOOL)isRunningOniPad;

/**
 *@brief 判断当前是否在iPod上运行
 */
+(BOOL)isRunningOniPod;

/**
 *@brief 返回值为当前运行的语言
 */
+(NSString *)isRunningOnLanguage;

/**
 *@brief 返回值为当前运行的系统值iOS6/iOS7中6或7
 */
+(NSInteger)currentVersion;



@end
