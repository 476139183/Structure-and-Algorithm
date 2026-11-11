//
//  BindVC.m
//  RAC-第四课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "BindVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

#import <ReactiveObjC/RACReturnSignal.h>

/*  场景： 对源信号的数据进行处理 再返回，比如对数据进行解析等
 *  bindSignal
 *
 *
 */

@interface BindVC ()

@end

@implementation BindVC

- (void)viewDidLoad {
  [super viewDidLoad];


  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"绑定信号";

  /*
   // bind方法参数:需要传入一个返回值是RACStreamBindBlock的block参数
   // RACStreamBindBlock是一个block的类型，返回值是信号，参数（value,stop），因此参数的block返回值也是一个block。

   // RACStreamBindBlock:
   // 参数一(value):表示接收到信号的原始值，还没做处理
   // 参数二(*stop):用来控制绑定Block，如果*stop = yes,那么就会结束绑定。
   // 返回值：信号，做好处理，在通过这个信号返回出去，一般使用RACReturnSignal,需要手动导入头文件RACReturnSignal.h。

   */

  //! 1. 创建信号
  RACSubject *subject = [RACSubject subject];
  
  // 2. 绑定信号
  RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
    
    /*
    RACSignal * _Nullable (^RACSignalBindBlock)(ValueType _Nullable value, BOOL *stop);

     */
    return ^RACSignal *(id  value, BOOL *stop) {
      /* value 源信号发送的消息
       * 只要源信号发送数据，即可调用这个block
       */
      NSLog(@"%@",value);
      if ([value isKindOfClass:[NSString class]]) {
        value = @"操作数据";
      }
      return [RACReturnSignal return:value];
    };
  }];
  
  //! 3.订阅信号
  [bindSignal subscribeNext:^(id  _Nullable x) {
    NSLog(@"bind=%@",x);
  }];
  
  //! 4.发送信号
  [subject sendNext:@"发送原始数据"];

}


/*
 
 // bind方法使用步骤:
 // 1.传入一个返回值RACStreamBindBlock的block。
 // 2.描述一个RACStreamBindBlock类型的bindBlock作为block的返回值。
 // 3.描述一个返回结果的信号，作为bindBlock的返回值。
 // 注意：在bindBlock中做信号结果的处理。
 
 // 底层实现:
 // 1.源信号调用bind,会重新创建一个绑定信号。
 // 2.当绑定信号被订阅，就会调用绑定信号中的didSubscribe，生成一个bindingBlock。
 // 3.当源信号有内容发出，就会把内容传递到bindingBlock处理，调用bindingBlock(value,stop)
 // 4.调用bindingBlock(value,stop)，会返回一个内容处理完成的信号（RACReturnSignal）。
 // 5.订阅RACReturnSignal，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。
 
 // 注意:不同订阅者，保存不同的nextBlock，看源码的时候，一定要看清楚订阅者是哪个。

 
 
 */


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)dealloc {
  NSLog(@"BindVC dealloc");
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

