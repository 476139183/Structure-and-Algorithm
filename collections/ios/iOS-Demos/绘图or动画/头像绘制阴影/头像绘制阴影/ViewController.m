//
//  ViewController.m
//  头像绘制阴影
//
//  Created by Yutian Duan on 2018/3/27.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"
#import "MyImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  MyImageView *image = [[MyImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  
  image.imagename = @"bb";
  //    image.backgroundColor = [UIColor redColor];
  [self.view addSubview:image];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
