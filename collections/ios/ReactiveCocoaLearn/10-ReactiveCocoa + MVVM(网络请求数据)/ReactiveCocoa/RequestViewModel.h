//
//  RequestViewModel.h
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/26.
//  Copyright © 2015年 xiaomage. All rights reserved.
//  请求

#import <Foundation/Foundation.h>


#import "GlobeHeader.h"

@interface RequestViewModel : NSObject

/** 请求命令 */
@property (nonatomic, strong, readonly) RACCommand *requestCommand;

@end
