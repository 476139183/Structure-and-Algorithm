//
//  ViewController.m
//  本地通知
//
//  Created by Yutian Duan on 2018/4/2.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSString *productIDorder;


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  productIDorder = @"1";
  [self getname];
  //
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  [button setTitle:@"本地推送" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(localpush) forControlEvents:UIControlEventTouchUpInside];
  
  button.backgroundColor = [UIColor redColor];
  
  [self.view addSubview:button];
}

- (void)getname {
  NSLog(@"--%@  %s",NSStringFromClass([productIDorder class]),[productIDorder UTF8String]);
}

- (void)localpush {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //本地推送通知
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    NSDate * pushDate = [NSDate dateWithTimeIntervalSinceNow:10];
    if (notification != nil) {
      notification.fireDate = pushDate;
      notification.timeZone = [NSTimeZone defaultTimeZone];
      
      notification.repeatInterval = kCFCalendarUnitDay;
      notification.soundName = UILocalNotificationDefaultSoundName;
      
      notification.alertBody = @"我是本地推送";
      
      notification.applicationIconBadgeNumber = 0;
      
      NSDictionary *info = [NSDictionary dictionaryWithObject:@"测试" forKey:@"名称"];
      notification.userInfo = info;
      [[UIApplication sharedApplication] scheduleLocalNotification:notification];
      
    }
  });
  
}



- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
