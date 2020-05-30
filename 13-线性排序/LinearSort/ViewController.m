//
//  ViewController.m
//  LinearSort
//
//  Created by 段雨田 on 2019/11/12.
//  Copyright © 2019 段雨田. All rights reserved.
//

#import "ViewController.h"
#include "BucketSort.h"
#include "CountingSort.h"
#include "RadixSort.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  setBucket();
  printf("\n");
  setCount();
  printf("\n");
  setRadix();

  
}


@end
