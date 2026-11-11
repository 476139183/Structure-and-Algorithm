//
//  FilterVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2019/8/20.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import "FilterVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface FilterVC ()

@property (strong, nonatomic) UITextField *textField;

@end

@implementation FilterVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view.
  
  // skip;跳跃几个值
  // 1.创建信号
  RACSubject *subject = [RACSubject subject];
  
  [[subject skip:2] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
  
  [subject sendNext:@"1"];
  [subject sendNext:@"2"];
  [subject sendNext:@"3"];

}

- (void)distinctUntilChanged {
  // distinctUntilChanged:如果当前的值跟上一个值相同,就不会被订阅到
  
  // 1.创建信号
  RACSubject *subject = [RACSubject subject];
  
  // 过滤，当上一次和当前的值不一样，就会发出内容。
  // 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
  [[subject distinctUntilChanged] subscribeNext:^(id x) {
    NSLog(@"%@",x);
  }];
  
  [subject sendNext:@"1"];
  [subject sendNext:@"2"];
  [subject sendNext:@"2"];
}

- (void)take {
  // 1.创建信号
  RACSubject *subject = [RACSubject subject];
  
  RACSubject *signal = [RACSubject subject];
  
  // take:取前面几个值
  // takeLast:取后面多少个值.必须要发送完成
  // takeUntil:只要传入信号发送完成或者发送任意数据,就不能在接收源信号的内容
  [[subject takeUntil:signal] subscribeNext:^(id x) {
    NSLog(@"%@",x);
  }];
  
  [subject sendNext:@"1"];
  
  //    [signal sendNext:@1];
  //    [signal sendCompleted];
  [signal sendError:nil];
  
  [subject sendNext:@"2"];
  [subject sendNext:@"3"];
  
}

- (void)ignore {
  
  // ignore:忽略一些值,内部调用filter过滤，忽略掉ignore的值
  // ignoreValues:忽略所有的值
  
  // 1.创建信号
  RACSubject *subject = [RACSubject subject];
  
  // 2.忽略一些
//  RACSignal *ignoreSignal = [subject ignoreValues];
  
  RACSignal *ignoreSignal = [subject ignore:@"2"];
  
  // 3.订阅信号
  [ignoreSignal subscribeNext:^(id x) {
    NSLog(@"%@",x);
  }];
  
  // 4.发送数据
  [subject sendNext:@"13"];
  [subject sendNext:@"2"];
  [subject sendNext:@"44"];
  
}

- (void)filter {
  // 只有当我们文本框的内容长度大于5,才想要获取文本框的内容
  [[_textField.rac_textSignal filter:^BOOL(id value) {
    // value:源信号的内容
    return  [value length] > 5;
    // 返回值,就是过滤条件,只有满足这个条件,才能能获取到内容
    
  }] subscribeNext:^(id x) {
    
    NSLog(@"%@",x);
  }];
}



@end

