//
//  ViewController.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#import "FenceVC.h"
#import "ConnecttionVC.h"
#import "CommandVC.h"
#import "BindVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.title = @"RAC 复合用法";
  self.view.backgroundColor = [UIColor whiteColor];

  //！ 
  NSArray *titleArray = @[@"栅栏信号",@"唯一信号",@"指令",@"绑定"];
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
    [self.navigationController pushViewController:[FenceVC new] animated:YES];
  } else if (sender.tag == 2) {
    [self.navigationController pushViewController:[ConnecttionVC new] animated:YES];
  } else if (sender.tag == 3) {
    [self.navigationController pushViewController:[CommandVC new] animated:YES];
  } else if (sender.tag == 4) {
    [self.navigationController pushViewController:[BindVC new] animated:YES];
  }
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
