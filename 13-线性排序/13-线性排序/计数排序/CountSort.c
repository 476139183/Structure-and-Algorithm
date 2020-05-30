//
//  CountSort.c
//  13-线性排序
//
//  Created by Yutian Duan on 2018/12/14.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "CountSort.h"

//!
void count_sort (int a[], int n);



void setCount (void) {
  
  //! 声明一个数组
  int a[8] = {2,5,3,0,2,3,0,3};
  //!
  
  count_sort(a, 8);
  
  for (int i = 0; i < 8; ++i) {
    printf("%d,",a[i]);
  }
  
  
}


void count_sort (int a[], int n) {
  
  if (n <= 1) {
    return;
  }
  
  int max = a[0];

  //! 遍历拿出数据范围
  for (int i = 1; i < n; ++i) {
    if (max < a[i]) {
      max = a[i];
    }
  }
  
  //! 申请一个数组c 作为一个桶,并初始化
  int c[max+1];
  for (int i = 0; i <= max; ++i) {
    c[i] = 0;
  }
  
  //! 和桶排序类型,计算每一个元素个数，放入c中,此时 [2,0,2,3,0,1]
  for (int i = 0; i < n; ++i) {
    c[a[i]]++;
  }
  
  //! 依次累加，让数组c里面保存的为小于和等于 i 的个数 [2,2,4,7,7,8];
  for (int i = 1; i <= max; ++i) {
    c[i] = c[i-1] + c[i];
  }
  
  
  //！临时数组r 存排序后的结果
  int r[n];
  //! 对临时数组进行初始化赋值
  for (int i = 0; i < n; ++i) {
    r[i] = 0;
  }
  
  //! (1)开始排序,逆向访问
  for (int i = n-1; i >= 0; --i) {
    //!
    int index = c[a[i]] - 1;
    r[index] = a[i];
    c[a[i]]--;
  }
  
  //! 将结果拷贝到 a数组
  for (int i = 0; i < n; ++i) {
    a[i] = r[i];
  }
  
  
}

/* 线性排序 思路是 从后往前 取数据
 （1） i = 7 时，对应为a[i] = 3,  那么，c[3] = 7, index = 6, 那么r[6] = a[3] = 3
  既保存我们取出来的3在 数组r的 第6位，同时c[3]计数减1。
 
 
 */


