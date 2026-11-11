//
//  NSObject+KCKVO.h
//  002---KVO自定义
//
//  Created by Cooci on 2018/5/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KCKVOBlock)(id observer,NSString *keyPath,id newValue,id oldValue);

@interface NSObject (KCKVO)

- (void)kc_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath handler:(KCKVOBlock)block;


@end
