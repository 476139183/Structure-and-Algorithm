//
//  JsonToObjectAdapter.h
//  ZDEC
//
//  Created by yixingman on 9/6/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+SBJSON.h"
#import "CompanyContactsEntity.h"

@interface JsonToObjectAdapter : NSObject
+(NSArray*)customerJsonToObject:(NSString*)jsonStr;
+(NSArray*)customerRepairJsonToObject:(NSString*)jsonStr;
+(NSArray*)complaintJsonToObject:(NSString*)jsonStr;
+(NSArray*)contactsJsonToObject:(NSString*)jsonStr;
+(NSArray*)salesJsonToObject:(NSString*)jsonStr;
//+(NSArray*)repairJsonToObject:(NSString*)jsonStr;
//+(NSArray*)livesupportJsonToObject:(NSString*)jsonStr;
//+(NSArray*)remoteJsonToObject:(NSString*)jsonStr;
+(CompanyContactsEntity*)oneContactJsonToObject:(NSString*)jsonStr;
/*
 *保存登陆用户的个人信息在NSUserDefault里
 */
+(void)saveLoginInformation:(NSDictionary*)userDict;
@end
