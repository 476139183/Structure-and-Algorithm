//
//  ConnecttionVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ConnecttionVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

/*
  场景：有的时候，需要多个不同UI甚至VC 接收同一数据，如果多次订阅，会导致发送信号多次，不符合我们的初衷，这个时候 需要一个  唯一信号处理
  RACMulticastConnection
 
 */

@interface ConnecttionVC ()

@end

@implementation ConnecttionVC

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"信号连接";

//  [self failedTest];
  
  [self successTest];

}

//不管订阅多少次信号,就只会请求一次数据
- (void)successTest {
  
  //1.创建源信号 返回的是 RACDynamicSignal
  RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //发送网络请求
    NSLog(@"发送请求");
    /*TODO:5.发送数据
     * 根据保存的对象 也就是 _innerSubscriber 发送数据（这里是RACSubject，通过断点可查）
     * 因为订阅的是RACSubject，所以返回的也是根据 RACSubject 产生的订阅者，里面采用的是遍历发送
     * 那么发送的数据， RACSubject之前订阅的信号 理所当然的可以接受到
     */
    [subscriber sendNext:@"请求到的数据"];
    
    return nil;
  }];

  /* TODO: 2.将创建的信号转化为 连接类
   *  创建了一个 RACSubject 信号类 替代 signal，
   *  创建 RACMulticastConnection 类  同时持有 signal信号(RACDynamicSignal) 和 RACSubject 信号，
   *
   */
  RACMulticastConnection *connection = [signal publish];

  /* TODO: 3.订阅连接类的信号，此时可以发现，订阅信号(该信号类是 RACSubject) 并未触发 5 处的block
   *
   * 此后方法都是 RACSubject类，在第一课有阅读源码，发现 RACSubject订阅并不会主动触发只是保存操作
   * 需要调用  [racSubject sendNext:@"子类信号"]; 才会触发订阅信号的block
   *
  */
  
  [connection.signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"A处在处理回调数据%@",x);
  }];
  //! RACSubject 对象 继续保存block
  [connection.signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"B处在处理回调数据%@",x);
  }];
  
  /*TODO: 4.连接，此时才触发信号，内部处理，多次调用connect 也只会执行一次
   * 调用 signal 触发源信号的block 发送数据，原理可以查看第一课 基类信号的流程
   * 里面有一个操作 是存储的signal信号，实际是RACDynamicSignal类 调用了subscribe方法。如下
   * [self.sourceSignal subscribe:_signal] 里面开始真正的订阅
   * 因为 _signal其实就是 之前的 RACSubject，所以订阅的是 RACSubject对象，
   */
  [connection connect];
  
}

/*
 可以看到 因为多个地方订阅，导致信号发送多次
 */
- (void)failedTest {
  
  //1.创建信号
  RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //发送网络请求
    NSLog(@"发送请求");
    //发送数据
    [subscriber sendNext:@"请求到的数据"];
    
    return nil;
  }];

  [signal subscribeNext:^(id  _Nullable x) {
    //! View1 需要订阅信号
    NSLog(@"View1接收数据%@",x);
  }];
  
  
  [signal subscribeNext:^(id  _Nullable x) {
    //! View2 需要订阅信号
    NSLog(@"View2接收数据%@",x);
  }];
  
}

/*
 
 // RACMulticastConnection使用步骤:
 // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
 // 2.创建连接 RACMulticastConnection *connect = [signal publish];
 // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
 // 4.连接 [connect connect]
 
 // RACMulticastConnection底层原理:
 // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
 // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
 // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
 // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
 // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
 // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
 // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
 
 
 // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
 // 解决：使用RACMulticastConnection就能解决.

 
 
 */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

}


- (void)dealloc {
  NSLog(@"ConnecttionVC dealloc");
}

@end

