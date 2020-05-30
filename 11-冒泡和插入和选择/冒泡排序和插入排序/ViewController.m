//
//  ViewController.m
//  冒泡排序和插入排序
//
//  Created by Yutian Duan on 2018/12/11.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"

#import "bubbleSort.h"
#import "InsertionSort.h"
#import "selectionSort.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  //! 冒泡排序
  setupBubble();
  
  //! 插入排序
//  setupInsert();
  
  //! 选择排序
  setupSelection();
  
  
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
