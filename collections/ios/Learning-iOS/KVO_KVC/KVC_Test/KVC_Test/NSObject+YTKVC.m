//
//  NSObject+YTKVC.m
//  Kvo
//
//  Created by 段雨田 on 2020/1/22.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "NSObject+YTKVC.h"
#import <objc/runtime.h>

@implementation NSObject (YTKVC)

- (void)yt_setValue:(nullable id)value forKey:(NSString *)key {

  ///! 判断key是否合法
  if (key == nil || key.length == 0) {
    return;
  }
  
  NSString *Key = key.capitalizedString;
  ///! 先找相关方法
  NSString *setKey = [NSString stringWithFormat:@"set%@:",Key];
  if ([self respondsToSelector:NSSelectorFromString(setKey)]) {
    [self performSelector:NSSelectorFromString(setKey) withObject:value];
    return;
  }
  
  NSString *_setKey = [NSString stringWithFormat:@"_set%@:",Key];
  if ([self respondsToSelector:NSSelectorFromString(_setKey)]) {
    [self performSelector:NSSelectorFromString(_setKey) withObject:value];
    return;
  }
  
  NSString *setIsKey = [NSString stringWithFormat:@"_setIs%@:",Key];

  if ([self respondsToSelector:NSSelectorFromString(setIsKey)]) {
    [self performSelector:NSSelectorFromString(setIsKey) withObject:value];
    return;
  }
  
  if ([self.class accessInstanceVariablesDirectly] == NO) {
    NSException *exception = [NSException exceptionWithName:@"NSUnKnowKeyException" reason:@"serValue:forUndefineKey" userInfo:nil];
    @throw exception;
  }
  
  ///!再找相关变量
  unsigned int count = 0;
  Ivar *ivars = class_copyIvarList([self class], &count);
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  for (int i = 0; i < count; i++) {
    Ivar var = ivars[i];
    const char *varName = ivar_getName(var);
    NSString *name = [NSString stringWithUTF8String:varName];
    [arr addObject:name];
  }
  /// _<key>
  for (int i = 0; i < count; i++) {
    NSString *keyName = arr[i];
    if ([keyName isEqualToString:[NSString stringWithFormat:@"_%@",key]]) {
      object_setIvar(self, ivars[i], value);
      free(ivars);
      return;
    }
  }
  
  /// _is<Key>
  for (int i = 0; i < count; i++) {
    NSString *keyName = arr[i];
    if ([keyName isEqualToString:[NSString stringWithFormat:@"__is%@",Key]]) {
      object_setIvar(self, ivars[i], value);
      free(ivars);
      return;
    }
  }
  
  /// <key>
  for (int i = 0; i < count; i++) {
    NSString *keyName = arr[i];
    if ([keyName isEqualToString:[NSString stringWithFormat:@"%@",key]]) {
      object_setIvar(self, ivars[i], value);
      free(ivars);
      return;
    }
  }
  
  /// is<Key>
  for (int i = 0; i < count; i++) {
    NSString *keyName = arr[i];
    if ([keyName isEqualToString:[NSString stringWithFormat:@"is%@",Key]]) {
      object_setIvar(self, ivars[i], value);
      free(ivars);
      return;
    }
  }

  
}


#pragma mark - 捕获异常
///！ 对非对象类型，值类不能为空
- (void)setNilValueForKey:(NSString *)key {
  NSLog(@"%@ 值不能为空", key);
}

///!  赋值的key值不存在
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
  NSLog(@"赋值key=%@ 值不存在",key);
}

///! 取值的key不存在
- (id)valueForUndefinedKey:(NSString *)key {
  NSLog(@"取值key=%@不存在",key);
  return nil;
}

///! 合法性

@end
