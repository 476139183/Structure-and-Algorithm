//
//  ViewController.m
//  CustomProgress
//
//  Created by duanyutian on 2017/6/11.
//  Copyright © 2017年 duanyutian. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"

@interface ViewController () {
  NSArray *title;
  ProgressView *progress;
}


@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  title = @[@"1",@"2",@"3",@"4",@"5",@"6"];
  
  progress = [[ProgressView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 80) andDataArr:title];
  [self.view addSubview:progress];
  
  
  UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
  nextButton.frame = CGRectMake(100, CGRectGetMaxY(progress.frame) + 100, 100, 100);
  [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
  [nextButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
  [nextButton addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:nextButton];
  
}

- (void)nextStep {
  // 角标到5的时候 需要跳回初始点
  if (progress.index >=  title.count -1) {
    progress.index = 0;
  } else {
    progress.index += 1;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
