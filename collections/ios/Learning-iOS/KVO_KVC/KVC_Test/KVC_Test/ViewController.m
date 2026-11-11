//
//  ViewController.m
//  KVC_Test
//
//  Created by 段雨田 on 2020/5/6.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation ViewController

- (void)viewDidLoad {
 
  [super viewDidLoad];
  
  
  
  
  _person = [[Person alloc] init];

  
  
  NSNumber *bigAge = @(50);
  //！ 验证是否存在 age
  if ([_person validateValue:&bigAge forKey:@"age" error:NULL]) {
    ///! kvc 赋值
    [_person setValue:bigAge forKey:@"age"];
  }
  
  
  ////! 组合方式赋值
  NSDictionary *dict = @{
                         @"name":@"newName",
                         @"title":@"oldTitle",
                         @"age":@(200)
                         };
  
  [_person setValuesForKeysWithDictionary:dict];
  
  
  
  ///! 获取对于的key 的 value 集合
  NSArray *keys = @[@"name",@"title"];
  NSDictionary *valuesDic = [_person dictionaryWithValuesForKeys:keys];
   
  
}


////! 消息传递：获取数组 arr 元素 所有的 length,并组成一个新的数组
- (void)arrayKVCTest {
  
  NSArray *arr = @[@"Monday",@"Tuesday",@"Wednesday"];
  NSArray *lengthArr = [arr valueForKey:@"length"];
  NSLog(@"%@",lengthArr);
  
}

///！1.聚合操作(@avg @count @max @min @sum)
- (void)contrainerTest {
  NSMutableArray *students = [NSMutableArray array];
  for (NSInteger i = 0; i < 6; i ++) {
    Person *student = [[Person alloc] init];
    NSDictionary *dict = @{
                           @"name":@"newName",
                           @"title":@"oldTitle",
                           @"age":@(2+arc4random_uniform(5))
                           };
    
    [student setValuesForKeysWithDictionary:dict];
    [students addObject:student];
  }
  ///! 所有
  NSLog(@"ages=%@",[students valueForKey:@"age"]);
  ///! 平均
  float avg = [[students valueForKeyPath:@"@avg.age"] floatValue];
  NSLog(@"%f",avg);

  
}

///! 2. 数组操作 去重和不去重 @"distinctUnionOfObjects" @"unionOfObjects"
- (void)contrainerArrayTest {
  
  NSMutableArray *students = [NSMutableArray array];
  for (NSInteger i = 0; i < 6; i ++) {
    Person *student = [[Person alloc] init];
    NSDictionary *dict = @{
                           @"name":@"newName",
                           @"title":@"oldTitle",
                           @"age":@(2+arc4random_uniform(5))
                           };
    
    [student setValuesForKeysWithDictionary:dict];
    [students addObject:student];
  }
  ///! 所有
  NSLog(@"ages=%@",[students valueForKey:@"age"]);
  ///! 去重
  NSArray *newArr = [students valueForKeyPath:@"distinctUnionOfObjects.age"];
  // 不去重 NSArray *newArr = [students valueForKeyPath:@"unionOfObjects.age"];
}

///! 3. 嵌套集合(array & set)操作 @"distinctUnionOfArrays" @"unionOfArrays" @"distinctUnionOfSets"
- (void)containerNestTest {
  
  NSMutableArray *students = [NSMutableArray array];
  NSMutableArray *students1 = [NSMutableArray array];

  for (NSInteger i = 0; i < 6; i ++) {
    Person *student = [[Person alloc] init];
    NSDictionary *dict = @{
                           @"name":@"newName",
                           @"title":@"oldTitle",
                           @"age":@(2+arc4random_uniform(5))
                           };
    
    [student setValuesForKeysWithDictionary:dict];
    [students addObject:student];
  }
  
  for (NSInteger i = 0; i < 6; i ++) {
    Person *student = [[Person alloc] init];
    NSDictionary *dict = @{
                           @"name":@"newName",
                           @"title":@"oldTitle",
                           @"age":@(2+arc4random_uniform(5))
                           };
    
    [student setValuesForKeysWithDictionary:dict];
    [students1 addObject:student];
  }
  
  //// 嵌套数组
  NSArray *nestArr = @[students,students1];
  //// 去重复
  NSArray *arr = [nestArr valueForKeyPath:@"@distinctUnionOfArrays.age"];
  ///！ 不去重复
  NSArray *arr1 = [nestArr valueForKeyPath:@"@unionOfArrays.age"];

  
}

- (void)containerSetsTest {
  
  NSMutableSet *students = [NSMutableSet set];
  NSMutableSet *students1 = [NSMutableSet set];

  for (NSInteger i = 0; i < 6; i ++) {
    Person *student = [[Person alloc] init];
    NSDictionary *dict = @{
                           @"name":@"newName",
                           @"title":@"oldTitle",
                           @"age":@(2+arc4random_uniform(5))
                           };
    
    [student setValuesForKeysWithDictionary:dict];
    [students addObject:student];
  }
  
  NSLog(@"==%@",[students valueForKey:@"age"]);
  
  for (NSInteger i = 0; i < 6; i ++) {
    Person *student = [[Person alloc] init];
    NSDictionary *dict = @{
                           @"name":@"newName",
                           @"title":@"oldTitle",
                           @"age":@(2+arc4random_uniform(5))
                           };
    
    
    [student setValuesForKeysWithDictionary:dict];
    [students1 addObject:student];
  }
  
  NSSet *nestSet = [NSSet setWithObjects:students,students1, nil];
  
  ///!
  NSArray *arr1 = [nestSet valueForKeyPath:@"@distinctUnionOfSets.age"];
 
}

@end
