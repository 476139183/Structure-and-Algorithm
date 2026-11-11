//
//  NSObject+YTKVC.h
//  Kvo
//
//  Created by 段雨田 on 2020/1/22.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YTKVC)

/*
 大致 实现一下 KVC 的逻辑
 
 */
- (void)yt_setValue:(nullable id)value forKey:(NSString *_Nonnull)key;

@end


