//
//  Person.m
//  KVC_Test
//
//  Created by 段雨田 on 2020/5/6.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import "Person.h"

@implementation Person

///! 验证age的正确性,超过 100 不可以赋值
- (BOOL)validateAge:(inout id  _Nullable __autoreleasing *)ioValue error:(out NSError * _Nullable __autoreleasing *)outError {
  
  NSNumber *value = (NSNumber *)(*ioValue);
  if ([value intValue] <= 0 || [value intValue] > 100) {
    return NO;
  } else {
    return YES;
  }
  
}

@end
