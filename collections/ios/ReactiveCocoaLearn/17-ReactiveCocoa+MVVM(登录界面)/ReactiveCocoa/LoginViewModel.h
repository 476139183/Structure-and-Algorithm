//
//  LoginViewModel.h
//  ReactiveCocoa
//
//  Created by yz on 15/10/5.
//  Copyright © 2015年 yz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
@class Account;
@interface LoginViewModel : NSObject

@property (nonatomic, strong) Account *account;


// 是否允许登录的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;

@property (nonatomic, strong, readonly) RACCommand *LoginCommand;

@end
