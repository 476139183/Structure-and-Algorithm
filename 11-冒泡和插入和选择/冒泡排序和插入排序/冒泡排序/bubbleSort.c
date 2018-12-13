//
//  bubbleSort.c
//  冒泡排序和插入排序
//
//  Created by Yutian Duan on 2018/12/11.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "bubbleSort.h"

#include <stdbool.h>

/*
 冒泡排序只会操作相邻的两个数据。每次冒泡操作都会对相邻的两个元素进行比较，看是否满足大小关系要求。如果不满足就让它俩互换。一次冒泡会让至少一个元素移动到它应该在的位置，重复 n 次，就完成了 n 个数据的排序工作。
 
 */

void bubbleSort (int arr[], int n);


void setupBubble (void) {
  
  int n = 6;
  int arr[] = {3,5,4,1,2,6};
  
  bubbleSort(&arr,n);
  
  for (int i = 0; i < n; ++i) {
    printf("%d,",arr[i]);
  }
  
  
  
  
  
}

/* 冒泡 把最大的浮到最上面
 循环n遍，
 把最大的放在最后面。
 循环n-1遍，把最大的放最后面
 直到循环剩余的不再交换位置

 */

void bubbleSort (int arr[], int n) {
  
  if (n <= 1) {
    return;
  }
  
  for (int i = 0; i < n; ++i) {
    //! 提前退出冒泡循环的标志，判断有无数据交换
    bool flag = false;
    for (int j = 0; j < n-i-1; ++j) {
      if (arr[j] > arr[j+1]) {
        int temp = arr[j];
        arr[j] = arr[j+1];
        arr[j+1] = temp;
        flag = true;
      }
    }
    
    //! 遍历之后 无数据交换，提前退出
    if (!flag) {
      break;
    }
  }
  
}



/*
 空间复杂度: O(1) 是     原地排序算法
 只有大于才交换，所以是    稳定的排序算法

 最好时间复杂度 为 O(n)
 最坏时间复杂度 为 O(n^2)
 平均时间复杂度 为 O(n^2)   利用有序度分析

 */


