//
//  ViewController.m
//  RAC-第二课
//
//  Created by Yutian Duan on 2018/11/16.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACReturnSignal.h>

#import "KFCModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
}

//！ 元祖 解析
- (void)tuple {
  
  RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"我",@"才刚到",@(12)]];
  
  /*
   tuple[0],
   tuple[1],
   tuple[2]
   */
  /* 也可用宏直接解析 */
  RACTupleUnpack(NSString *name, NSString *action, NSNumber *age) = tuple;
  NSLog(@"元祖\n%@,%@,%@\n",name,action,age);
}

/*
 RACSequence:用于代替NSArray,NSDictionary,可以使用快速的遍历
 */

//! 数组解析
- (void)subArray {
  
  NSArray *arr = @[@"我",@"真",@"的",@"才",@(12)];
  NSLog(@"数组遍历\n");
  
  /*
   RACSequence * requence = [arr rac_sequence];
   RACSignal * signal = [requence signal];
   [signal subscribeNext:^(id  _Nullable x) {
     NSLog(@"%@",x);
   }];
   */
  
  [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@",x);
  }];
  
  
}

//! 字典解析
- (void)subDictionnary {
  NSDictionary *dic = @{
                        @"name":@"段",
                        @"age":@(12)
                        };
  
  NSLog(@"字典解析\n");
  [dic.rac_sequence.signal subscribeNext:^(RACTwoTuple *x) {
    RACTupleUnpack(NSString *key,NSString *value) = x;
    NSLog(@"%@=%@",key,value);
  }];
}

//! 复合数据解析
/*
 // Map作用:把源信号的值映射成一个新的值
 
 // Map使用步骤:
 // 1.传入一个block,类型是返回对象，参数是value
 // 2.value就是源信号的内容，直接拿到源信号的内容做处理
 // 3.把处理好的内容，直接返回就好了，不用包装成信号，返回的值，就是映射的值。
 
 // Map底层实现:
 // 0.Map底层其实是调用flatternMap,Map中block中的返回的值会作为flatternMap中block中的值。
 // 1.当订阅绑定信号，就会生成bindBlock。
 // 3.当源信号发送内容，就会调用bindBlock(value, *stop)
 // 4.调用bindBlock，内部就会调用flattenMap的block
 // 5.flattenMap的block内部会调用Map中的block，把Map中的block返回的内容包装成返回的信号。
 // 5.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
 // 6.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。

 */
- (void)mapPlist {
  
  NSString * filePath = [[NSBundle mainBundle] pathForResource:@"kfc.plist" ofType:nil];
  NSArray * dictArr = [NSArray arrayWithContentsOfFile:filePath];
  NSLog(@"复杂数据解析\n");
  /*
   NSMutableArray * modelArr = [NSMutableArray array];
   [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary * x) {
     KFCModel * kfc = [KFC mj_keywithVaule:x];
     [modelArr addObject:kfc];
   }];
   */
  
  // 能把集合中所有元素都映射成一个新的对象
  NSArray *modelArr = [[dictArr.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
    NSLog(@"value");
    // value:集合中元素
    // id:返回对象就是映射的值
    return [KFCModel mj_keywithVaule:value];
    
  }] toArray];

  NSLog(@"%@",modelArr);
  
}

/*
 
 // Map和flattenMap的区别:
 // 1.flattenMap中的Block返回信号。
 // 2.Map中的Block返回对象。
 // 3.开发中，如果信号发出的值不是信号，映射一般使用Map
 // 4.开发中，如果信号发出的值是信号，映射一般使用flattenMap。

 
 */

- (void)signalOfsignals {
  // flattenMap:用于信号中信号
  RACSubject *signalOfsignals = [RACSubject subject];
  
  RACSubject *signal = [RACSubject subject];
  
  // 订阅信号
  //    [signalOfsignals subscribeNext:^(RACSignal *x) {
  //
  //        [x subscribeNext:^(id x) {
  //            NSLog(@"%@",x);
  //        }];
  //
  //    }];
  
  //    RACSignal *bindSignal = [signalOfsignals flattenMap:^RACStream *(id value) {
  //        // value:源信号发送内容
  //        return value;
  //    }];
  //
  //    [bindSignal subscribeNext:^(id x) {
  //
  //        NSLog(@"%@",x);
  //    }];
    
  [[signalOfsignals flattenMap:^__kindof RACStream *(id value) {
    return value;
    
  }] subscribeNext:^(id x) {
    // 只有signalOfsignals的signal发出信号才会调用，因为内部订阅了bindBlock返回的信号，也就是flattenMap返回的信号。
    // 也就是flattenMap返回的信号发出内容，才会调用。
    NSLog(@"%@",x);
    
  }];
  
  // 发送信号
  [signalOfsignals sendNext:signal];
  [signal sendNext:@"213"];

  
}


/*
 // flattenMap作用:把源信号的内容映射成一个新的信号，信号可以是任意类型。
 
 // flattenMap使用步骤:
 // 1.传入一个block，block类型是返回值RACStream，参数value
 // 2.参数value就是源信号的内容，拿到源信号的内容做处理
 // 3.包装成RACReturnSignal信号，返回出去。
 
 // flattenMap底层实现:
 // 0.flattenMap内部调用bind方法实现的,flattenMap中block的返回值，会作为bind中bindBlock的返回值。
 // 1.当订阅绑定信号，就会生成bindBlock。
 // 2.当源信号发送内容，就会调用bindBlock(value, *stop)
 // 3.调用bindBlock，内部就会调用flattenMap的block，flattenMap的block作用：就是把处理好的数据包装成信号。
 // 4.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
 // 5.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。
 

 */
- (void)flattenMap {
  // 创建信号
  RACSubject *subject = [RACSubject subject];
  
  // 绑定信号
  RACSignal *bindSignal = [subject flattenMap:^ __kindof RACStream *(id value) {
    // block:只要源信号发送内容就会调用
    // value:就是源信号发送内容
    
    value = [NSString stringWithFormat:@"xmg:%@",value];
    
    // 返回信号用来包装成修改内容值
    
    return [RACReturnSignal return:value];
    
  }];
  
  // flattenMap中返回的是什么信号,订阅的就是什么信号
  
  // 订阅信号
  [bindSignal subscribeNext:^(id x) {
    // 订阅绑定信号，每当源信号发送内容，做完处理，就会调用这个block。
    NSLog(@"%@",x);
  }];
  
  
  // 发送数据
  [subject sendNext:@"123"];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  static int i = 0;
  i++;

  switch (i%4) {
    case 0: {
      [self tuple];
    }
      break;
    case 1: {
      [self subArray];
    }
      break;
    case 2: {
      [self subDictionnary];
    }
      break;
    case 3: {
      [self mapPlist];
    }
      break;
    default:
      break;
  }
  
}


@end
