//
//  NestViewController.m
//  KVOCustom
//
//  Created by 段雨田 on 2020/6/11.
//  Copyright © 2020 Lingzhu. All rights reserved.
//

#import "NestViewController.h"
#import "Person.h"
#import "NSObject+YTKVO.h"

@interface NestViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation NestViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  _person = [[Person alloc] init];
  _person.name = @"UC";
  [_person yt_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  _person.name = @"Tom";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
  NSLog(@"%@", change);
}

- (void) dealloc {
  /// 移除观察者
  [_person yt_removeObserver:self forKeyPath:@"name"];
  NSLog(@"dealloc");
  
  //! 移除后，子类的类对象依然存在内存中
  
}






@end
