//
//  TimerVC.m
//  RAC-第三课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "TimerVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TimerVC ()

@property (nonatomic, strong) UIButton *codeButton;

@property (nonatomic, assign)int time;
//! 释放信号
@property (nonatomic,strong) RACDisposable  *disposable;
//! 信号，这里进行了分解，方便阅读，
@property (nonatomic,strong) RACSignal *signal;

@end

@implementation TimerVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"定时器";
  self.view.backgroundColor = [UIColor whiteColor];
  
  _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  _codeButton.frame = CGRectMake(100, 100, 120, 45);
  [_codeButton setTitle:@"发生验证码" forState:UIControlStateNormal];
  [_codeButton addTarget:self action:@selector(reSendClick:) forControlEvents:UIControlEventTouchUpInside];
  _codeButton.backgroundColor = [UIColor orangeColor];
  [_codeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [_codeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
  [self.view addSubview:_codeButton];
  
}

- (void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  
  //取消订阅!!
  if (self.disposable.disposed == NO) {
    NSLog(@"还未取消订阅，进行取消");
    [self.disposable dispose];
  }

}

/*
 Block implicitly retains 'self'; explicitly mention 'self' to indicate this is intended behavior
 
 我们可以发现，在定时器还在进行的时候，如果此时返回控制器，定时会继续执行，直到取消订阅，然后才会释放循环引用，释放当前控制器，所以我们应该在 viewDidDisappear 时 取消订阅，终止循环引用释放VC
 
 
 */

- (void)reSendClick:(UIButton *)sender {
  //改变按钮状态
  self.codeButton.enabled = NO;
  //设置倒计时
  self.time = 10;
  //！内部封装了GCD
  self.signal = [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];

  self.disposable = [self.signal subscribeNext:^(NSDate * _Nullable x) {
    NSLog(@"%@",self);
    //时间先减少!
    self.time--;
    //设置文字
    NSString * btnText = self.time > 0 ? [NSString stringWithFormat:@"请等待%d秒",self.time]
    : @"重新发送";
    [self.codeButton setTitle:btnText forState:self.time > 0?(UIControlStateDisabled):(UIControlStateNormal)];
    //设置按钮
    if(self.time > 0){
      self.codeButton.enabled = NO;
    } else {
      self.codeButton.enabled = YES;
      //取消订阅!!
      [self.disposable dispose];
    }
  }];
  
}


- (void)dealloc {
  NSLog(@"timer VC dealloc");
}

@end

