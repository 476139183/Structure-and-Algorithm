//
//  recursive.c
//  Recursive-10
//
//  Created by Yutian Duan on 2018/12/11.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "recursive.h"


/*
 假如这里有 n 个台阶，每次你可以跨 1 个台阶或者 2 个台阶，请问走这 n 个台阶有多少种走法？如果有 7 个台阶，你可以 2，2，2，1 这样子上去，也可以 1，2，1，1，2 这样子上去，总之走法有很多，那如何用编程求得总共有多少种走法呢？
 
 */

// 全局变量，表示递归的深度。
int depth = 0;

int findfloor (int n) {
  
  if (n < 1) {
    return 0;
  }
  
  ++depth;
  if (depth > 1000) {
    //! 如果超过此时 不再递归，
    printf("throw exception \n");
    return 0;
  }
  
  if (n == 1 || n == 2) {
    return n;
  }
  
  return findfloor(n-1) + findfloor(n-2);
  
}

//! 将递归代码改为非递归

int newFindFloor (int n) {
  
  if (n < 1) {
    return 0;
  }
  
  if (n == 1 || n == 2) {
    return n;
  }
  
  int ret = 0;
  int pre = 2;
  int prepre = 1;
  
  for (int i = 3; i <= n; ++i) {
    ret = pre + prepre;
    prepre = pre;
    pre = ret;
  }
  return ret;

}
