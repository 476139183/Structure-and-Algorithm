//
//  InsertionSort.c
//  冒泡排序和插入排序
//
//  Created by Yutian Duan on 2018/12/11.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "InsertionSort.h"

/*
 
 */
void insertionSort (int arr[], int n) ;


void setupInsert (void) {
  
  
  int n = 6;
  int arr[] = {3,5,4,1,2,6};
  
  insertionSort(&arr,n);
  
  for (int i = 0; i < n; ++i) {
    printf("%d,",arr[i]);
  }
  

  
}



/*
 
 遍历数组，并让 其 与 前面的进行比较大小
 并进行后移动 实现插入
 
 */
void insertionSort (int arr[], int n) {
  
  if (n <= 1) {
    return;
  }
  
  //! 从第二个元素开始比较 插入
  for (int i = 1; i < n; ++i) {
    //! 当前遍历 需要比较的数字 value
    int value = arr[i];
    int j = i - 1;
    //! 遍历value前面的数组，j不停变小
    for (; j >= 0; --j) {
      if (arr[j] > value) { //! 如果找到比value大的数字，数据向后移动，
        arr[j+1] = arr[j];
      } else { //! 没有找到比当前值小的，不需要移动
        break;
      }
    }
    
    //！ 最后定位到 value的位置
    arr[j+1] = value;
    
  }
  

}


/*  空间复杂度： O(1)  是原地排序算法
 *  只有大于才进行搬移  所以是稳定的排序算法
 *
 *  最好时间复杂度 O(n)
 *  最坏时间复杂度 O(n^2)
 *  平均时间复杂度 O(n^2):  插入数据 平均时间复杂度为O(n),
 *
 对于插入排序来说，每次插入操作都相当于在数组中插入一个数据，循环执行 n 次插入操作，
 所以插入排序时间复杂度为O(n^2)
 */
