//
//  LoginViewModel.h
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/26.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GlobeHeader.h"

@interface LoginViewModel : NSObject


// 保存登录界面的账号和密码
/** 账号 */
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *pwd;

// 处理登录按钮是否允许点击
@property (nonatomic, strong, readonly) RACSignal *loginEnableSiganl;


/** 登录按钮命令 */
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
