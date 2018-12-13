//
//  ViewController.m
//  FastSort
//
//  Created by Yutian Duan on 2018/12/12.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#import "MergeSort.h"
#import "QuickSort.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  //! 归并排序
//  setMerge();
  //! 快速排序
  setQuick();
  
  
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
