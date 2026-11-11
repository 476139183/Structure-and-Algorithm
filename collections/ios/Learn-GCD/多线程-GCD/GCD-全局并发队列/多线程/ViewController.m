//
//  ViewController.m
//  多线程
//
//  Created by Yutian Duan on 2019/8/16.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  /*
   全局并发队列 是系统为我们提供的一个 全局的 并发队列。
   */
  [self asyncGlobal];
  
}


///! 全局并发队列 同步操作
- (void)syncGlobal {
  /**
   参数说明：
   参数1：代表该任务的优先级，默认写0就行，不要使用系统提供的枚举类型，因为ios7和ios8的枚举数值不一样，使用数字可以通用。
   参数2：苹果保留关键字，一般也写0
   */
  
  dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
  
  dispatch_sync(queue, ^{
    NSLog(@"1%@",[NSThread currentThread]);
  });
  
  dispatch_sync(queue, ^{
    NSLog(@"2%@",[NSThread currentThread]);
  });
  
  dispatch_sync(queue, ^{
    NSLog(@"3%@",[NSThread currentThread]);
  });
  
  NSLog(@"end%@",[NSThread currentThread]);

  /*
  
   同步操作，会阻塞当前线程， 首先 同步是不会创建线程的，所以会在当前线程执行，而当前线程为主线程。
   
   所以打印的顺序 是 "1" -> "2" -> "3" -> "end"
  
   */
  
}


///! 串行队列异步操作
- (void)asyncGlobal {
  
  dispatch_queue_t queue = dispatch_get_global_queue(0, 0);

  dispatch_async(queue, ^{
    sleep(1);
    NSLog(@"1%@",[NSThread currentThread]);
  });
  
  dispatch_async(queue, ^{
    sleep(1);
    NSLog(@"2%@",[NSThread currentThread]);
  });

  dispatch_async(queue, ^{
    sleep(1);
    NSLog(@"3%@",[NSThread currentThread]);
    [self performSelector:@selector(showLog) withObject:nil afterDelay:1];
  });

  NSLog(@"end%@",[NSThread currentThread]);
  
  /*
   异步操作，不会阻塞当前线程，将3个任务异步添加到 全局并发队列时。系统会为其分配多个线程进行并发操作
   
   所以理论上打印是先打印 "end"
   然后随机打印 "1"  "2" "3"。这个结果 和自定义个并发队列没有区别
   
   而我们发现，showlog 的任务并没有执行，这个和 performSelector 的方法实现有关，暂表不提。
   
   
   */
  
  
}



#pragma private methods

- (void)showLog {
  NSLog(@"showLogo%@",[NSThread currentThread]);
}

@end
