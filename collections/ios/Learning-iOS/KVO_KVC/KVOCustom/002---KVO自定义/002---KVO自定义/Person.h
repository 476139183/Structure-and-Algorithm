//
//  Person.h
//  002---KVO自定义
//
//  Created by Cooci on 2018/5/20.
//  Copyright © 2018年 Cooci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    @public
    NSString *age;
}

@property (nonatomic, copy) NSString *name;

@end
