//
//  MacroVC.m
//  RAC-第三课
//
//  Created by Yutian Duan on 2018/11/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#import "MacroVC.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface MacroVC ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *field;

@end

@implementation MacroVC

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"简单宏的用法";
  
  _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
  _label.textColor = [UIColor redColor];
  [self.view addSubview:_label];

  _field = [[UITextField alloc] initWithFrame:CGRectMake(100, 200, 200, 45)];
  _field.backgroundColor = [UIColor grayColor];
  [self.view addSubview:_field];
  
  [self racSignal];

  [self racObserver];
}

- (void)racSignal {
  /*
  //! 监听文本输入
  [_field.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
    NSLog(@"输入%@",x);
   _label.text = x;
  }];
  */
  
  //给某个对象的某个属性绑定信号,一旦信号产生数据,就会将内容赋值给属性!,可以用来替换上一句
  RAC(_label,text) = _field.rac_textSignal;

}

- (void)racObserver {
  
  //只要这个对象的属性发生变化..信号就发送数据!! 初次监听 就会触发
  [RACObserve(self.label, text) subscribeNext:^(id  _Nullable x) {
    NSLog(@"发现label变化%@",x);
  }];

}

- (void)RACTuple {
  
  //包装元祖
  RACTuple * tuple = RACTuplePack(@1,@2);
  //解包!!
  RACTupleUnpack(NSNumber *number1,NSNumber *NSNumber2) = tuple;
  
  NSLog(@"%@,%@",number1,NSNumber2);

}

- (void)dealloc {
  NSLog(@"Macro dealloc");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
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

