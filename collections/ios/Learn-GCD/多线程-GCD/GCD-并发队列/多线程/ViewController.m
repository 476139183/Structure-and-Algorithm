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
  
  
  
  [self testSecond];
  
}


///! 并发队列 同步操作
- (void)syncConcurrent {
  
  dispatch_queue_t queue = dispatch_queue_create("com.syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
  
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
   同步操作，会阻塞当前线程,不具备开启线程能力，所以添加到并发队列的依然会在主线程进行串行操作。可以认为 并发是我们的目的，多线程是我们实现的手段，当无法开辟多个线程时候，我们将失去并发的能力。
   
   所以打印的顺序 是 "1" -> "2" -> "3" -> "end"
  
   */
  
}


///! 并发队列异步操作
- (void)asyncConcurrent {
  
  dispatch_queue_t queue = dispatch_queue_create("com.asyncConcurrent", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async(queue, ^{
    NSLog(@"1%@",[NSThread currentThread]);
  });
  
  dispatch_async(queue, ^{
    NSLog(@"2%@",[NSThread currentThread]);
  });

  dispatch_async(queue, ^{
    NSLog(@"3%@",[NSThread currentThread]);
    ///! showLog 不会打印
    [self performSelector:@selector(showLog) withObject:nil afterDelay:1];
  });

  NSLog(@"end%@",[NSThread currentThread]);
  
  /*
   异步操作，不会阻塞当前线程，将3个任务异步添加到 一个并发队列时。为了实现并发操作，开辟了3条子线程，
   所以将先打印 "end",  "1" "2" "3" 随机打印
   
   
   */
  
  
}


///! 并发队列 嵌套
- (void)testFirst {
  
  dispatch_queue_t queue = dispatch_queue_create("com.syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_sync(queue, ^{
    NSLog(@"1");
    
    dispatch_async(queue, ^{
//      sleep(1);
      NSLog(@"2%@",[NSThread currentThread]);
    });
    
    NSLog(@"3");
    
    dispatch_async(queue, ^{
//      sleep(1);
      NSLog(@"4%@",[NSThread currentThread]);
    });
    
  });

  NSLog(@"end");
  
  /*
   1. 是同步操作， 阻塞当前主线程， 所以先打印 "1"
   2. 是 异步操作，不阻塞当前线程，并且已经开辟线程，
   3. 日志“3" 操作在主线程中，所以会打印 ”3“
   4. 和”2“一样，异步操作，不阻塞当前线程，并且会开辟新的线程(2 和 4 是并发，互不干扰)
   5.主线程执行完毕， 打印 "end"
   
   所以会先打印  "1" -> "3" - > "end", 然后 "2" 和 "4" 随机打印

   
   */
  
}

//! 并发队列
- (void)testSecond {
  
  dispatch_queue_t queue = dispatch_queue_create("com.syncConcurrent", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async(queue, ^{
    sleep(1);
    NSLog(@"1%@",[NSThread currentThread]);
    
    dispatch_sync(queue, ^{
      NSLog(@"2%@",[NSThread currentThread]);
    });
    
    NSLog(@"3");
    
    dispatch_sync(queue, ^{
      NSLog(@"4%@",[NSThread currentThread]);
    });
    
    
  });
  
  NSLog(@"end");
  
  /*
   分析：
   异步不影响主线程，会开辟子线程，所以优先打印 end。
   子线程的任务都是同步操作，那么在并发队列中，并不需要重新开辟线程，所以依次打印 1，2，3，4
   最终打印如下
   "end" -> "1" -> "2" -> "3" -> "4"
   
   
   
   */

}


#pragma private methods

- (void)showLog {
  NSLog(@"showLogo%@",[NSThread currentThread]);
}

@end
