//
//  FenceVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "FenceVC.h"
#import <ReactiveObjC/ReactiveObjC.h>


/* 前要：
 RACSignal 在订阅信号的时候，就会触发 创建信号的block，里面会执行发送信号的操作，回到订阅信号block，处理数据（可以回到第一课 查看）
 
 那么多个信号 如果需要异步操作，要求全部完成时，才进行数据处理，那么就需要 类似GCD 栅栏函数的操作了
 
 rac_liftSelector
 
 */


@interface FenceVC ()

@end

@implementation FenceVC

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"栅栏";
  
  [self testRacLift];
  
}

- (void)testRacLift {
  
  //请求1,假装该数据请求耗时，
  RACSignal * signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //！假装这个是一个AF网络请求，记得回到主线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      // 网络请求
      NSLog(@"请求网络数据 1");
      [NSThread sleepForTimeInterval:4];
      dispatch_async(dispatch_get_main_queue(), ^{
        [subscriber sendNext:@"发送请求数据1"];
      });
    });
    
    return nil;
  }];
  
  //请求2
  RACSignal * signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //发送请求
    NSLog(@"请求网络数据 2");
    //发送数据
    [subscriber sendNext:@"发送请求数据2"];
    
    return nil;
  }];
  
  //数组:存放信号
  //当数组中的所有信号都发送了数据,才会执行Selector
  //方法的参数:必须和数组的信号一一对应!!
  //方法的参数:就是每一个信号发送的数据!!
  [self rac_liftSelector:@selector(updateUIWithOneData:TwoData:) withSignalsFromArray:@[signal1,signal2]];
  /*
   这个步骤比较复杂，主要还是用到了消息转发机制，然后生成一个 RACDynamicSignal 对象 里面进行创建信号
   里面也用到了 RACMulticastConnection 类
   
   */
}

- (void)updateUIWithOneData:(id )oneData TwoData:(id )twoData {
  NSLog(@"当前线程%@",[NSThread currentThread]);
  //拿到数据更新UI
  NSLog(@"订阅信号返回的数据\n%@\n%@",oneData,twoData);
  
}

- (void)dealloc {
  NSLog(@"FenceVC dealloc");
}

@end

