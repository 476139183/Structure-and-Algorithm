//
//  ViewController.m
//  CustomAlertView
//
//  Created by Yutian Duan on 2018/3/29.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"
#import "TAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
  button.backgroundColor = [UIColor redColor];
  
  [button addTarget:self action:@selector(showAlertView:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)showAlertView:(id)sender {
  TAlertView *alert = [[TAlertView alloc] initWithTitle:nil
                                                message:@"请输入"
                                                buttons:@[@"Ok",@"取消"]
                                            andCallBack:^(TAlertView *alertView, NSInteger buttonIndex,NSString *filedtext ) {
                                              
                                              NSLog(@"点几了了＝＝＝%zd %@",buttonIndex,filedtext);
                                            }];
  alert.style = TAlertViewStyleError;
  alert.tapToClose = NO;
  [alert show];
  
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
