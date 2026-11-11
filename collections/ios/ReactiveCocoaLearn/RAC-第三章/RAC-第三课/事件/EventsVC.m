//
//  EventsVC.m
//  RAC-第三课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "EventsVC.h"
#import "TestView.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface EventsVC ()

@end

@implementation EventsVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"事件处理";
  
  TestView *testView = [[TestView alloc] initWithFrame:self.view.bounds];
  testView.backgroundColor = [UIColor redColor];
  [self.view addSubview:testView];
  


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
  //TODO: 监听内部方法调用
  [[testView rac_signalForSelector:@selector(clickButton:)] subscribeNext:^(RACTuple * _Nullable x) {
    NSLog(@"发现调用了clickButton方法");
  }];
#pragma clang diagnostic pop

  
  
  
  // Do any additional setup after loading the view.
}


@end

