//
//  ViewController.m
//  RAC-第三课
//
//  Created by Yutian Duan on 2018/11/17.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#import "EventsVC.h"
#import "TimerVC.h"
#import "MacroVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.title = @"RAC 简单用法";
  self.view.backgroundColor = [UIColor whiteColor];

  //! 为了分门别类 这里就没用 rac 处理
  
  NSArray *titleArray = @[@"事件触发",@"定时器",@"宏用法"];
  
  for (NSInteger i = 0; i < titleArray.count; i ++) {
    UIButton *sender = [[UIButton  alloc] initWithFrame:CGRectMake(100, 100 + i * 80, 100, 45)];
    [sender setTitle:titleArray[i] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    sender.tag = i + 1;
    [sender addTarget:self action:@selector(eventClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sender];
  }
  
  
}

- (void)eventClick:(UIButton *)sender {
  if (sender.tag == 1) {
    [self.navigationController pushViewController:[EventsVC new] animated:YES];
  } else if (sender.tag == 2) {
    [self.navigationController pushViewController:[TimerVC new] animated:YES];
  } else if (sender.tag == 3) {
    [self.navigationController pushViewController:[MacroVC new] animated:YES];
  }
}

@end
