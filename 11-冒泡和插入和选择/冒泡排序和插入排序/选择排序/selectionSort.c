//
//  selectionSort.c
//  冒泡排序和插入排序
//
//  Created by Yutian Duan on 2018/12/11.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "selectionSort.h"

void selecttionSort (int ar[], int n);

void setupSelection (void) {
  
  
  int n = 6;
  int arr[] = {3,5,4,1,2,6};
  
  selecttionSort(&arr,n);
  
  for (int i = 0; i < n; ++i) {
    printf("%d,",arr[i]);
  }

  
}


/*
 每一次 从剩余数组选出最小值 放到已经排序的区间末尾，也就是进行交换
 */
void selecttionSort (int arr[], int n) {
  
  if (n == 1) {
    return;
  }
  
  //! 已排序区间角标
  int point = 0;
  //！ 定位最小值 角标
  int k = point;
  
  /*
   *  最后一次不需要遍历。因为只剩下一个元素了，肯定是最大的
   */
  for (int i = 0; i < n-1; ++i) {
    //！ 未排序最小值，默认取已排序的最后一个元素
    int temp = arr[point];
    int k = point;
    for (int j = point; j < n; ++j) {
      if (temp > arr[j]) {
        temp = arr[j];
        k = j;
      }
    }

    //! 交换
    arr[k] = arr[point];
    arr[point] = temp;
    //! 区间+1
    ++point;
    
  }
  
}

/*
 *  选择排序
 *
 *  空间复杂度 O(1) 是 原地排序算法
 *  因为会进行交换位置， 所以是不稳定算法
 *
 *  最好最坏平均时间复杂度 都是 O(n^2)
 *  每一次都需要遍历 选出最小值 交换到末尾 也就是n*n
 *
 *
 */
