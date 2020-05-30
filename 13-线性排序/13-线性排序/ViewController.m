//
//  ViewController.m
//  13-线性排序
//
//  Created by Yutian Duan on 2018/12/13.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#include "bucketSort.h"
//#include "CountSort.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  //! 桶排序
//  setBucket();
  //! 计数排序
  setCount();
  
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
