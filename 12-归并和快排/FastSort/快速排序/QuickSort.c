//
//  QuickSort.c
//  FastSort
//
//  Created by Yutian Duan on 2018/12/12.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "QuickSort.h"

//! 快速排序
void quickSort (int arr[],int n);
//! 递归函数
void quick_sort (int arr[],int p, int r);

//! 分区函数
int partition (int arr[], int p, int r);
//! 交换函数
void swap(int *a, int *b);

void setQuick(void) {
  
  int test[10] = {5, 8, 9, 23, 67, 1, 3, 7, 31, 56};
  
  quickSort(test, 10);

  for (int i = 0; i < 10; i ++) {
    printf("%d,",test[i]);
  }
  
}


//！
void quickSort (int arr[],int n) {
  
  quick_sort(arr, 0, n-1);
  
}


//!
void quick_sort (int arr[],int p, int r) {
  
  if (p >= r) {
    return;
  }
  
  int q;
  ///////
  q = partition(arr, p, r);
  quick_sort(arr, p,q-1);
  quick_sort(arr, q+1, r);
  
}


//
int partition (int arr[], int p, int r) {
  
  int i,j;
  i = j = p;
  
  for (; j < r; j++) {
    
    if (arr[j] < arr[r]) {
      if (i != j) {
        swap(arr+i, arr+j);
      }
      i++;
    }
  }
  
  swap(arr + i, arr + r);
  return i;
  
}

//！ 交换函数
void swap(int *a, int *b) {
  int tmp = *a;
  *a = *b;
  *b = tmp;
}


/* 快速排序
 * 因为分区涉及交换，所以是不稳定排序
 *
 * 时间复杂度 O(nlogn) 最坏时间复杂度退化到 O(n^2)  最好时间复杂度 O(n);
 * 空间复杂度 O (1) 原地排序
 *
 * 时间复杂度为 O(K * n)
 K为执行次数，当K很小时， 即为最好时间复杂度，当K接近与n时，即为最坏时间复杂度
 */
