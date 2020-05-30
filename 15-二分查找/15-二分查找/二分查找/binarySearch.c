//
//  binarySearch.c
//  15-二分查找
//
//  Created by Yutian Duan on 2018/12/18.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "binarySearch.h"


int binarySearch(int a[],int n, int value);

void setBinarySearch (void) {
  
  //！ 声明一个有序不重复数组,为了方便辨别，这里使用连续有序数组
  int a[19] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19};
  
  
  //! 查找
 int ret = binarySearch(a, 19, 11);
  
  printf("查找位置=%d",ret);
  
}

int binarySearch(int a[],int n, int value) {
  
  int low = 0;
  int high = n-1;
  
  while (low <= high) {
    int mid = (low + high) /2;
    if (a[mid] == value) {
      return mid;
    } else if (a[mid] < value) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
    
  }
  
  return -1;
}


/* 二分查找
 * 时间复杂度为O(logn)
 * 比较依赖数组，且数组为有序
 * 数组小不需要二分查找， 数组大也不方便，因为比较依赖数组，需要 连续的内存空间
 *
 */

