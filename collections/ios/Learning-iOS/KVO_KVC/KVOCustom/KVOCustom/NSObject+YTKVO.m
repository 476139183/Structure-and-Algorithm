//
//  NSObject+YTKVO.m
//  KVOCustom
//
//  Created by Yutian Duan on 2020/5/5.
//  Copyright © 2020年 Lingzhu. All rights reserved.
//

#import "NSObject+YTKVO.h"
#import <objc/message.h>


static NSString *const kYTKVOPrefix = @"kYTKVO_";
static NSString *const kYTKVOAssioKey = @"kYTKVOAssociatedKey";


@implementation NSObject (YTKVO)

- (void)yt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
  
  //! 1. 动态创建一个子类
  Class newClass = [self createClass:keyPath];

  //! 2. 修改了isa的指向
  object_setClass(self, newClass);
     
  //! 3. 关联方法, 用 set方法 作为key
  SEL setSEL = NSSelectorFromString(setterfromGetter(keyPath));
  objc_setAssociatedObject(self, setSEL, observer, OBJC_ASSOCIATION_ASSIGN);
  
}

/// 移除观察者
- (void)yt_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {

  // 父类
  Class superClass = [self class]; //,此时的class方法 = class_getSuperclass(object_getClass(self));
  //! 修改 isa指向
  object_setClass(self, superClass);
  // 关联方法
  SEL setSEL = NSSelectorFromString(setterfromGetter(keyPath));
  objc_setAssociatedObject(self, setSEL, observer, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - c 函数
static void YTSetIntValueAndNotify(id self, SEL _cmd, id newValue) {
   
  struct objc_super superStruct = {
    self,
    class_getSuperclass(object_getClass(self))
  };
    
  // 改变父类的值
  ((void (*)(struct objc_super*, SEL, id))(void *)objc_msgSendSuper)(&superStruct, _cmd, newValue);
    
  NSString *setterName = NSStringFromSelector(_cmd);

  SEL setSEL = NSSelectorFromString(setterName);

  // 通知观察者， 值发生改变了
  // 观察者
  id observer = objc_getAssociatedObject(self, setSEL);
  
  NSString *key = getterfromSetter(setterName);
    
  ((void (*)(id, SEL,id,id,NSDictionary<NSKeyValueChangeKey,id> *,void *))(void *)objc_msgSend)(observer, @selector(observeValueForKeyPath:ofObject:change:context:), key, self, @{key:newValue}, nil);
}

#pragma mark - prive func

// YTKVONotifying_XXX
- (Class) createClass:(NSString*) keyPath {
   
  // 1. 拼接子类名
  NSString *oldName = NSStringFromClass([self class]);
  NSString *newName = [NSString stringWithFormat:@"YTKVONotifying_%@", oldName];
    
  // 2. 创建并注册类
  Class newClass = NSClassFromString(newName);
 
  if (!newClass) {
    // 创建并注册类
    newClass = objc_allocateClassPair([self class], newName.UTF8String, 0);
        objc_registerClassPair(newClass);
       
    // 添加一些方法
    // 1. class
    Method classMethod = class_getInstanceMethod([self class], @selector(class));
        const char* classTypes = method_getTypeEncoding(classMethod);
    class_addMethod(newClass, @selector(class), (IMP)YTKVO_Class, classTypes);
        
    // 2. setter
    NSString *setterMethodName = setterfromGetter(keyPath);
    SEL setterSEL = NSSelectorFromString(setterMethodName);
    Method setterMethod = class_getInstanceMethod([self class], setterSEL);
    const char* setterTypes = method_getTypeEncoding(setterMethod);
    class_addMethod(newClass, setterSEL, (IMP)YTSetIntValueAndNotify, setterTypes);
  }
  
  return newClass;
}

//! 获取父类isa，替换了 [self class]
static Class YTKVO_Class(id self,SEL _cmd) {
  return class_getSuperclass(object_getClass(self));
}

//! 从get方法获取set方法的名称,  key ===>> setKey:
static NSString * setterfromGetter(NSString * getter) {
  
  if (getter.length <= 0) { return nil;}
  NSString *firtString = [[getter substringToIndex:1] uppercaseString]; // N
  NSString *leaveString = [getter substringFromIndex:1]; //ame
  
  return [NSString stringWithFormat:@"set%@%@:",firtString,leaveString];
  
}

//! setKey: ===>>> key
static NSString * getterfromSetter(NSString * setter) {
  
  if (setter.length <= 0
      || ![setter hasPrefix:@"set"]
      || ![setter hasSuffix:@":"]) { return nil;}
  
  //setName:  ===>> Name:  ====> Name ==> name
  NSRange range = NSMakeRange(3, setter.length-4);
  NSString *getter = [setter substringWithRange:range];
  NSString *firstString = [[getter substringToIndex:1] lowercaseString]; //n
  getter = [getter stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstString];
  
  return getter;
}


@end
