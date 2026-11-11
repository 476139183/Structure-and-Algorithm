//
//  VideoDataFilter.h
//  ZDEC
//
//  Created by ledmedia on 14-3-27.
//  Copyright (c) 2014年 JianYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "MyTool.h"
#import "Config.h"
#import "NSString+SBJSON.h"
#import "LEDVideoItem.h"

@interface VideoDataFilter : NSObject
/**
 *@brief 解析视频详细页面的JSON数据,返回包含LEDVideoItem对象的数组
 */
+(NSArray *)refreshVideoData:(ASIHTTPRequest *)request;
@end
