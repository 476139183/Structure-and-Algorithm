//
//  CountingSort.c
//  LinearSort
//
//  Created by 段雨田 on 2019/11/12.
//  Copyright © 2019 段雨田. All rights reserved.
//

#include "CountingSort.h"
//! 初始化库
#include <stdlib.h>
#include <string.h>

#include <assert.h>


////! 计数排序
void count_sort(int arr[], int n);

void setCount(void) {
  
  int arr[10] = {1,5,6,8,10,9,3,1,2,1};
  
  //! 计算数组arr 的个数n
  
  count_sort(arr,10);
  
  for (int i = 0; i < 10; i++) {
    printf("%d,",arr[i]);
  }
  
}

void count_sort(int arr[], int n) {
  
  int i = 0;
  int max = 0;
  int *count = 0;
  int *res = 0;
  
  /*找到最大数*/
  for (i = 0 ; i< n; i++) {
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  ///! 创建一个计数数组，并且初始化数据
  count = (int *)malloc(sizeof(int)*(max + 1));
  assert(count != NULL);

  memset(count,0,sizeof(int)*(max + 1));
  
  /*计数*/
  for (i = 0; i < n;i++) {
    count[arr[i]]++;
  }
  
  /*依次累加*/
  for(i = 1 ;i <= max; i ++) {
    count[i] += count[i-1];
  }
  ///！ 创造一个接收结果的数组
  res = (int *)malloc(sizeof(int)*(n));
  assert(res != NULL);
  
  /*核心代码，count[a[i] - 1]就是排序好的下标*/
  for (i = n-1;i >= 0; i--) {
    res[count[arr[i]] -1] = arr[i];
    count[arr[i]]--;
  }
  
  ///！ 复制到原数组中
  memcpy(arr,res,n*(sizeof(int)));
  
  free(res);
  free(count);
  
  
}

/* 计数排序，时间复杂度 O(n)，非原地排序
 * 计数排序也是利用桶排序的解决方式
 * 如果数组最大值max比数组大小n 大很多则不适合；
 * 计数排序要求时非负整数
 * */
