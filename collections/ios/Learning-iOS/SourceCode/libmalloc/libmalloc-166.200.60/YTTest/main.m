//
//  main.m
//  YTTest
//
//  Created by 段雨田 on 2020/4/17.
//

#import <Foundation/Foundation.h>
#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
	void *p = calloc(1, 24);
	NSLog(@"%lu",malloc_size(p));
  }
  return 0;
}
