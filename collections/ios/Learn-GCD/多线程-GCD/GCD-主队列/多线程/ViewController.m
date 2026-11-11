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
  
  [self asyncLock];
}


///! 1.主队列同步死锁
- (void)dealLock {
  
  dispatch_sync(dispatch_get_main_queue(), ^{
    NSLog(@"1");
  });
  
  NSLog(@"2");
  
  /*
    同步操作，会阻塞当前线程， 首先 dealLock 方法先添加到主队列，再继续向下执行中， 遇到 同步执行的block任务。并且将其任务也加入到了主队列。
   主队列的任务 通过 FIFO 取出到主线程中执行，那么要想执行 block 的任务，得等 dealLock 任务执行完毕，
   而 dealLock 任务要想执行完毕，得等 block 执行完毕。队列的两个任务相互等待，造成死锁
   
   */

}


///! 主队列异步：不会开辟线程
- (void)asyncLock {
  
  dispatch_async(dispatch_get_main_queue(), ^{
    sleep(4);
    NSLog(@"1=%@",[NSThread currentThread]);
    
  });
  
  dispatch_async(dispatch_get_main_queue(), ^{
    
    NSLog(@"1.1=%@",[NSThread currentThread]);
    
  });

  
  NSLog(@"2");
  
  [self performSelector:@selector(showLog) withObject:nil afterDelay:1];
  
  /*
   异步操作，并不会阻塞当前线程，所以会打印 日志 @“2”，但是异步的3个任务 都添加在主队列中，所以这是三个任务最终会按序在主线程执行，执行的时间是等待主线程空闲的时候。
   
   */
  
}



#pragma private methods

- (void)showLog {
  NSLog(@"showLogo%@",[NSThread currentThread]);
}

@end
