//
//  RequestViewModel.m
//  ReactiveCocoa
//
//  Created by xiaomage on 15/10/26.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

#import "RequestViewModel.h"

#import "AFNetworking.h"

#import "Book.h"

@implementation RequestViewModel

- (instancetype)init
{
    if (self = [super init]) {
        
        [self setUp];
    }
    return self;
    
}


- (void)setUp
{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // 执行命令
        // 发送请求
        
        // 创建信号
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            // 创建请求管理者
            AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
            
            [mgr GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"美女"} success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary * _Nonnull responseObject) {
                // 请求成功的时候调用
                NSLog(@"请求成功");
                
                NSArray *dictArr = responseObject[@"books"];
                
               NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                    
                    return [Book bookWithDict:value];
                }] array];
                
                
                [subscriber sendNext:modelArr];
                
                
            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                
            }];

            
            return nil;
        }];
        
        
        return signal;
    }];
}

@end
