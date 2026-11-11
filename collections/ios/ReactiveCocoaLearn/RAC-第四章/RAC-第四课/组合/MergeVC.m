//
//  MergeVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2019/8/20.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import "MergeVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface MergeVC ()

@property (strong, nonatomic)  UITextField *accountFiled;
@property (strong, nonatomic)  UITextField *pwdField;
@property (strong, nonatomic)  UIButton *loginBtn;


@end

@implementation MergeVC

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  // 组合
  // 组合哪些信号
  // reduce:聚合
  
  // reduceBlock参数:根组合的信号有关,一一对应
  RACSignal *comineSiganl = [RACSignal combineLatest:@[_accountFiled.rac_textSignal,_pwdField.rac_textSignal] reduce:^id(NSString *account,NSString *pwd){
    // block:只要源信号发送内容就会调用,组合成新一个值
    NSLog(@"%@ %@",account,pwd);
    // 聚合的值就是组合信号的内容
    return @(account.length && pwd.length);
  }];
  
  // 订阅组合信号
  //    [comineSiganl subscribeNext:^(id x) {
  //        _loginBtn.enabled = [x boolValue];
  //    }];
  
  RAC(_loginBtn,enabled) = comineSiganl;
  
  
  
}

- (void)combineLatest {
  RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    
    return nil;
  }];
  
  RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@2];
    
    return nil;
  }];
  
  // 聚合
  // 常见的用法，（先组合在聚合）。combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
  // reduce中的block简介:
  // reduceblcok中的参数，有多少信号组合，reduceblcok就有多少参数，每个参数就是之前信号发出的内容
  // reduceblcok的返回值：聚合信号之后的内容。
  RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1 ,NSNumber *num2){
    
    return [NSString stringWithFormat:@"%@ %@",num1,num2];
    
  }];
  
  [reduceSignal subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
  // 底层实现:
  // 1.订阅聚合信号，每次有内容发出，就会执行reduceblcok，把信号内容转换成reduceblcok返回的值。

}

// 组合
- (void)combine {
  RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@1];
    
    return nil;
  }];
  
  RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
    [subscriber sendNext:@2];
    
    return nil;
  }];
  
  // 把两个信号组合成一个信号,跟zip一样，没什么区别
  RACSignal *combineSignal = [signalA combineLatestWith:signalB];
  
  [combineSignal subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
  // 底层实现：
  // 1.当组合信号被订阅，内部会自动订阅signalA，signalB,必须两个信号都发出内容，才会被触发。
  // 2.并且把两个信号组合成元组发出。
}

// 压缩
- (void)zip {
  // zipWith:夫妻关系
  // 创建信号A
  RACSubject *signalA = [RACSubject subject];
  
  // 创建信号B
  RACSubject *signalB = [RACSubject subject];
  
  // 压缩成一个信号
  // zipWith:当一个界面多个请求的时候,要等所有请求完成才能更新UI
  // zipWith:等所有信号都发送内容的时候才会调用
  RACSignal *zipSignal = [signalA zipWith:signalB];
  
  // 订阅信号
  [zipSignal subscribeNext:^(id x) {
    NSLog(@"%@",x);
  }];
  
  // 发送信号
  [signalB sendNext:@2];
  [signalA sendNext:@1];
  // 底层实现:
  // 1.定义压缩信号，内部就会自动订阅signalA，signalB
  // 2.每当signalA或者signalB发出信号，就会判断signalA，signalB有没有发出个信号，有就会把最近发出的信号都包装成元组发出。
}

// 任意一个信号请求完成都会订阅到
- (void)merge {
  // 创建信号A
  RACSubject *signalA = [RACSubject subject];
  
  // 创建信号B
  RACSubject *signalB = [RACSubject subject];
  
  // 组合信号
  RACSignal *mergeSiganl = [signalA merge:signalB];
  
  // 订阅信号
  [mergeSiganl subscribeNext:^(id x) {
    // 任意一个信号发送内容都会来这个block
    NSLog(@"%@",x);
  }];
  
  // 发送数据
  [signalB sendNext:@"下部分"];
  [signalA sendNext:@"上部分"];
  
  // 底层实现：
  // 1.合并信号被订阅的时候，就会遍历所有信号，并且发出这些信号。
  // 2.每发出一个信号，这个信号就会被订阅
  // 3.也就是合并信号一被订阅，就会订阅里面所有的信号。
  // 4.只要有一个信号被发出就会被监听。
}

- (void)then {
  // 创建信号A
  RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    // 发送请求
    NSLog(@"发送上部分请求");
    // 发送信号
    [subscriber sendNext:@"上部分数据"];
    
    // 发送完成
    [subscriber sendCompleted];
    
    return nil;
  }];
  
  // 创建信号B
  RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    // 发送请求
    NSLog(@"发送下部分请求");
    // 发送信号
    [subscriber sendNext:@"下部分数据"];
    
    return nil;
  }];
  
  // 创建组合信号
  // then:忽悠掉第一个信号所有值
  RACSignal *thenSiganl = [siganlA then:^RACSignal *{
    // 返回信号就是需要组合的信号
    return siganlB;
  }];
  
  // 订阅信号
  [thenSiganl subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
}

- (void)concat {
  // 组合:拼接信号，当多个信号发出的时候，有顺序的接收信号。
  // concat:皇上,皇太子
  // 创建信号A
  RACSignal *siganlA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    // 发送请求
    NSLog(@"发送上部分请求");
    // 发送信号
    [subscriber sendNext:@"上部分数据"];
    
    [subscriber sendCompleted];
    
    return nil;
  }];
  
  RACSignal *siganlB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    // 发送请求
    NSLog(@"发送下部分请求");
    // 发送信号
    [subscriber sendNext:@"下部分数据"];
    
    return nil;
  }];
  
  // concat:按顺序去连接:把signalA拼接到signalB后，signalA发送完成，signalB才会被激活。
  // 注意:concat,第一个信号必须要调用sendCompleted
  // 创建组合信号
  RACSignal *concatSignal = [siganlA concat:siganlB];
  
  // 订阅组合信号
  // 以后只需要面对拼接信号开发。
  // 订阅拼接的信号，不需要单独订阅signalA，signalB
  // 内部会自动订阅。
  // 注意：第一个信号必须发送完成，第二个信号才会被激活

  [concatSignal subscribeNext:^(id x) {
    
    // 既能拿到A信号的值,又能拿到B信号的值
    NSLog(@"%@",x);
    
  }];
  
  // concat底层实现:
  // 1.当拼接信号被订阅，就会调用拼接信号的didSubscribe
  // 2.didSubscribe中，会先订阅第一个源信号（signalA）
  // 3.会执行第一个源信号（signalA）的didSubscribe
  // 4.第一个源信号（signalA）didSubscribe中发送值，就会调用第一个源信号（signalA）订阅者的nextBlock,通过拼接信号的订阅者把值发送出来.
  // 5.第一个源信号（signalA）didSubscribe中发送完成，就会调用第一个源信号（signalA）订阅者的completedBlock,订阅第二个源信号（signalB）这时候才激活（signalB）。
  // 6.订阅第二个源信号（signalB）,执行第二个源信号（signalB）的didSubscribe
  // 7.第二个源信号（signalA）didSubscribe中发送值,就会通过拼接信号的订阅者把值发送出来.
  
}



@end

