//
//  Person.m
//  KVO
//
//  Created by Yutian Duan on 2020/5/2.
//  Copyright © 2020年 Lingzhu. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person

- (instancetype)init {
  self = [super init];
  if (self) {
  }
  return self;
}

- (void)setAge:(int)age {
  //! 打印isa指向的class
  NSLog(@"%@",object_getClass(self));
  _age = age;
}

- (Class)class {
  //! 重写 隐藏真相，屏蔽内部实现，无感实现KVO内部实现，添加观察者之后，Person.class 并不会调用该方法了
  return [super class];
}

//! 是否自动响应KVO, automaticallyNotifiesObserversOfXXX
+ (BOOL)automaticallyNotifiesObserversOfAge {
  return YES;
}

- (void)willChangeValueForKey:(NSString *)key {
  [super willChangeValueForKey:key];
}

- (void)didChangeValueForKey:(NSString *)key {
  [super didChangeValueForKey:key];
  
}

//- (BOOL)_isKVOA {
//  return YES;
//}

- (void)setHeight:(NSString *)height {
  NSLog(@"setHeight");
}

/*
- (void)setSuperAge:(NSInteger)age {
  _NSSetIntValueAndNotify();
}


void _NSSetIntValueAndNotify () {
  [self willChangeValueForKey:@"age"];
  [super setAge:age];
  [self didChangeValueForKey:@"age"];
}


- (void)didChangeValueForKey:(NSString *)key {
  ///! 通知监听器，某属性值发生了改变
  [obrser observeValueForKeyPath:key ofObject:self change:nil context:nil];
}
*/


@end

@implementation Student

@end
