//
//  CommandVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "CommandVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

/*
 场景：对信号进行一些状态的控制
 RACCommand
 
 */


@interface CommandVC ()

@end

@implementation CommandVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"指令信号";

  [self observeSignal];
  
 // [self commandTest];

}

- (void)observeSignal {
  
  //! 1.创建命令
  RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      //! 发送数据
      [subscriber sendNext:@"执行命令之后 发送数据"];
      //! 通知命令 结束事件
      [subscriber sendCompleted];
      return nil;
    }];
    
    
  }];
  
  /*
   监听事件有没有执行完毕,默认会来一次，可以直接跳过，可以使用 skip 来 表示跳过第一次信号
   [command.executing skip:1]
  */
  [command.executing subscribeNext:^(NSNumber * _Nullable x) {
    // 0 没有执行  1 执行ing
    if ([x boolValue] == YES) {
      NSLog(@"执行中");
    } else {
      NSLog(@"尚未开始或者已经结束了");
    }
    
  } completed:^{
    NSLog(@"completed");
  }];
  
  [[command execute:@"执行！" ] subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@",x);
  }];

  
  
}

///! 
- (void)commandSecond {
  
  
  //! 1.创建命令
  RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      //! 发送数据
      [subscriber sendNext:@"执行命令之后 发送数据"];
      return nil;
    }];
  }];
  
  
  /* TODO: 2.1 信号源 订阅
   * executionSignals:信号源，发送信号的信号。
   *
   *
   */
  /*
  [command.executionSignals subscribeNext:^(RACSignal *signal) {
    NSLog(@"%@",signal);
    //! 信号订阅
    [signal subscribeNext:^(id  _Nullable x) {
      NSLog(@"%@",x);
    }];
  }];
  */
  
  //TDOD: 2.2 另一种方式,用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
  [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@",x);
  }];
  
  
  
  //! 3.执行命令 execute会触发上面的block
  [command execute:@"输入命令"];
  
  
}

- (void)switchToLatest {
  
  // 创建信号中信号
  RACSubject *signalOfSignals = [RACSubject subject];
  RACSubject *signalA = [RACSubject subject];
  RACSubject *signalB = [RACSubject subject];
  
  // 订阅信号
  //    [signalOfSignals subscribeNext:^(RACSignal *x) {
  //        [x subscribeNext:^(id x) {
  //            NSLog(@"%@",x);
  //        }];
  //    }];
  // switchToLatest:获取信号中信号发送的最新信号
  [signalOfSignals.switchToLatest subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
  // 发送信号
  [signalOfSignals sendNext:signalA];
  
  [signalA sendNext:@1];
  [signalB sendNext:@"BB"];
  [signalA sendNext:@"11"];
}


////: 命令控制信号
- (void)commandTest {
  
  //! 1.创建命令
  RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
    NSLog(@"%@",input);
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
      //! 发送数据
      [subscriber sendNext:@"执行命令之后 发送数据"];
      return nil;
    }];
  }];
  
  //! 2.执行命令，返回的signal 就是 上面的 RACSignal 信号, execute会触发上面的block
  RACSignal *signal = [command execute:@"输入命令"];
  
  //! 3. 订阅信号,来触发 发送数据
  [signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@",x);
  }];

}

/*
 
 // 一、RACCommand使用步骤:
 // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
 // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
 // 3.执行命令 - (RACSignal *)execute:(id)input
 
 // 二、RACCommand使用注意:
 // 1.signalBlock必须要返回一个信号，不能传nil.
 // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
 // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
 // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
 
 // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
 // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
 // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
 
 // 四、如何拿到RACCommand中返回信号发出的数据。
 // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
 // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
 
 // 五、监听当前命令是否正在执行executing
 
 // 六、使用场景,监听按钮点击，网络请求

 
 
 
 */


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  NSLog(@"CommandVC dealloc");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

