//
//  NSObject+YTKVO.h
//  KVOCustom
//
//  Created by Yutian Duan on 2020/5/5.
//  Copyright © 2020年 Lingzhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YTKVO)

//!  添加观察者
- (void)yt_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

// 删除观察者
- (void)yt_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end


