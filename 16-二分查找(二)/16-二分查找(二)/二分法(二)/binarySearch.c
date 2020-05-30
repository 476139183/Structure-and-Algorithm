//
//  binarySearch.c
//  16-二分查找(二)
//
//  Created by Yutian Duan on 2019/1/14.
//  Copyright © 2019年 Wanwin. All rights reserved.
//

#include "binarySearch.h"

///! 二分法查找第一个给定数值的元素
int binarySearch_first(int a[], int n, int value);
///! 二分法查找最后一个给定数值的元素
int binarySearch_last(int a[], int n, int value);
///！ 二分法查找第一个大于等于给定值的元素
int binarySearch_firstGreater(int a[], int n, int value);
///! 二分法查找第一个小于等于给定值的元素
int binarySearch_firstLess(int a[], int n, int value);

void binarySearch(void) {
  
  int a[10] = {5,6,6,9,10,11,11,22,33,33};

  //  二分法查找第一个给定数值的元素
  int first = binarySearch_first(a, 10, 11);
  // 二分法查找最后一个给定数值的元素
  int second = binarySearch_last(a,10,11);
  // 二分法查找第一个大于等于给定值的元素
  int three = binarySearch_firstGreater(a, 10, 12);
  // 二分法查找第一个小于等于给定值的元素
  int four = binarySearch_firstLess(a, 10, 12);
  /* 应该输出
   5,
   6,
   7,
   6
   */
  printf("\n%d,\n%d,\n%d,\n%d",first,second,three,four);
  
}


///! 1.二分法查找第一个给定数值的元素
int binarySearch_first(int a[], int n, int value) {
  int mid = 0;
  int left = 0;
  int right = n - 1;
  
  while (left <= right) {
    
    mid = left + ((right-left)>>1);
    
    if (a[mid] < value) {
      left = mid + 1;
    } else if (a[mid] > value) {
      right = mid - 1;
    } else {
      if (mid == 0 || a[mid -1] != value) {
        return mid;
      } else {
        right = mid - 1;
      }
    }
  }
  
  return -1;
}

///! 2.二分法查找最后一个给定数值的元素
int binarySearch_last(int a[], int n, int value) {
  int mid, left = 0;
  int right = n - 1;
  while (left <= right) {
    
    mid = left + ((right-left)>>1);
    
    if (a[mid] < value) {
      left = mid + 1;
    } else if (a[mid] > value) {
      right = mid -1;
    } else {
      if ((mid == n-1) || (a[mid + 1] != value))  {
        return mid;
      } else {
        left = mid + 1;
      }
    }
  }
  
  return -1;
}

///！ 3.二分法查找第一个大于等于给定值的元素
int binarySearch_firstGreater(int a[], int n, int value) {
  
  int mid,left = 0;
  int right = n - 1;
  
  while (left <= right) {
    
    mid = left + ((right-left)>>1);
    
    if (a[mid] < value) {
      left = mid + 1;
    } else {
      if (mid == 0 || a[mid-1] < value) {
        return mid;
      } else {
        right = mid - 1;
      }
    }
  }
  
  return -1;
  
}

///! 4.二分法查找第一个小于等于给定值的元素
int binarySearch_firstLess(int a[], int n, int value) {
  
  int mid,left = 0;
  int right = n - 1;
  
  while (left <= right) {
    mid = left + ((right-left)>>1);
    if (a[mid] > value) {
      right = mid - 1;
    } else {
      if (mid == n-1 || a[mid+1] > value) {
        return mid;
      } else {
        left = mid + 1;
      }
    }
  }
  
  return -1;
}


