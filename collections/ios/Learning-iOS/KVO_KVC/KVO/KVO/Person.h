//
//  Person.h
//  KVO
//
//  Created by Yutian Duan on 2020/5/2.
//  Copyright © 2020年 Lingzhu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Student;

@interface Person : NSObject {
  @public
  int _age;
  NSString *name;
}

@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) Student *student;
@end


@interface Student : Person
@property (nonatomic, assign) int weight;
@end
