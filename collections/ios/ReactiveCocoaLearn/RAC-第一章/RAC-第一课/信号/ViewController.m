//
//  ViewController.m
//  RAC-第一课
//
//  Created by Yutian Duan on 2018/11/13.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self signal];
  
}

//! 基类信号 RACSignal
- (void)signal {
  
  //! TODO: 1.创建信号（冷信号） -> 返回的是子类 RACDynamicSignal 抛出 didSubscribe block
  RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //TODO: 3. 在主线程，RACSubscriber对象发送信号
    [subscriber sendNext:@"发送一个对象"];
    
    /* 也可以发送其他信号
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:@{@"status":@"404"}];
    [subscriber sendError:error];
    [subscriber sendCompleted];
    */
    
    return [RACDisposable disposableWithBlock:^{
      /* TODO: 信号自动销毁
       最后生成的 RACDisposable 会调用 销毁block，这一步发生在最后  addDisposable 方法里面
      */
      NSLog(@"信号销毁");
    }];
  }];
  
  /*!  TODO: 2.订阅信号(热信号) 调用 RACDynamicSignal 的 父亲类的 subscribeNext 方法，里面生成
  RACSubscriber 对象，再调用 自己实现的 subscribe 发送信号的方法。调用创建信号时，在保存的block
   发送信号之后， 返回 RACDisposable 对象
  */
  RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
    // x:收到的信号
    NSLog(@"收到的信号：%@",x);
  }];
  
  // 只要订阅者调用sendNext,就会执行nextBlock
  // 只要订阅RACDynamicSignal,就会执行didSubscribe
  // 前提条件是RACDynamicSignal,不同类型信号的订阅,处理订阅的事情不一样

  /*
   默认一个信号发送数据完毕们就会主动取消订阅,
   如果信号被强持有，需要自己手动取消
   [disposable dispose];
   */

  //! 订阅错误信号
//  [signal subscribeError:^(NSError * _Nullable error) {
//    NSLog(@"接收error:%@",error);
//  }];
  //! 订阅完成信号
//  [signal subscribeCompleted:^{
//    NSLog(@"接收完成信号");
//  }];
}

//! 信号子类 RACSubject
- (void)subject {
  //! 1. 创建信号，建立一个销毁对象和一个数组 _subscribers
  RACSubject *subject = [RACSubject subject];
  /* 2. 订阅信号, 调用父类方法，并重写里面的 subscribe 方法。
      拿到之前的_subscribers 只保存这个订阅者，并未触发其他方法
  */
  [subject subscribeNext:^(id  _Nullable x) {
    NSLog(@"接受到了数据:%@",x);
  }];
  
  //!3. 发送数据
  //遍历出所有的订阅者,调用nextBlock
  [subject sendNext:@"子类信号"];
  
  // 执行流程:
  
  // RACSubject被订阅,仅仅是保存订阅者
  // RACSubject发送数据,遍历所有的订阅,调用他们的nextBlock

}

///!  RACSubject 的子类
- (void)replaySubject {
  // 1.创建信号
  RACReplaySubject *subject = [RACReplaySubject subject];
  
  // 2.订阅信号
  [subject subscribeNext:^(id x) {
    NSLog(@"%@",x);
  }];
  // 遍历所有的值,拿到当前订阅者去发送数据
  
  // 3.发送信号
  [subject sendNext:@1];
  //    [subject sendNext:@1];
  // RACReplaySubject发送数据:
  // 1.保存值
  // 2.遍历所有的订阅者,发送数据
  
  
  // RACReplaySubject:可以先发送信号,再订阅信号

}

/*
 
 // RACSubject使用步骤
 // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
 // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
 // 3.发送信号 sendNext:(id)value
 
 // RACSubject:底层实现和RACSignal不一样。
 // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
 // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。

 
 // RACReplaySubject使用步骤:
 // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
 // 2.可以先订阅信号，也可以先发送信号。
 // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
 // 2.2 发送信号 sendNext:(id)value
 
 // RACReplaySubject:底层实现和RACSubject不一样。
 // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
 // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
 
 // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
 // 也就是先保存值，在订阅值。


 */

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
