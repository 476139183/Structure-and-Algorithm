//
//  NestViewController.m
//  KVO
//
//  Created by 段雨田 on 2020/6/11.
//  Copyright © 2020 Lingzhu. All rights reserved.
//

#import "NestViewController.h"
#import "Person.h"
#import <objc/runtime.h>

/*
https://developer.apple.com/library/archive/navigation/
*/

@interface NestViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation NestViewController


///! 打印类的方法列表
- (void)printMethodNameOfClass:(Class)cls {
  unsigned int count;
  Method *methodList = class_copyMethodList(cls, &count);
  NSLog(@"%@:\n",NSStringFromClass(cls));
  for (int i = 0; i < count; i++) {
    Method method = methodList[i];
    NSString *selStr = NSStringFromSelector(method_getName(method));
    NSLog(@"%@",selStr);
  }
  free(methodList);
}

- (void)viewDidLoad {
   
  [super viewDidLoad];
  
   
  _person = [[Person alloc] init];
    
  _person.age = 10;

  [_person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];
  [_person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];

    
  // (IMP) setAge = 0x00007fff257223da (Foundation`_NSSetIntValueAndNotify)
  IMP setAge = [_person methodForSelector:@selector(setAge:)];
    
  //！ 修改了 class 方法，
  [_person class];
  
  //！(IMP) getClass = 0x00007fff2572073d (Foundation`NSKVOClass)
  IMP getClass = [_person methodForSelector:@selector(class)];

  _person.age += 10;

    
    //  _person.colors = [[NSMutableArray alloc] init];
  //  [_person addObserver:self forKeyPath:@"colors" options:NSKeyValueObservingOptionNew context:NULL];
  //  [_person addObserver:self forKeyPath:@"colors" options:NSKeyValueObservingOptionNew context:NULL];
  //  [_person addObserver:self forKeyPath:@"colors" options:NSKeyValueObservingOptionNew context:NULL];
  //  [_person addObserver:self forKeyPath:@"colors" options:NSKeyValueObservingOptionNew context:NULL];

    //! 这段代码不会触发的kvo
  //  [_person.colors addObject:@"1"];
    ///! 这段代码会触发
  //  NSMutableArray *tempArray = [_person mutableArrayValueForKey:@"colors"];
  //  [tempArray insertObject:@"2" atIndex:0];
    
    //! 获取注册的观察者信息，查看注释了解更多
  //  NSLog(@"%@",_person.observationInfo);
    
    [self printMethodNameOfClass:object_getClass(_person)];
    
    
  //  _person.student = [[Student alloc] init];
    
  //  [_person setValue:@"200" forKeyPath:@"student.weight"];
    
  //  [_person removeObserver:self forKeyPath:@"age"];


}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  _person->name = @"newName";
  _person.age += 10;
//  _person->_age += 10;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  NSLog(@"change=%@",change);
}

- (void)dealloc {
  NSLog(@"\n");
  BOOL isKVO = [_person performSelector:@selector(_isKVOA)];
  NSLog(@"isKVO:%d",isKVO);
  //！
  [_person removeObserver:self forKeyPath:@"age"];
  [_person removeObserver:self forKeyPath:@"age"];
  isKVO = [_person performSelector:@selector(_isKVOA)];
  NSLog(@"isKVO:%d",isKVO);
  //! isa 又重新指向 Person
  NSLog(@"%@",object_getClass(_person));
  
  NSLog(@"dealloc");

}

@end
