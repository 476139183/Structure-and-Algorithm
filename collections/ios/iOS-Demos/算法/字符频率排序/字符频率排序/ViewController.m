//
//  ViewController.m
//  字符频率排序
//
//  Created by Yutian Duan on 2018/3/26.
//  Copyright © 2018年 duanyutian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


/*
 去掉非字母字符，按照字符出现频率排序
 
 */
- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *newStr = [self stringMostFrequentLetters:@"we attack at dawn"];
  NSLog(@"newStr===%@",newStr);
}

//字母频率排序
- (NSString *)stringMostFrequentLetters:(NSString *)oldStr {
  
  NSString *lowStr = [oldStr lowercaseString];
  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  NSMutableString *newStr = [[NSMutableString alloc] init];
  
  for (NSInteger i = 0; i < lowStr.length; i++) {
    NSString *chat = [lowStr substringWithRange:NSMakeRange(i, 1)];
    if ([self isLowerLetter:chat]) {
      //!
      NSInteger count = [[dic objectForKey:chat] integerValue];
      if (count > 0) {
        count++;
      } else {
        count = 1;
      }
      [dic setObject:@(count) forKey:chat];
    }
    
  }
  
  if (dic.allKeys.count == 0) {
    return nil;
  }
  
  NSMutableArray *numArray = [NSMutableArray arrayWithArray:dic.allKeys];
  
  //!
  [numArray sortUsingComparator: ^NSComparisonResult (NSString *value1, NSString *value2) {
    
    NSNumber *number1 = [NSNumber numberWithInteger:[[dic objectForKey:value1] integerValue]];
    NSNumber *number2 = [NSNumber numberWithInteger:[[dic objectForKey:value2] integerValue]];
    
    NSComparisonResult result = [number1 compare:number2];
    BOOL res = result == NSOrderedAscending;
    if (result == NSOrderedSame) {
      res = [value1 characterAtIndex:0]>[value2 characterAtIndex:0];
    }
    return res;
    
  }];
  
  
  for (NSInteger i = 0; i < numArray.count; i++) {
    NSString *str = numArray[i];
    [newStr appendString:str];
    
  }
  
  return newStr;
  
}

- (BOOL)isLowerLetter:(NSString *)str {
  
  if ([str characterAtIndex:0] >= 'a' && [str characterAtIndex:0] <= 'z') {
    return YES;
  }
  return NO;
  
}



////判断是不是大写字母
//
//- (BOOL)isCatipalLetter:(NSString *)str {
//  if ([str characterAtIndex:0] >= 'A' && [str characterAtIndex:0] <= 'Z') {
//    return YES;
//  }
//  return NO;
//
//}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


@end
