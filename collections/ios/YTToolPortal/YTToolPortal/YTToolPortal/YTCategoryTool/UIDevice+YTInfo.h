//
//  UIDevice+YTInfo.h
//  YTTool
//  获取设备相关信息
//  Created by Yutian Duan on 2018/12/10.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (YTInfo)

//! 获取 App Build 号
+ (NSString *)yt_appBuild;
//! 获取 App Version 号
+ (NSString *)yt_appVersion;
//! 获取 App 名称
+ (NSString *)yt_appName;
//! 获取 App BundleId
+ (NSString *)yt_bundleId;
//! 获取 App bundleName
+ (NSString *)yt_bundleName;

/*=========================================*/

//！获取 设备 系统号
+ (NSString *)yt_systemNo;

/*! 获取 设备 名称
 * 更新到 iPhoneXR
 */
+ (NSString *)yt_systemName;

//! 判断是否是 iPad
+ (BOOL)yt_isIpad;

//！ 唯一设备号
+ (NSString *)yt_keychainForImsi;

@end
