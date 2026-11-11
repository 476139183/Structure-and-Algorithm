//
//  MoreVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2019/8/20.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import "MoreVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface MoreVC ()
@property (nonatomic, strong) RACSubject *signal;

@end

@implementation MoreVC

static int i = 0;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [_signal sendNext:@(i)];
  i++;
  
  NSLog(@"");
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  RACSubject *signal = [RACSubject subject];
  
  _signal = signal;
  
  // 节流，在一定时间（1秒）内，不接收任何信号内容，过了这个时间（1秒）获取最后发送的信号内容发出。
  [[signal throttle:1] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
  
  //    __block int i = 0;
  //    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
  //
  //            if (i == 10) {
  //                [subscriber sendNext:@1];
  //            }else{
  //                NSLog(@"接收到错误");
  //                [subscriber sendError:nil];
  //            }
  //            i++;
  //
  //        return nil;
  //
  //    }] retry] subscribeNext:^(id x) {
  //
  //        NSLog(@"%@",x);
  //
  //    } error:^(NSError *error) {
  //
  //
  //    }];
  
  
  //    RACSubject *signalB = [RACSubject subject];
  
  
  
  //    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
  //
  //
  //        [subscriber sendNext:@1];
  //        [subscriber sendNext:@2];
  //
  //        return nil;
  //    }] replay];
  //
  //    [signal subscribeNext:^(id x) {
  //
  //        NSLog(@"第一个订阅者%@",x);
  //
  //    }];
  //
  //    [signal subscribeNext:^(id x) {
  //
  //        NSLog(@"第二个订阅者%@",x);
  //
  //    }];
}

- (void)time {
  RACSignal *signalA = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    return nil;
  }] timeout:1 onScheduler:[RACScheduler currentScheduler]];
  
  [signalA subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  } error:^(NSError *error) {
    // 1秒后会自动调用
    NSLog(@"%@",error);
  }];
  
  
  
  
  
  RACSignal *signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    return nil;
  }] delay:2] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
  [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
}

- (void)then {
  // then:用于连接两个信号，当第一个信号完成，才会连接then返回的信号
  // 注意使用then，之前信号的值会被忽略掉.
  // 底层实现：1、先过滤掉之前的信号发出的值。2.使用concat连接then返回的信号
  [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    [subscriber sendCompleted];
    return nil;
  }] then:^RACSignal *{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      [subscriber sendNext:@2];
      return nil;
    }];
  }] subscribeNext:^(id x) {
    
    // 只能接收到第二个信号的值，也就是then返回信号的值
    NSLog(@"%@",x);
  }];
  
}

- (void)doNext {
  
  [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [subscriber sendNext:@1];
    [subscriber sendCompleted];
    return nil;
  }] doNext:^(id x) {
    // 执行[subscriber sendNext:@1];之前会调用这个Block
    NSLog(@"doNext");;
  }] doCompleted:^{
    // 执行[subscriber sendCompleted];之前会调用这个Block
    NSLog(@"doCompleted");;
    
  }] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
}

@end

