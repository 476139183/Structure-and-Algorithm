//
//  ViewController.m
//  Queue-09
//  队列
//  Created by Yutian Duan on 2018/11/6.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#include "ArrayQueue.h"
#include "LinkQueue.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  //! 顺序队列
//  arrayQueue();
  //! 链式队列
  linkQueue();
  
  
  
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
