//
//  Common.h
//  MP4Play
//
//  Created by duanyutian on 15/3/19.
//  Copyright (c) 2015年 ZQWK. All rights reserved.
//

#ifndef MP4Play_Common_h
#define MP4Play_Common_h
//如果需要打印则打开下面连个宏定义
#define DEBUG_DATA 1
//#define DEBUG_NET 1

//系统版本的浮点值
#define OS_VERSION_FLOAT ([[[UIDevice currentDevice] systemVersion] floatValue])

/*使用Dlog在完成DLog功能的同时还可以打印函数名以及行数*/
#ifdef DEBUG_NET
#define DNetLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DNetLog(...)
#endif

#ifdef DEBUG_DATA
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define DEGRESS_TO_RADIANS(x) (M_PI*(x)/180.0)

/*屏幕的宽度和高度*/
#define SCREEN_CGSIZE_WIDTH  (DEVICE_IS_IPAD == 0 ? [[UIScreen mainScreen]bounds].size.width : ((OS_VERSION_FLOAT >= 8.0) ? [[UIScreen mainScreen]bounds].size.height : [[UIScreen mainScreen]bounds].size.width))
#define SCREEN_CGSIZE_HEIGHT (DEVICE_IS_IPAD == 0 ? [[UIScreen mainScreen]bounds].size.height : ((OS_VERSION_FLOAT >= 8.0) ? [[UIScreen mainScreen]bounds].size.width : [[UIScreen mainScreen]bounds].size.height))
/*屏幕的宽度和高度2*/
#define SCREEN_CGSIZE_2WIDTH [[UIScreen mainScreen]bounds].size.width
#define SCREEN_CGSIZE_2HEIGHT [[UIScreen mainScreen]bounds].size.height

//安全释放内存
#define RELEASE_SAFELY(__POINTER) {if(__POINTER){[__POINTER release];__POINTER=nil;}}
/*
 *  保存在NSUserDefualt中的字段
 */



#define COLOR_THEME1 ([UIColor redColor])//大红色
#define COLOR_THEME ([UIColor colorWithRed:26/256.0  green:168/256.0 blue:186/256.0 alpha:1])//去哪儿绿

//接收LED屏服务端广播IP的端口




////要进行通信的端口
//#define PORT_OF_TRANSCATION_PLAY 50111
////进行拦截IP的端口
//#define PORT_OF_GET_SERVICE_IP 50050
//
//
//#define PORT_OF_UPGRADE_SERVICE_IP 50101
//#define PORT_OF_TRANSCATION_SERVICE_IP 50100

/*
 *环境监测
 */

//环境监测器 获取环境控制参数
//亮度
#define Environment_Back_Light @"Environment_Back_Light"
//照度
#define Environment_Back_Lux @"Environment_Back_Lux"
//外部温度
#define Environment_Back_OutT @"Environment_Back_OutT"
//内部温度
#define Environment_Back_InT @"Environment_Back_InT"
//湿度
#define Environment_Back_Hum @"Environment_Back_Hum"
//风扇开启值
#define Environment_Fan_Open @"Environment_Fan_Open"
//风扇关闭值
#define Environment_Fan_Close @"Environment_Fan_Close"
//空调开启值
#define Environment_AirCondition_Open @"Environment_AirCondition_Open"
//空调关闭值
#define Environment_AirCondition_Close @"Environment_AirCondition_Close"
//最大亮度值
#define Environment_MaxLight @"Environment_MaxLight"
//最小亮度
#define Environment_MinLight @"Environment_MinLight"
//允许自动亮度控制
#define Environment_AutoLight @"Environment_AutoLight"
//允许自动风扇及空调控制
#define Environment_AutoAirCondition @"Environment_AutoAirCondition"
//强制手动
#define Environment_ForceHand @"Environment_ForceHand"
//Power1
#define Environment_Power1 @"Environment_Power1"
//Power2
#define Environment_Power2 @"Environment_Power2"
//Power3
#define Environment_Power3 @"Environment_Power3"
//Fan1
#define Environment_Fan1 @"Environment_Fan1"
//Fan2
#define Environment_Fan2 @"Environment_Fan2"
//采样速度
#define Environment_Speed @"Environment_Speed"
//灵敏度
#define Environment_Delicacy @"Environment_Delicacy"

/*
 *屏幕设置
 */
//打开箱体调整
#define ScreenSetting_openBoxSwitch @"ScreenSetting_openBoxSwitch"
//打开逐点校正
#define ScreenSetting_openCheckSwitch @"ScreenSetting_openCheckSwitch"
//锁定屏幕
#define ScreenSetting_lockScreenSwitch @"ScreenSetting_lockScreenSwitch"
//关闭屏幕
#define ScreenSetting_closeScreenSwitch @"ScreenSetting_closeScreenSwitch"
//水平起点
#define ScreenSetting_horizontal @"ScreenSetting_horizontal"
//垂直起点
#define ScreenSetting_vertical @"ScreenSetting_vertical"
//亮度
#define ScreenSetting_luminaceUISlider @"ScreenSetting_luminaceUISlider"
#define ScreenSetting_luminaceValueLabel @"ScreenSetting_luminaceValueLabel"
//对比度
#define ScreenSetting_contrastUISlider @"ScreenSetting_contrastUISlider"
#define ScreenSetting_contrastValueLabel @"ScreenSetting_contrastValueLabel"
//R
#define ScreenSetting_RUISlider @"ScreenSetting_RUISlider"
#define ScreenSetting_RValueLabel @"ScreenSetting_RValueLabel"
//G
#define ScreenSetting_GUISlider @"ScreenSetting_GUISlider"
#define ScreenSetting_GValueLabel @"ScreenSetting_GValueLabel"
//B
#define ScreenSetting_BUISlider @"ScreenSetting_BUISlider"
#define ScreenSetting_BValueLabel @"ScreenSetting_BValueLabel"
//色温设置
#define ScreenSetting_colorTUISlider @"ScreenSetting_colorTUISlider"
#define ScreenSetting_colorTValueLabel @"ScreenSetting_colorTValueLabel"



/*
 *在线监测
 */
//在线监测	发送卡信息获取
//发送卡序号
#define OnlineSC_Back_SVNS @"OnlineSC_Back_SVNS"
//硬件版本
#define OnlineSC_Back_HWVS @"OnlineSC_Back_HWVS"
//固件版本
#define OnlineSC_Back_FWVS @"OnlineSC_Back_FWVS"
//硬件状态
#define OnlineSC_Back_HWSS @"OnlineSC_Back_HWSS"
//DVI工作状态
#define OnlineSC_Back_DVIWSS @"OnlineSC_Back_DVIWSS"
//USB工作状态
#define OnlineSC_Back_USBWSS @"OnlineSC_Back_USBWSS"
//输入帧频
#define OnlineSC_Back_IFFS @"OnlineSC_Back_IFFS"
//输入分辨率
#define OnlineSC_Back_IDS @"OnlineSC_Back_IDS"
//输出帧频
#define OnlineSC_Back_OFFS @"OnlineSC_Back_OFFS"
//输出分辨率
#define OnlineSC_Back_ODS @"OnlineSC_Back_ODS"

//在线监测	接收卡详细信息获取
//接收卡数量
#define OnlineRC_Back_Amount @"OnlineRC_Back_Amount"
//接收卡所属屏号
#define OnlineRC_Back_RCBSS @"OnlineRC_Back_RCBSS"
//接收卡卡序号
#define OnlineRC_Back_RCCNS @"OnlineRC_Back_RCCNS"
//接收卡在屏中的行序号
#define OnlineRC_Back_RCBSRNS @"OnlineRC_Back_RCBSRNS"
//接收卡在屏中的列序号
#define OnlineRC_Back_RCBSCNS @"OnlineRC_Back_RCBSCNS"
//接收卡所在的屏的接收卡的总行数
#define OnlineRC_Back_RCBSARS @"OnlineRC_Back_RCBSARS"
//接收卡所在屏的接收卡的总列数
#define OnlineRC_Back_RCBSACNS @"OnlineRC_Back_RCBSACNS"
//端口号
#define OnlineRC_Back_RCPNS @"OnlineRC_Back_RCPNS"
//屏号
#define OnlineRC_Back_RCSNS @"OnlineRC_Back_RCSNS"
//硬件版本
#define OnlineRC_Back_RCHVS @"OnlineRC_Back_RCHVS"
//固件版本
#define OnlineRC_Back_RCFVS @"OnlineRC_Back_RCFVS"
//硬件状态
#define OnlineRC_Back_RCHSS @"OnlineRC_Back_RCHSS"
//错包数
#define OnlineRC_Back_RCWPS @"OnlineRC_Back_RCWPS"
//总包数
#define OnlineRC_Back_RCAPS @"OnlineRC_Back_RCAPS"
//是否连接箱体监控卡
#define OnlineRC_Back_RCCCCS @"OnlineRC_Back_RCCCCS"
//电源电压
#define OnlineRC_Back_RCPSS @"OnlineRC_Back_RCPSS"
//温度
#define OnlineRC_Back_RCTS @"OnlineRC_Back_RCTS"
//湿度
#define OnlineRC_Back_RCHS @"OnlineRC_Back_RCHS"
//烟雾
#define OnlineRC_Back_RCSS @"OnlineRC_Back_RCSS"
//箱门状态
#define OnlineRC_Back_RCDSS @"OnlineRC_Back_RCDSS"
//风扇转速
#define OnlineRC_Back_RCFSS @"OnlineRC_Back_RCFSS"
//风扇开关
#define OnlineRC_Back_RCFSwS @"OnlineRC_Back_RCFSwS"

//附属卡信息
//判断是属于 环境监测器/多功能卡
#define Online_Back_E_F_Equipment @"Online_Back_E_F_Equipment"
//端口号
#define OnlineAE_Back_AEPNS @"OnlineAE_Back_AEPNS"
//硬件版本
#define OnlineAE_Back_AEHVS @"OnlineAE_Back_AEHVS"
//固件版本
#define OnlineAE_Back_AEFVS @"OnlineAE_Back_AEFVS"
//硬件状态
#define OnlineAE_Back_AEHSS @"OnlineAE_Back_AEHSS"
//错包数
#define OnlineAE_Back_AEWPS @"OnlineAE_Back_AEWPS"
//总包数
#define OnlineAE_Back_AEAPS @"OnlineAE_Back_AEAPS"
//照度
#define OnlineAE_Back_AELS @"OnlineAE_Back_AELS"
//外部温度
#define OnlineAE_Back_AEOTS @"OnlineAE_Back_AEOTS"
//内部温度
#define OnlineAE_Back_AEITS @"OnlineAE_Back_AEITS"
//环境湿度
#define OnlineAE_Back_AEHS @"OnlineAE_Back_AEHS"



/*
 *高级配置
 */
//高级配置接收卡设置中文件的文件名字符串
#define ReceiveCard_Location @"ReceiveCard_Location"
//高级配置接收卡设置中文件的长度
#define Sender_Data_Length @"Sender_Data_Length"
//高级配置接收卡设置中文件的长度/1015 后打包的个数
#define Sender_Data_Package @"Sender_Data_Package"
//高级配置接收卡设置中文件的长度/1015 后打包的个数 从0~最大值时变化的值
#define Sender_Data_Package_CurrentValue @"Sender_Data_Package_CurrentValue"


//高级配置瓶体连接设置中文件的文件名字符串
#define ScreenLinking_Location @"ScreenLinking_Location"
//高级配置瓶体连接设置中文件的长度
#define ScreenLinking_Data_Length @"ScreenLinking_Data_Length"
//高级配置瓶体连接设置中文件的长度/1015 后打包的个数
#define ScreenLinking_Data_Package @"ScreenLinking_Data_Package"

//高级配置逐点校正中,文件的文件名字符串
#define PWA_Location @"PWA_Location"
//高级配置逐点校正设置中文件的长度
#define PWA_Data_Length @"PWA_Data_Length"
//高级配置逐点校正设置中文件的长度/1015 后打包的个数
#define PWA_Data_Package @"PWA_Data_Package"


//高级配置在线升级,文件的文件名字符串 包含bit和rbf两种类型
#define OnlineCheck_Location @"OnlineCheck_Location"
//高级配置在线升级设置中文件的长度
#define OnlineCheck_Data_Length @"OnlineCheck_Data_Length"
//高级配置在线升级设置中文件的长度/1015 后打包的个数
#define OnlineCheck_Data_Package @"OnlineCheck_Data_Package"
//高级配置在线升级中 判断文件的类型 为rbf-->1或bit-->0
#define OnlineCheck_Type @"OnlineCheck_Type"


//高级配置逐点校正左侧按钮  256L*256h 8bit/128L*128h 8bit/128L*128h 16bit/96L*96h 16bit  亮度校正
#define PWA_Left_Button @"PWA_Left_Button"

//高级配置逐点校正 文件类型  0--dat/1--lpdp16/2--txt/3--vu3
#define PWA_FileType @"PWA_FileType"

//高级配置逐点校正右侧按钮  全屏校正文件/箱体文件
#define PWA_Right_Button @"PWA_Right_Button"

//高级配置逐点校正右侧TextField  接收卡行
#define PWA_Right_H_TextField @"PWA_Right_H_TextField"
//高级配置逐点校正右侧TextField  接收卡列
#define PWA_Right_L_TextField @"PWA_Right_L_TextField"


//用户管理 用户名
#define Login_Accounts @"Login_Account"
//用户管理 用户密码
#define Login_Passwords @"Login_Password"


//用户名
#define MY_USER_ID @"MY_USER_ID"
//密码
#define MY_USER_PASSWORD @"MY_USER_PASSWORD"
//确认密码
#define MY_CONFIRM_PASSWORD @"MY_CONFIRM_PASSWORD"

//即为APPID
#define APPID @"910775669"


//判断语言
#define  LOCAL_LANGUAGE @"language"

//提示框弹出
#define  ALERT_TIPS @"AlertTips"
//未点击
#define  ALERT_TIPS_NOTCLICKED @"NotClicked"
//点击了
#define  ALERT_TIPS_CLICKED @"Clicked"

//记住账号的标记
#define  LOGIN_MARKER   @"Login_Marker"
//标记从哪里去登录界面
#define  Login_From @"Login_From"

//记录用户管理相关
//用户账号
#define UserAccountTextField @"UserAccountTextField"
//用户密码
#define UserPasswordTextField @"UserPasswordTextField"

//祥云历史记录
#define XClound_Histrory @"XClound_Histrory"
//版本信息
#define XCloud_Current_Version @"XCloud_Current_Version"

////XCloudManager管理器 名称
//#define XCloudManager_TerminalName @"XCloudManager_TerminalName"
////XCloudManager管理器 分辨率
//#define XCloudManager_TerminalResolution @"XCloudManager_TerminalResolution"
////XCloudManager管理器 地址
//#define XCloudManager_IPAddress @"XCloudManager_IPAddress"

//XCloudPlayer管理器 名称
#define XCloudPlayer_TerminalName @"XCloudPlayer_TerminalName"
//XCloudPlayer管理器 分辨率
#define XCloudPlayer_TerminalResolution @"XCloudPlayer_TerminalResolution"
//XCloudPlayer管理器 地址
#define XCloudPlayer_IPAddress @"XCloudPlayer_IPAddress"
//XCloudPlayer管理器 版本号
#define XCloudPlayer_Version @"XCloudPlayer_Version"

//判断连接到服务端的字段
#define ConnectToPlayer @"ConnectToPlayer"
#define NotConnectToPlayer @"NotConnectToPlayer"
#define ConnectToManager @"ConnectToManager"
#define NotConnectToManager @"NotConnectToManager"
//XCloudPlayer升级程序的版本号
#define XCloudPlayer_ProgramVersion @"XCloudPlayer_ProgramVersion"

//默认间隔时间
#define DEFAULT_TIME @"5"
#define I_DEFAULT_TIME 5

//检测到升级程序的通知
#define NOTI_UPGRADE_SIGNAL @"NOTI_UPGRADE_SIGNAL"

//项目文件
#define IS_PROJECT_XML @"PROJECT_XML"

//分组文件
#define IS_GROUP_XML @"GROUP_XML"








#define AUTOSCROLL @"开启自动滚动"

#define LOGIN_REGISTER_VIEW_WIDTH 540
#define LOGIN_REGISTER_VIEW_HEIGHT 620

//判断设备是否是iPad
#define DEVICE_IS_IPAD ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] &&[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//系统版本的浮点值
#define OS_VERSION_FLOAT ([[[UIDevice currentDevice] systemVersion] floatValue])


//调用APPStore评论、下载地址
#define URL_APPStore @"https://itunes.apple.com/cn/app/chipshow/id905247794?mt=8&uo=4"



//----------------------------------------------------------------------------
//各种高度和字体大小
//顶部标题的字体大小
#define FONT_SIZE_TITLE_LABEL 15
//中文按钮的字体大小
#define FONT_SIZE_BUTTON_TITLE [UIFont systemFontOfSize:15]
//视图之间的留白
#define GAP_VIEW_VIEW 30
//WebView中的字体的放大倍数的基础倍数
#define FONT_SIZE_HAPLOID_WEB_VIEW 300
#define FONT_SIZE_HAPLOID_WEB_VIEW_IPAD 150
//允许WebView中字体放大级别从0开始多少级,例如为2则可以两次放大,按第三次则回到初始值0
#define FONT_SIZE_HAPLOID_LEVEL 2
///*屏幕的宽度和高度*/
//#define SCREEN_CGSIZE_WIDTH [[UIScreen mainScreen]bounds].size.width
//#define SCREEN_CGSIZE_HEIGHT [[UIScreen mainScreen]bounds].size.height

//广告焦点图的在平板上的高度
#define MAIN_AD_MODEL_HEIGHT 300
//广告焦点图的在手机上的高度
#define MAIN_AD_MODEL_HEIGHT_IPHONE 150
//各种高度 结束

//-----------------------------------------------------------------------------
//接口
//更新用户信息
#define URL_UPDATE_USERINFOMATION @"http://www.ledmediasz.com/api_right/User_Edit.aspx"

#define URL_FOR_IP_OR_DOMAIN @"http://www.ledmediasz.com"
//广告接口
#define URL_ZDEC_GET_ADMODLE_LIST @"api_LED/LEDImageLink.aspx?companyid=2733"

//中文接口
#define URL_COMPANYID @"2733"
#define URL_INTERFACE_IMPORT @"http://www.ledmediasz.com/api_LED/LEDFirstStepAPI.aspx?companyid=2733&lang=cn&module=2"
//英文接口
#define URL_ENGLISH_MARK @"http://www.ledmediasz.com/api_LED/LEDFirstStepAPI.aspx?companyid=2733&lang=en&module=2"
//测试智能下拉keyword列表
#define URL_GET_KEYWORDS @"http://www.ledmediasz.com/api_LED/LED_KeyWords_API.aspx?keyword="
//产品搜索接口
#define URL_SEARCH_PRODUCTS @"http://www.ledmediasz.com/api_LED/LED_SearchIndex_API.aspx?lang=cn&module_id=15&keywords="
//C#中的英文路径的标示符
#define URL_ENGLISH_CSHARP_MARK @"&lang=en"
//C#中的中文路径的标示符
#define URL_CHINESE_CSHARP_MARK @"&lang=cn"

//实现跳转所需接口
//和屏体相关的图片数据
#define URL_PINGTI_IMAGES @"http://www.ledmediasz.com/API_yunping/api_show_screen.aspx?id="
//图片对应的屏体
#define URL_ITEM_URL @"http://www.ledmediasz.com/api_LED/LEDFourthStepAPI.aspx?itemid="


//--------------------论坛---------------------------------------------------------
//论坛模块接口
#define URL_BBS_MAIN @"http://www.ledmediasz.com/api_bbs/module_list.aspx?companyid=2287&lang=cn"
//主贴列表
#define URL_BBS_CONTENTLIST @"http://www.ledmediasz.com/api_bbs/Article_list.aspx?companyid=2287&lang=cn&typeid="//模块id
//主贴详细页面及评论
#define URL_BBS_CONTENT_FOLLOW @"http://www.ledmediasz.com/api_bbs/Article_list.aspx?companyid=2287&lang=cn&id="//contentid

//发贴
#define URL_BBS_SENDBBS @"http://www.ledmediasz.com/api_bbs/api_save_2bycontent.aspx?companyid=2733&lang=cn&source=iLEDSGIN&article_id=&item_id="
////主贴详细页面及评论（本地测试）
//#define URL_BBS_CONTENT_FOLLOW @"http://192.168.1.90/api_bbs/api_get2bycontentBySelf.aspx?companyid=2733&lang=cn&item_id="//contentid
////发贴
//#define URL_BBS_SENDBBS @"http://192.168.1.90/api_bbs/api_save_2bycontent.aspx?companyid=2733&lang=cn&source=iLEDSGIN&article_id=&item_id="
//--------------------论坛---------------------------------------------------------

////////////////////////登陆/////////////////////////////////////////////
//#define URL_ZDEC_LOGIN @"m/login"
#define URL_ZDEC_LOGIN @"api_right/Login_cn.aspx"
//登陆后获取用户信息
//#define URL_ZDEC_MAIN_GET_USERINFO @"m/main/key"
#define URL_ZDEC_MAIN_GET_USERINFO @"api_right/Main.aspx"
//修改密码
//#define URL_ZDEC_PASS_EDIT @"f/pass_edit/key"
#define URL_ZDEC_PASS_EDIT @"api_right/UpdatePassWord_cn.aspx"
//用户注册
//#define URL_ZDEC_REGISTER @"f/reg"
#define URL_ZDEC_REGISTER @"api_right/Regist_cn.aspx"
//退出登录
//#define URL_ZDEC_LOGOUT @"m/clear_alias/key"
#define URL_ZDEC_LOGOUT @"api_right/Login_Out.aspx"
//*修改右侧接口*
//公司的编号companyid
#define KEY_COMPANY_ID @"2733"
//提交时标示公司的参数cid
#define KEY_CID @"cid"
#define KEY_LOGIN_NUM @"num"
#define KEY_LOGIN_MAIL @"mail"
#define KEY_LOGIN_PASS @"pass"

#define USER_ALIAS @"user_alias"
#define USER_ROLE_ID @"role_id"

#define kLocalNotificationID @"kLocalNotificationID"·

//用户的基本数据
#define KEY_USER_HEADIMG @"user_headimg"
#define KEY_USER_NUM @"user_num"
#define KEY_USER_PHONE @"user_phone"
#define KEY_USER_MAIL @"user_email"
#define KEY_USER_NAME @"user_name"
#define KEY_USER_ALIAS @"user_alias"
#define KEY_USER_ROLE_ID @"role_id"
#define KEY_USER_STATUS @"user_status"
#define KEY_USER_ID @"user_id"
#define KEY_USER_CODE @"user_code"
#define KEY_USER_POSITION @"user_position"
#define KEY_USER_SIGN @"user_sign"
#define KEY_USER_COMPANY @"user_company"
#define KEY_USER_IS_ACTIVE @"user_is_active"
#define KEY_USER_QQ @"user_qq"
#define KEY_USER_DESCRIPTION @"user_sign"
////////////////////////登陆/////////////////////////////////////////////
//#define URL_ZDEC_LOGIN @"m/login"
#define URL_ZDEC_LOGIN @"api_right/Login_cn.aspx"
//登陆后获取用户信息
//#define URL_ZDEC_MAIN_GET_USERINFO @"m/main/key"
#define URL_ZDEC_MAIN_GET_USERINFO @"api_right/Main.aspx"
//修改密码
//#define URL_ZDEC_PASS_EDIT @"f/pass_edit/key"
#define URL_ZDEC_PASS_EDIT @"api_right/UpdatePassWord_cn.aspx"
//用户注册
//#define URL_ZDEC_REGISTER @"f/reg"
#define URL_ZDEC_REGISTER @"api_right/Regist_cn.aspx"
//退出登录
//#define URL_ZDEC_LOGOUT @"m/clear_alias/key"
#define URL_ZDEC_LOGOUT @"api_right/Login_Out.aspx"
//*修改右侧接口*
//公司的编号companyid
#define KEY_COMPANY_ID @"2733"
//提交时标示公司的参数cid
#define KEY_CID @"cid"
#define KEY_LOGIN_NUM @"num"
#define KEY_LOGIN_MAIL @"mail"
#define KEY_LOGIN_PASS @"pass"

#define USER_ALIAS @"user_alias"
#define USER_ROLE_ID @"role_id"



//用户的基本数据
#define KEY_USER_HEADIMG @"user_headimg"
#define KEY_USER_NUM @"user_num"
#define KEY_USER_PHONE @"user_phone"
#define KEY_USER_MAIL @"user_email"
#define KEY_USER_NAME @"user_name"
#define KEY_USER_ALIAS @"user_alias"
#define KEY_USER_ROLE_ID @"role_id"
#define KEY_USER_STATUS @"user_status"
#define KEY_USER_ID @"user_id"
#define KEY_USER_CODE @"user_code"
#define KEY_USER_POSITION @"user_position"
#define KEY_USER_SIGN @"user_sign"
#define KEY_USER_COMPANY @"user_company"
#define KEY_USER_IS_ACTIVE @"user_is_active"
#define KEY_USER_QQ @"user_qq"
#define KEY_USER_DESCRIPTION @"user_sign"

//----------------------------------------------------------------------------
//tag值
#define TAG_URL_ZDEC_GET_ADMODLE_LIST 10000 //主界面获得广告数据的索引
#define TAG_FIRST_PAGE_MY_PROGRESS 10001 //数据加载等待时的进度条
#define TAG_FIRST_MENU_DATA_REQUEST 10002 //获取一级菜单的请求
#define TAG_YGP_SEGMENTED_CONTROLLER 10003 //顶部水平滚动菜单
#define TAG_NEWS_TABLE_VIEW 10004 //新闻表格视图
#define TAG_ONE_PAGE_DATA 10005 //列表页面的一页数据请求
#define TAG_PROGRESS 10006 //详细页面加载进度条
#define TAG_CALCULATOR 10007 //显示计算器
#define TAG_VIEDO_DOWNLOAD_START 10008 //视频下载页开始tag
#define TAG_HISTORY_TABLEVIEW 10009 //搜索历史列表
#define TAG_KEYWORDS_TABLEVIEW 10010 //关键字智能列表
#define TAG_AD 10011 //广告视图
#define TAG_REFRESH_BUTTON 10012 //刷新按钮
///////////////////视频//////////
//视频
#define TAG_VIDEOLIST_TITLE_BUTTON 200288 // 视频播放列表的标题
#define TAG_MYTOOLBAR 200488 //工具栏的TAG基数
//状态栏的状态
#define STATUS_BAR_STAT @"StatusBarStat"
//改变顶部状态栏的状态
#define NOTI_CHANGE_STATUSBAR_STATE @"NOTI_CHANGE_STATUSBAR_STATE"
#define TAG_MOVIE_PLAY_VIEW 230000 //视频播放的视图
#define TAG_ZOOM_IN_BUTTON 230010 //放大视频的按钮
#define TAG_ZOOM_OUT_BUTTON 230020 //缩小视频的按钮
#define TAG_MOVIE_PLAY_CONTAINT_VIEW 230030 //视屏播放器的容器
#define TAG_TOP_NAVGATION_VIEW 230040 //顶部返回导航视图
#define TAG_MOVIE_LIST_CONTAINT_VIEW 230050 //视屏列表的视图
#define TAG_BOTTOM_TOOL_BAR 221000 //视图底部的toolBar
#define TAG_TOP_TOOL_BAR 224000 //视图顶部的toolBar
#define TAG_REFRESH_VIEW 229100 //一级菜单的刷新视图

#define TAG_RQUEST_GET_USERINFO 200007 //用户个人信息请求
#define TAG_USER_NAME_TEXTFIELD 220000 //登陆窗口中用户名输入框


#define NOTI_CHANGE_FONT_SIZE @"NOTI_CHANGE_FONT_SIZE"
#define NET_STATUS_WIFI @"WiFi"
#define NET_STATUS_WLAN @"3G/2G"
#define NET_STATUS_OFF @"Off"

//视频数据的JSON中的KEY
#define KEY_VIDEO_TITLE @"title"
#define KEY_VIDEO_VIDEO_URL @"video_url"

#define DEFAULT_HEAD_IMAGE @"frontheadbar.png"

//////////////////////////////////////////通知/////////////////////////////////////////
#define NOTI_CHANGE_BUTTONCOLOR @"NOTI_CHANGE_BUTTONCOLOR"
//YXM MODIFY 通知 所有的通知全部放在下面
#define NOTI_UPDATE_USER_INFORMATION @"UPDATE_USER_INFORMATION"
#define NOTI_ADD_PRODUCTION @"NOTI_ADD_PRODUCTION"
#define NOTI_CHANGE_HEADVIEW @"NOTI_CHANGE_HEADVIEW"
#define NOTI_REFRESH_COLLECT @"NOTI_REFRESH_COLLECT"
#define NOTI_CHANGE_MENU @"NOTI_CHANGE_MENU"
#define NOTI_CHANGE_ACCOUNT_HEADVIEW @"NOTI_CHANGE_ACCOUNT_HEADVIEW"
#define NOTI_DOWNLOAD_HEADVIEW @"NOTI_DOWNLOAD_HEADVIEW"
#define NOTI_CHANGE_SALEBUTTON @"NOTI_CHANGE_SALEBUTTON"
#define NOTI_CHECK_BOX @"NOTI_CHECK_BOX"
//有新消息的时候通知消息显示列表刷新
#define NOTIF_REFRESH_MESSAGELIST_MSG @"NOTIF_REFRESH_MESSAGELIST_MSG"
//有新服务申请
#define NOTIF_REFRESH_NewserviceApplyList_MSG @"NOTIF_REFRESH_NewserviceApplyList_MSG"
//有新的投诉
#define NOTIF_REFRESH_NewComplainList_MSG @"NOTIF_REFRESH_NewComplainList_MSG"
//刷新投诉的提示信息
#define NOTIF_REFRESH_NewComplainBadgeView_MSG @"NOTIF_REFRESH_NewComplainBadgeView_MSG"
//销售员有新消息
#define NOTIF_REFRESH_NewSaleMessageList_MSG @"NOTIF_REFRESH_NewSaleMessageList_MSG"
//提交维修或者远程、技术之后返回上级目录之后弹出提示框
#define NOTI_SHOW_TOASTVIEW @"NOTI_SHOW_TOASTVIEW"
//提交投诉之后返回上级目录弹出提示框
#define NOTI_SHOW_COMPLAIN_TOASTVIEW @"NOTI_SHOW_COMPLAIN_TOASTVIEW"
//注册返回提示
#define NOTI_SHOW_LOGIN_SUCCESS_TOASTVIEW @"NOTI_SHOW_LOGIN_SUCCESS_TOASTVIEW"
//更新服务中心菜单下的中庆一下菜单上的badgeview
#define NOTI_UPDATE_MYBADGEVIEW_STATE @"NOTI_UPDATE_MYBADGEVIEW_STATE"
//更新联系人列表
#define NOTIF_REFRESH_my_MessageList_MSG @"NOTIF_REFRESH_my_MessageList_MSG"
//添加好友的通知提醒
#define NOTI_ADD_FRIEND_ALERT @"NOTI_ADD_FRIEND_ALERT"
//新消息来通知最近联系人列表
#define NOTIF_REFRESH_my_MessageList_badge_MSG @"NOTIF_REFRESH_my_MessageList_badge_MSG"
#define NOTI_SHOW_TOASTVIEW_PUSH_R @"NOTI_SHOW_TOASTVIEW_PUSH_R"

//改变顶部状态栏的状态
#define NOTI_CHANGE_STATUSBAR_STATE @"NOTI_CHANGE_STATUSBAR_STATE"
#define NOTI_CHANGE_FONT_SIZE @"NOTI_CHANGE_FONT_SIZE"
#define NOTI_SEND_GETFIRSTPAGE_REQUEST @"NOTI_SEND_GETFIRSTPAGE_REQUEST"
//刷新一级目录的请求
#define NOTI_REFRESH_FIRST_MENU_DATA @"NOTI_REFRESH_FIRST_MENU_DATA"
//打开或关闭设备的自动旋转
#define NOTI_CHANGE_AUTOROTATE @"NOTI_CHANGE_AUTOROTATE"
//横屏时设置根View的Frame
#define NOTI_ROOT_VIEW_FRAME_CHANGE @"NOTI_ROOT_VIEW_FRAME_CHANGE"
//隐藏提示按钮
#define NOTI_HIDDEN_MYBADGEVIEW @"NOTI_HIDDEN_MYBADGEVIEW"
//YXM MODIFY 通知 所有的通知全部放在上面



/*****************************************************************************/
/*********************************计算器**********************************/
/*****************************************************************************/

#define NOTIF_REFRESH_CALCULATOR_LIST @"NOTIF_REFRESH_CALCULATOR_LIST"
//计算器中的显示的字体
#define FONT_CALCULATOR 12
//计算器输入值的最小值
#define MIN_SCRENN_NUM 1
//计算器输入值的最大值
#define MAX_SCRENN_NUM 50

/*减号按钮图片*/
#define  NewSubtraction @"NewSubtraction.png"
/*加号按钮图片*/
#define  NewIncrease @"NewIncrease.png"

/*选屏计算器的主界面的cell背景图*/
#define CALCULATOR_TABLECELL_BG @"calculatorTableCellBg.png"

/*公制单位*/
#define  UNIT_STRING @"unit_String"
#define  METRIC @"metric"
#define  IMPERIAL @"imperial"

/*屏体的 公制 长度单位为 m */
#define  METRIC_Unit_Case_Length @"m"
/*箱体的 公制 长度单位为 mm */
#define  METRIC_Unit_Box_Length @"mm"
/*屏体的 公制 质量单位为 kg */
#define  METRIC_Unit_Case_Weight @"kg"
/* 公制 功率单位*/
#define  METRIC_Unit_Power @"W/sqm"
/* 公制 面积单位*/
#define  METRIC_Unit_Area @"sqm"

/*屏体的 英制 长度单位为 m */
#define  IMPERIAL_Unit_Case_Length @"ft"
/*箱体的 英制 长度单位为 mm */
#define  IMPERIAL_Unit_Box_Length @"ft"
/*屏体的 英制 质量单位为 kg */
#define  IMPERIAL_Unit_Case_Weight @"pounds"
/* 英制 功率单位*/
#define  IMPERIAL_Unit_Power @"W/sqft"
/* 英制 面积单位*/
#define  IMPERIAL_Unit_Area @"sqft"
/*********************************计算器**********************************/


//#define AUTOSCROLL @"开启自动滚动"
#define LOGIN_REGISTER_VIEW_WIDTH 540
#define LOGIN_REGISTER_VIEW_HEIGHT 620

//拾取器的类型
#define ASSET_TYPE_PHOTO @"PHOTO"
#define ASSET_TYPE_VIDEO @"VIDEO"

//struct VideoScale
//{
//    float ws;
//    float hs;
//};


//设计师相关作品对应接口
#define URL_DESIGNER_PRODUCTS @"http://www.ledmediasz.com/api_yunping/api_showUserMessage.aspx?userid="

//按点击量排列行业顺序
#define URL_ITEM_CLICK @"http://www.ledmediasz.com/api_LED/LEDSecondByHitsStepAPI.aspx?column_id="







// 动画持续时间(秒)
#define kDuration 0.7
//是否打印播放的日志
#define PLAY_LOG 1
#define CURRENT_LOG 1
//每个区域上表示范围的label
#define TEST_MODE 1
#define CURRENT_MODE 2
//是否打印发布日志
#define PRINT_LOG 1
//当前打印日志
#define CURRENT_PRIENT_LOG 1

//百叶窗的叶子的粗细程度，从根据把图片分成的份数来确定，2最大=分成2份，数字越大分得越细
#define BAIYECHUANG_YEKUAN 5

//文字播放区域的标示
#define VIEW_TAG_TEXT_AREA_1005 1005
//背景播放区域的tag
#define VIEW_TAG_EDITOR_1004 1004
//前景播放区域的tag
#define VIEW_TAG_EDITOR_1006 1006


//可编辑区域设定文本框X
#define REGION_TAG_EDITOR_2001 2001
//可编辑区域设定文本框Y
#define REGION_TAG_EDITOR_2002 2002
//可编辑区域设定文本框W
#define REGION_TAG_EDITOR_2003 2003
//可编辑区域设定文本框H
#define REGION_TAG_EDITOR_2004 2004
//设置屏幕高度W
#define REGION_TAG_EDITOR_2005 2005
//设置屏幕宽度H
#define REGION_TAG_EDITOR_2006 2006

//可编辑区的选择索引的非选择时的默认值,一个无法命中的值
#define TAG_NO_SELECT_AREA 1000000000
#define TAG_MAX_NUMBER 1000000000
//图片视图的tag
#define TAG_REGION_LABEL 83500
//设置区域的根视图
#define TAG_EDIT_CONTROLLER_VIEW 100500
//设置区域
#define TAG_REGION_SETTINGS_VIEW 100501

//设置Region
#define TAG_REGION_TAG_LABEL 100502
//图片视图的tag
#define TAG_IMAGE_VIEW 200502


//控制按钮容器
#define TAG_CONTROL_BUTTON_VIEW 300100
//region设置功能按钮
#define TAG_SETTIONG_REGION_BUTTON 300502
//保存项目按钮
#define TAG_SAVE_PROJECT_BUTTON 300602
//文字编辑按钮
#define TAG_TEXT_EDIT_BUTTON 300702
//item 子项设置按钮
#define TAG_ITEM_SETTING_BUTTON 300802

//// 子项
#define TAG_SUBITEM_LIST_VIEW 400502

//文字编辑区域
#define TAG_TEXT_REGION_SETTING_VIEW 500502

//项目设置
#define TAG_PROJECT_SETTING_VIEW 600502

//编辑图片
#define TAG_PLAY_LIST_VIEW 600802

//设置图片播放间隔时间
#define TAG_PLAY_ONE_DURATION_BUTTON 700802

//项目名称
#define TAG_PROJECT_NAME_TEXTFIELD 800802

//项目列表
#define TAG_PROJECT_LIST_VIEW 1010100

//文字编辑区域
#define TAG_TEXT_AREA_LABEL 2010100

//保存文字按钮
#define TAG_SAVE_TEXT_BUTTON 2010101



//保存项目
#define TAG_SAVE_AS_BUTTON 701000

//退出播放模式
#define TAG_QUIT_PLAY_BUTTON 702000

//删除项目
#define TAG_DELETE_PROJ_BUTTON 2020101

//删除多个项目

#define TAG_DELETF_GROPS_BUTTON 2020111

//播放的速度
#define TAG_ROLLING_SPEED_TEXT 2030101

//改变文字颜色按钮
#define TAG_CHANGE_COLOR_BUTTON 2040101

//改变文字背景颜色按钮
#define TAG_CHANGE_TEXT_BACK_GROUND_COLOR_BUTTON 2040201

//颜色的标签值 ：红、绿、蓝、透明值
#define TAG_RED_COLOR_LABEL 2040206
#define TAG_GREEN_COLOR_LABEL 2040207
#define TAG_BLUE_COLOR_LABEL 2040208
#define TAG_ALPHA_COLOR_LABEL 2040209

//字体大小
#define TAG_FONT_SIZE_TEXT 2040310

//发布项目
#define TAG_PUBLISH_PROJ_BUTTON 2060310

//重新连接网络
#define TAG_RECONNECT_ALERTVIEW 2060410

//编辑项目按钮
#define TAG_EDIT_PROJ_BUTTON 2060510

//是否重复加载素材的弹出框
#define TAG_IS_REPATED_LOAD 2060511

//主屏幕的现实范围的设定
#define TAG_MASTER_REGION_SETTINGS_VIEW 2060610

//主屏幕的区域
#define TAG_MASTER_SCREEN_VIEW 2070100

//正在加载的标记
#define IS_LOADED_MATRIAL @"IS_LOADED_MATRIAL"

//已经加载的标记
#define IS_ALREADY_LOAD_MATRIAL @"IS_ALREADY_LOAD_MATRIAL"

//加载默认素材的按钮
#define TAG_LOAD_DEFAULT_IMAGE_BUTTON 2070200

//添加选择字体的下拉框
#define TAG_ROLLING_FONT_TEXT 2070300

//是否提示应该退出编辑
#define TAG_IS_EDITING_PROJECT_ALERT 2070400

//项目列表中放置误操作的蒙版
#define TAG_MAKE_OPACITY_MASK 2070500
//判断是否是数字
#define isdigit(__c__) ((unsigned char)((signed char)(__c__) - '0') < 10)

//屏幕最大的高度
//H1024
#define MAX_MASTERSCREEN_HEIGHT 2048
//屏幕最大的宽度
//W1024
#define MAX_MASTERSCREEN_WIDTH 2048
//按钮上的字号大小
#define BUTTON_TITILE_FONT 14

//后场景
#define TAG_BEHIND_SCENE_BUTTON 3010100
//前场景
#define TAG_BEFORE_SCENE_BUTTON 3010200
//后场景层tag
#define TAG_BEFORE_PLAY_LIST_VIEW 3010300
//后景运动的时间
#define TAG_BEFORE_PLAY_ONE_DURATION_BUTTON 3010400
//前景图的图片容器
#define TAG_BEFORE_IMAGEVIEW 3020100
//后景图的图片容器
#define TAG_BEHIND_IMAGEVIEW 3020101

//从上往下
#define UP_TO_DOWN @"1"
//从右往左
#define RIGHT_TO_LEFT @"2"
//从下网上
#define DOWN_TO_UP @"3"
//从左往右
#define LEFT_TO_RIGHT @"4"
//无动画
#define NO_ANIMATION @"0"
//左右收缩
#define UP_DOWN_SHRINK @"5"
//上下收缩
#define RIGHT_LEFT_SHRINK @"6"
//盒状收缩
#define SHRINK @"7"
//盒状展开
#define UNFOLD @"8"


//更多功能视图

#define TAG_MY_MORE_RUNC_VIEW 3020200
//更多功能视图上的返回按钮
#define TAG_MY_MORE_RUNC_VIEW_BACKBUTTON 3020300
//更多功能视图上的删除按钮
#define TAG_MY_MORE_RUNC_VIEW_DELETE_BUTTON 3020301
//更多功能视图的子视图
#define TAG_MY_MORE_RUNC_SUBVIEW 3020400
//更多功能视图中方向选择下拉框
#define TAG_MY_MORE_DIRECTION_SELECT 3020500
//设置默认宽高为160X640
#define TAG_DEFAULT_REGION_BUTTON 3020600
//图片滚动播放的间隔时间
#define PIC_SWITCH_DURATION @"2"
//文字滚动的速度
#define TXT_ROLLING_SPEED @"2"
//搜索按钮
#define TAG_SEARCH_PUBLISH_PROJ_BUTTON 3020700
//搜索框
#define TAG_SEARCH_PUBLISH_PROJ_TEXTFIELD 3020800
//搜索的进度指示器
#define TAG_SEARCH_INDICATOR_VIEW 3020900
//创建分组按钮的文字
#define TAG_CREATE_GROUP_BUTTON 3030100

//删除分组按钮的文字  多个删除
#define TAG_Delete_GROUP_BUTTON  3030200

//项目分组输入弹出框
#define TAG_ALTERVIEW_GROUPNAME_INPUT 3030101
//黑色遮罩层-水平
#define TAG_BLACK_SHADE_VIEW 3030102
//黑色遮罩层-垂直
#define TAG_BLACK_VERTICAL_SHADE_VIEW 3030103
//预览时候的黑色遮罩
#define TAG_PREVIEW_SHADEVIEW 3030104
//  反选
#define TAG_REST_SCREEN_AS_BUTTON 3030105
//全选
#define TAG_Project_Save_All_BUTTON 3030205
//重置

#define TAG_REST_LED_AS_BUTTON 30303005


//提示框
#define TAG_ALTERVIEW_TAG_REST_SCREEN_AS_BUTTON 3030106
////增加窗口按钮
#define TAG_MAKE_ROTATION_REGION_BUTTON 3030107
//编辑音频的面板
#define TAG_MUSIC_EDIT_BUTTON 3030108
//音频设置视图
#define TAG_MUSIC_SETTING_VIEW 3030109
//清理音频
#define TAG_CLEAR_MUSIC_BUTTON 3030110
//音频信息视图
#define TAG_MUSIC_INFO_VIEW 3030111
//确认清除素材列表
#define TAG_IS_CLEAR_IMAGE_LIST_ALERT 3030112
//应用按钮
#define TAG_APPLY_REGION_BUTTON 3030113
//进度条
#define TAG_MRPROGRESS_VIEW 3030114
//视频编辑
#define TAG_VIDEO_EDITER_BUTTON 3030115
//导航条的高度
#define NAVIGATION_BAR_HEIGHT 0
//底部状态条
#define TAG_MYSTATEBAR_VIEW 3030116
//底部状态条的高度
#define HEIGHT_OF_BUTTOM_BAR 44
//尝试改变传输协议的tag
#define TAG_IS_TRANS_TYPE_ALERT 3030117
#define TAG_UP_MASK_VIEW 3030118
#define TAG_DOWN_MASK_VIEW 3030119
#define TAG_LEFT_MASK_VIEW 3030120
#define TAG_RIGHT_MASK_VIEW 3030121
//重置云屏的提示
#define TAG_REST_SCREEN_ALERT 3030122
//更多功能视图中是否透明选择下拉框
#define TAG_MY_MORE_ALPHA_SELECT 3030123
////设置快捷设置
#define TAG_BRIGHTNESS_REGION_BUTTON 3030124
//关机
#define TAG_GUANJI_REGION_BUTTON 3030125
//云屏项目
#define TAG_SCREEN_PLAYLIST_BUTTON 3030126
//播放项目列表界面的segment编号
#define TAG_PROJECTS_ID @"1234888"








#endif
