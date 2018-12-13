//
//  MergeSort.c
//  FastSort
//
//  Created by Yutian Duan on 2018/12/12.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

/*
 T(n) = 2*T(n/2) + n
 = 2*(2*T(n/4) + n/2) + n = 4*T(n/4) + 2*n
 = 4*(2*T(n/8) + n/4) + 2*n = 8*T(n/8) + 3*n
 = 8*(2*T(n/16) + n/8) + 3*n = 16*T(n/16) + 4*n
 ......
 = 2^k * T(n/2^k) + k * n
 ......

 
 */

#include "MergeSort.h"

//! 初始化库
#include <stdlib.h>
//! 复制库
#include <string.h>


//! 调用归并算法
void mergeSort (int arr[], int n);
//! 递归函数
void merge_sort_c (int arr[], int p, int r);
//! 合并函数
void merge_arr (int arr[], int p, int q, int r);

void setMerge(void) {
  
  int arr[] = {5, 8, 9, 23, 67, 1, 3, 7, 31, 56};
  
  mergeSort(arr, 10);
  
  for (int i = 0; i < 10; ++i) {
    printf("%d,",arr[i]);
  }
  
  
}




void mergeSort (int arr[], int n) {
  
  merge_sort_c(arr, 0, n-1);
  
}



//递归调用函数
void merge_sort_c (int arr[], int p, int r) {
  //! 递归终止条件
  if (p >= r) {
    return;
  }
  
  //! 取p到r之间的中间位置q
  int q;
  q = (p+r)/2;
  
  merge_sort_c(arr,p,q);
  merge_sort_c(arr, q+1, r);
  //! 合并
  merge_arr(arr,p,q,r);
}

void merge_arr (int arr[], int p, int q, int r) {
  int *temp;
  
  int i , j , k ;
  
  //! 创建一个连续的空间 作为临时数组
  temp = (int *)malloc((r-p+1) * sizeof(int));
  
  if (!temp) {
    abort();
  }
  
  for (i = p,j = q+1,k=0; i<=q && j<= r;) {
    if (arr[i] <= arr[j]) {
      temp[k++] = arr[i++];
    } else {
      temp[k++] = arr[j++];
    }
    
  }
  
  //!
  if (i == q+1) {
    for (; j <= r;) {
      temp[k++] = arr[j++];
    }
    
  } else {
    for (; i <= q; ) {
      temp[k++] = arr[i++];
    }
  }
  
  //! 拷贝回原来的数组
  memcpy(arr+p,temp,(r-p+1) * sizeof(int));
  free(temp);
  
}

/* 归并排序
 * 合并 同等大小数字顺序不变，所以是稳定的排序算法
 *
 * 时间复杂度  O(nlogn)
 * 空间复杂度  O(n)  同一时间只会开辟一个空间，最大为N
 *
 *
 */
