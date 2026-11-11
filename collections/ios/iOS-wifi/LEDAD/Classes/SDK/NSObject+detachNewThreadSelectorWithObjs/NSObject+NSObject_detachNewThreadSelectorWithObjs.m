//
//  NSObject+NSObject_detachNewThreadSelectorWithObjs.m
//  LEDAD
//
//  Created by yixingman on 14/10/21.
//  Copyright (c) 2014年 yxm. All rights reserved.
//

#import "NSObject+NSObject_detachNewThreadSelectorWithObjs.h"

@implementation NSObject (NSObject_detachNewThreadSelectorWithObjs)
+ (void)detachNewThreadSelector:(SEL)aSelector
                       toTarget:(id)aTarget
                     withObject:(id)anArgument
                      andObject:(id)anotherArgument
{
    NSMethodSignature *signature = [aTarget methodSignatureForSelector:aSelector];
    if (!signature) return;

    NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:aTarget];
    [invocation setSelector:aSelector];
    [invocation setArgument:&anArgument atIndex:2];
    [invocation setArgument:&anotherArgument atIndex:3];
    [invocation retainArguments];

    [self detachNewThreadSelector:@selector(invoke) toTarget:invocation withObject:nil];
}
@end
