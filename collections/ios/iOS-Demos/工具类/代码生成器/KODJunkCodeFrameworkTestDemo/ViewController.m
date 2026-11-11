//
//  ViewController.m
//  KODJunkCodeFrameworkTestDemo
//
//  Created by KODIE on 2017/8/24.
//  Copyright © 2017年 kodie. All rights reserved.
//

#import "ViewController.h"
#import <KODJunkCodeCreater/KODJunkCodeCreater.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //TODO:改成自己电脑的路径
  [[KODJunkCodeCreater defaultService] createJunkCodeWithFileNum:50 writeToDirectory:@"/Users/yutianduan/Desktop/JunkCode"];
  
}

@end
