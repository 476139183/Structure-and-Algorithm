//
//  NSString+MD5.h
//  DianXiaoEr
//
//  Created by 兴满 易 on 13-6-26.
//  Copyright (c) 2013年 YiXingMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "Config.h"
@class DataCategories;
@interface MyTool : NSObject

/**
 *@brief 重新设置图片的大小
 */
+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size;

/**
 *@brief 设置导航栏上的文字
 */
+(UILabel *)titleView:(NSString *)titleName font:(UIFont *)myFont;

/**
 *@brief 根据两个点的经纬度计算两个点距离
 */
+(double)distanceBetweenOrderByLat1:(double)lat1 Andlng1:(double)lng1 Lat2:(double)lat2 Lng2:(double)lng2;

/**
 *@brief 根据时间戳计算出日期
 */
+(NSString*)TimestampToDate:(NSString*)timestamp;


/**
 *@brief 根据时间戳计算出日期加时间
 */
+(NSDate*)TimestampToDateAndTime:(NSString*)timestamp;

/**
 *@brief 角度转换为弧度
 */
+(double)radians:(float)degrees;

/**
 *@brief 写入JSON和Html文件，存储在Documents/Caches
 */
+(void)writeCacheRequestUrl:(NSString*)url;
/**
 *@brief 读取JSON和Html文件，存储在Documents/Caches，返回NSdata类型
 */
+(NSData*)readCacheData:(NSString*)urlStr;

/**
 *@brief 读取SDWebImage的缓存文件，存储在Library/Caches/ImageCache，返回NSdata类型
 */
+(NSData*)readImageCache:(NSString*)urlStr;

/*
 *获取存储的文件路径
 */
+(NSString*)fileExistsCacheFile:(NSString*)urlStr;
/**
 *@brief 读取JSON和Html文件，存储在Documents/Caches，返回NSString类型
 */
+(NSString*)readCacheString:(NSString*)urlStr;
/**
 *@brief 判断缓存文件是否存在
*/

/**
 *@判断视频的文件路径是否有视频
 */
+(BOOL)isExistsVideoFile:(NSString*)urlStr;
/**
 *@返回视频的文件路径
 */
+(NSString *)getVideoFilePath:(NSString*)urlStr;


+(BOOL)isExistsCacheFile:(NSString*)urlStr;
/**
 *@brief 获得SDWebImage的图片存储路径
 */
+(NSString*)getSDWebImageFilePath:(NSString*)filepath;

/**
 *@brief 写入图片到SDWebImage的图片存储目录下
 */
+(void)writeImageCache:(NSData*)imageData requestUrl:(NSString*)url;
/**
 *@brief 根据图片网络路径写入图片到SDWebImage的图片存储目录下
 */
+(void)writeImageCacheRequestUrl:(NSString*)url;

/**
 *@brief 获得当前的时间，例如2013-08-11 16:05:03
 */
+(NSString*)getCurrentDateString;


+(void)writeCalculImageCache:(NSData*)imageData requestUrl:(NSString*)url;

/**
 *@brief 根据图片的URL地址返回图片UIImage对象
 */
+(UIImage*)readCalculImageCache:(NSString*)urlStr;

/**
 *@brief 判断用户的key是否存在，存在则表示登陆成功，存在返回YES，不存在返回NO
 */
+(BOOL)CheckIsLogin;

+(void)writeCache:(NSString *)responseStr requestUrl:(NSString*)url;

/**
 *@brief 到appStore更新app版本的方法;需要传入是否是手动更新
 */
+(BOOL)updateApp;

/**
 *@brief 在状态栏提示网络连接错误
 */
+(void)onStatusBarAlertNetError;

/**
 *@brief 在状态栏提示通知上传错误错误
 */
+(void)onStatusBarAlertNotificationError;


/**
 *@brief 传入一个图片用于放大
 */
+(void)showImage:(UIImageView *)avatarImageView;


/**
 *@brief 获得应用的沙盒路径
 */
+ (NSString *)applicationDocumentsDirectory;


+(void)alertViewLoginSender:(id)sender Andtitle:(NSString*)title Andmessage:(NSString*)message;

/**
 *@brief url中有中文的情况使用此方法转为UTF-8
 */
+(NSString*)stringCovertToUTF8:(NSString *)urlString;

/**
 *@brief 性别的代码与字符串之间的转换
 */
+(NSString*)sexCodeCovertString:(NSString*)sexCode;

///**
// *@brief 时间字符串转时间戳
// */
//+(NSString*)dateNSStringToTimestamp:(NSString*)dateNSString;

/**
 *@brief 判断字符串是否全部为数字
 */
+(BOOL)stringIsDigit:(NSString*)inputStr;


/**
 *@brief 判断设备是否是iPhone
 */
+(BOOL)CheckDeviceIsiPhone;


/**
 *@brief 判断设备是否是iPad
 */
+(BOOL)CheckDeviceIsiPad;


/**
 *@brief 判断设备是否是iPod
 */
+(BOOL)CheckDeviceIsiPod;

/**
 *@brief 过滤请求返回的数据中的非法字符
 */
+(NSString*)filterResponseString:(NSString*)responseString;

/**
 *@brief 写入缓存文件
 */
+(void)writeCacheFile:(NSData *)buffer;

/**
 *@brief 重置窗口的frame
 */
+(void)resetWindowFrame;

/**
 *@brief 判断是否是11位手机号码
 */
+(BOOL)localRegexPhone:(NSString *)phoneNumberString;

/**
 *@brief 判断输入的时email还是手机号码
 */
+ (BOOL)localRegexEmail:(NSString *)emailString;

/**
 *@brief 在视图的底部插入toolBar
 */
+(void)insertBottomToolBar:(UIViewController *)containtController;

/**
 *@brief 在视图顶部插入工具栏作为导航条
 */
+(void)insertTopNavToolBar:(UIViewController *)containtController;

/**
 *@brief 修改html代码的内容
 */
+(void)changeWebView:(UIWebView *)newWebView HtmlContentTextSizeAdjust:(int)textSizeAdjust;


/**
 *@brief 添加shareSDK的引用到指定视图
 */
+(void)insertShareSDKButton:(UIViewController *)containtViewController;



/**
 *@brief 在视图顶部插入返回的导航条
 */
+(void)insertTopNavgationView:(UIViewController *)containtViewController titleString:(NSString *)titleString topOffSet:(NSInteger)topOffSet;

/**
 *@brief 加载一级目录的数据
 */
+(void)getFirstMenuData:(UIViewController *)containtCtrl;

/**
 *@brief 判断返回的字符串是否表示异地登陆
 */
+(BOOL)accountOtherLogin:(NSString *)responseString;


/**
 *@brief 如果数据刷新失败则增加刷新按钮;
 *       需要在增加此方法的Controller里加入refreshDataButtonClick方法
 */
+(void)insertRefreshDataButton:(UIView *)containtView containtCtrl:(UIViewController *)containtCtrl;


/**
 *@brief 开始进度条
 */
+(void)startProgress:(UIViewController *)containtCtrl;


/**
 *@brief 停止进度条
 */
+(void)stopProgress:(UIViewController *)containtCtrl;

/**
 *@brief 请求二级菜单数据,
 *       传入数据加载失败和数据加载成功的回调函数的拥有者,
 *       拥有者必须实现的方法
 * -(void)queueFetchFailed:(ASIHTTPRequest *)request;
 * -(void)queueFetchFinished:(ASIHTTPRequest *)request;
 */
+(void)getSecondMenuData:(UIViewController *)containtCtrl oneDataCategory:(DataCategories *)oneDataCategory;

/**
 *@brief 取得路径的语言后缀
 */
+(NSString *)getURLLangSuffix;

/**
 *@brief 改变导航栏的颜色
 */
+(void)changeNavgationBarColor:(UIViewController *)containtCtrl;

/**
 *@brief 导航视图切换器
 */
+(CATransition *)viewSwitcher:(NSString *)animationType owner:(UIViewController *)ownerController transitionFromStyle:(NSString *)transitionFromStyle;

/**
 *@brief 判断一个类中的方法是否可以被调用
 */
+(SEL)filterSelector:(SEL)selectorName target:(UIViewController *)target;

/**
 *@brief 获取名片的二级目录
 */
+(void)getNameCardData:(UIViewController *)containtCtrl;

/**
 *@brief 清除通知
 */
+(void)clearRmoteNotification;

/**
 *@brief 格式化发布的时间
 */
+ (NSString *) transTimeSp:(NSString *) time;

/**
 *@brief 判断一个路径是否是图片路径
 */
+(BOOL)isImagePath:(NSString *)imangePath;

/**
 *  验证像素值是否在20到2048之间
 *
 *  @param iPixle 传入像素值
 *
 *  @return 返回布尔值
 */
+(BOOL)validatePixleValue:(NSInteger)iPixle;

/**
 *  对角线长度计算
 *
 *  @return 对角线长度
 */
+(float)diagonalCalculateWithA:(float)a andB:(float)b;


/**
 *  根据对角线的长度和宽高比来计算矩形的高度
 *
 *  @param dia   对角线长度
 *  @param scale 宽高比
 *
 *  @return 矩形的高度
 */
+(float)heightCalculateWithDiagonal:(float)dia andhwScale:(float)scale;

/**
 *  根据对角线的长度和宽高比来计算矩形的宽度
 *
 *  @param dia   对角线长度
 *  @param scale 宽高比
 *
 *  @return 矩形的宽度
 */
+(float)widthCalculateWithDiagonal:(float)dia andhwScale:(float)scale;

/**
 *@brief 写入Video文件，存储在Documents/VideoFile目录下
 */
+(void)writeVideoCacheRequestUrl:(NSString*)url;
@end
