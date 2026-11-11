//
//  Person.h
//  KVC_Test
//
//  Created by 段雨田 on 2020/5/6.
//  Copyright © 2020 段雨田. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
  @public
  int age;
  
}

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *title;

@end


