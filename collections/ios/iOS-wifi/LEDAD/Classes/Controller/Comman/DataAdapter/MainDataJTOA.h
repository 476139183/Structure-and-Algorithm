//
//  MainDataJTOA.h
//  ZDEC
//
//  Created by yixingman on 11/7/13.
//  Copyright (c) 2013 JianYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainDataJTOA : NSObject
+(NSArray*)adlistJsonToObject:(NSString*)jsonStr;
+(NSArray*)graidlistJsonToObject:(NSString*)jsonStr;

@end
