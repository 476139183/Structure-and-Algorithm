//
//  UIDevice+YTInfo.m
//  YTTool
//
//  Created by Yutian Duan on 2018/12/10.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "UIDevice+YTInfo.h"

#include <sys/types.h>
#include <sys/sysctl.h>

//! 设置你的钥匙串关键字
static NSString *KeyChainIdentifier = @"YouKey";

@implementation UIDevice (YTInfo)

//! 获取 App build 号
+ (NSString *)yt_appBuild {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

//! 获取 App version 号
+ (NSString *)yt_appVersion {
  return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//! 获取app 名称
+ (NSString *)yt_appName {
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
  return app_Name;
}

//! 获取app BundleId
+ (NSString *)yt_bundleId {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

//! 获取app bundleName
+ (NSString *)yt_bundleName {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

/*=========================================*/

//！获取 设备 系统版本号
+ (NSString *)yt_systemNo {
  return [[UIDevice currentDevice] systemVersion];
}

/*! 获取 设备 名称
 * 更新到 iPhoneXR
 */
+ (NSString *)yt_systemName {
  int mib[2];
  size_t len;
  char *machine;
  
  mib[0] = CTL_HW;
  mib[1] = HW_MACHINE;
  sysctl(mib, 2, NULL, &len, NULL, 0);
  machine = malloc(len);
  sysctl(mib, 2, machine, &len, NULL, 0);
  
  NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
  free(machine);
  
  //! iPhone
  if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
  if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
  if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
  if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4(A1332)";
  if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4(A1332)";
  if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4(A1349)";
  if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S(A1387/A1431)";
  if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5(A1428)";
  if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5(A1429/A1442)";
  if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c(A1456/A1532)";
  if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c(A1507/A1516/A1526/A1529)";
  if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s(A1453/A1533)";
  if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s(A1457/A1518/A1528/A1530)";
  if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus(A1522/A1524)";
  if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6(A1549/A1586)";
  
  if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
  if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
  if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSe";
  
  if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7(A)";
  if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus(A)";
  if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone7(G)";
  if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone7Plus(G)";
  
  if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone8(A)";
  if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone8(G)";
  if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone8Plus(A)";
  if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone8Plus(G)";
  if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhoneX(A)";
  if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhoneX(G)";
  
  if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
  
  if ([platform isEqualToString:@"iPhone11,4"]
      || [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
  
  if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
  
  //！ iPod
  if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G (A1213)";
  if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G (A1288)";
  if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G (A1318)";
  if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G (A1367)";
  if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G(A1421/A1509)";
  if ([platform isEqualToString:@"iPod7,1"]) return @"iPod Touch 6G";
  
  //！ iPad
  if ([platform isEqualToString:@"iPad1,1"]) return @"iPad1G(A1219/A1337)";
  if ([platform isEqualToString:@"iPad1,2"]) return @"iPad 3G";
  
  if ([platform isEqualToString:@"iPad2,1"]) return @"iPad2(A1395)";
  if ([platform isEqualToString:@"iPad2,2"]) return @"iPad2(A1396)";
  if ([platform isEqualToString:@"iPad2,3"]) return @"iPad2(A1397)";
  if ([platform isEqualToString:@"iPad2,4"]) return @"iPad2(A1395+New Chip)";
  
  if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini1G(A1432)";
  if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini1G(A1454)";
  if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini1G(A1455)";
  
  if ([platform isEqualToString:@"iPad3,1"]) return @"iPad3(A1416)";
  if ([platform isEqualToString:@"iPad3,2"]) return @"iPad3(A1403)";
  if ([platform isEqualToString:@"iPad3,3"]) return @"iPad3(A1430)";
  
  if ([platform isEqualToString:@"iPad3,4"]) return @"iPad4(A1458)";
  if ([platform isEqualToString:@"iPad3,5"]) return @"iPad4(A1459)";
  if ([platform isEqualToString:@"iPad3,6"]) return @"iPad4(A1460)";
  
  if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air(A1474)";
  if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air(A1475)";
  if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air(A1476)";
  
  if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini2G(A1489)";
  if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini2G(A1490)";
  if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini2G(A1491)";
  
  if ([platform isEqualToString:@"iPad4,7"]
      || [platform isEqualToString:@"iPad4,8"]
      || [platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
  
  
  if ([platform isEqualToString:@"iPad5,1"]
      || [platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
  
  
  if ([platform isEqualToString:@"iPad5,3"]
      || [platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
  
  if ([platform isEqualToString:@"iPad6,7"]
      || [platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
  
  if ([platform isEqualToString:@"iPad6,3"]
      || [platform isEqualToString:@"iPad6,4"]) return @"iPad Pro iPad 9.7-inch";
  
  if ([platform isEqualToString:@"iPad6,11"]
      || [platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
  
  if ([platform isEqualToString:@"iPad7,1"]
      || [platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
  
  if([platform isEqualToString:@"iPad7,3"]
     || [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
  
  if ([platform isEqualToString:@"i386"])  return @"iPhoneSimulator";
  if ([platform isEqualToString:@"x86_64"]) return @"iPhoneSimulator";
  
  return platform;

}

//! 判断是否是iPad
+ (BOOL)yt_isIpad {
  NSString *deviceType = [UIDevice currentDevice].model;
  
  if([deviceType isEqualToString:@"iPhone"]) {
    //iPhone
    return NO;
  } else if([deviceType isEqualToString:@"iPod touch"]) {
    //iPod Touch
    return NO;
  } else if([deviceType isEqualToString:@"iPad"]) {
    //iPad
    return YES;
  }
  return NO;
}

//！ 唯一设备号
+ (NSString *)yt_keychainForImsi {
  NSString *imsi;
  imsi = [self queryKeychainItemWithIdentifier:KeyChainIdentifier];
  if (imsi == nil) {
    NSMutableString *str = [NSMutableString stringWithString:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
    imsi = [str copy];
    [self saveKeychainItem:imsi WithIdentifier:KeyChainIdentifier];
  }
  return imsi;
}

#pragma mark - price func

//! 从钥匙串获取数据
+ (id)queryKeychainItemWithIdentifier:(NSString *)identifier {
  id keychainItem = nil;
  
  NSMutableDictionary *keychainQuery = [self newKeychainQuery:identifier];
  [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
  [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
  
  CFDataRef data = NULL;
  OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&data);
  if (status == errSecSuccess) {
    keychainItem = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge id)data];
  }
  return keychainItem;
}

//! 保存到钥匙串
+ (void)saveKeychainItem:(id)keychainItem WithIdentifier:(NSString *)identifier {
  NSMutableDictionary *keychainQuery = [self newKeychainQuery:identifier];
  SecItemDelete((__bridge CFDictionaryRef)(keychainQuery));
  [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:keychainItem] forKey:(__bridge id)(kSecValueData)];
  OSStatus status = SecItemAdd((__bridge CFDictionaryRef)(keychainQuery), NULL);
  if (status != errSecSuccess) {
#if DEBUG
    NSLog(@"OSStatus >>> %@", @(status));
#endif
  }
}

+ (NSMutableDictionary *)newKeychainQuery:(NSString *)identifier {
  
  NSMutableDictionary *quere = @{
                                 (__bridge id)kSecClass:(__bridge_transfer  id)kSecClassGenericPassword,
                                 (__bridge id)kSecAttrAccount:identifier,
                                 (__bridge id)kSecAttrService:identifier,
                                 (__bridge id)kSecAttrAccessible:(__bridge id)kSecAttrAccessibleAlways
                                 }.mutableCopy;
  return quere;
}

@end
