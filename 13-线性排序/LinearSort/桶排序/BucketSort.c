//
//  BucketSort.c
//  LinearSort
//
//  Created by 段雨田 on 2019/11/12.
//  Copyright © 2019 段雨田. All rights reserved.
//

#include "BucketSort.h"
//! 初始化库
#include <stdlib.h>
//! 复制库
#include <string.h>

///！ 定义一个桶
struct barrel {
  int node[10];
  int count;/* the num of node */
};

////! 进行桶排序,传入数组 和数组的
void bucket_sort(int data[], int size);
////！ 快排
void quick_sort(int a[],int left,int right);

void setBucket(void) {
  
  int arr[] = {5, 8, 9, 23, 67, 1, 3, 7, 31, 56};
  
  //! 计算数组arr 的个数n
  int n = sizeof(arr)/sizeof(int);
  
  bucket_sort(arr,n);

  for (int i = 0; i < n; i++) {
    printf("%d,",arr[i]);
  }
  
}

void bucket_sort(int data[], int size) {
  
  int max, min, num, pos;
  int i, j, k;
  struct barrel *pBarrel;
  
  max = min = data[0];
  ///! 计算出数组中的最大值 67和最小值1，
  for (i = 1; i < size; i++) {
    if (data[i] > max) {
      max = data[i];
    } else if (data[i] < min) {
      min = data[i];
    }
  }
  ///！ 得到桶的个数，每一个桶的取值区间 范围在10以内
  num = (max - min + 1) / 10 + 1;
  ///！ 根据桶的数量，建立一个桶数组 pBarrel
  pBarrel = (struct barrel*)malloc(sizeof(struct barrel) * num);
  ///！ 使用memset函数，对数组进行初始化操作，
  memset(pBarrel, 0, sizeof(struct barrel) * num);
  
  /* 循环原数组，将数据放入它所属的桶内*/
  for (i = 0; i < size; i++) {
    // 通过值计算出所在桶的索引
    k = (data[i] - min + 1) / 10;
    //! 通过索引进行指针偏移，找到桶，并且放入桶内的数组中
    (pBarrel + k)->node[(pBarrel + k)->count] = data[i];
    (pBarrel + k)->count++;
  }
  ///！ 用来记录当前已读数据的下标，也就是已排序好的下标
  pos = 0;
  ///!  依次遍历桶，进行排序
  for (i = 0; i < num; i++) {
    if ((pBarrel + i)->count != 0) {
      ///！对桶内数组进行快排
      quick_sort((pBarrel+i)->node, 0, ((pBarrel+i)->count)-1);
      ///! 遍历排序好的桶，将桶内数据取出放入原数组中
      for (j = 0; j < (pBarrel+i)->count; j++) {
        data[pos++] = (pBarrel+i)->node[j];
      }
    }
  }
  
  free(pBarrel);
  
}

#pragma mark - 快排
///！ 分区
int partition(int a[],int left,int right);

void quick_sort(int a[],int left,int right) {
  int q = 0;
  /*递归终止条件*/
  if (left >= right) {
    return;
  }
  
  q = partition(a,left,right);
  quick_sort(a,left,(q - 1));
  quick_sort(a,(q + 1),right);
  return;
}

///！分区，和之前的快排分区 换了一种写法
int partition(int a[],int left,int right) {
  int i = left;
  int j = right;
  int key = a[left];
  
  while(i < j) {
    while((i < j) && (a[j] >= key)) {
      j--;
    }
    if (i < j) {
      a[i] = a[j];
    }
    while((i < j) && a[i] <= key) {
      i++;
    }
    
    if (i<j) {
      a[j] = a[i];
    }
  }
  
  a[i] = key;
  
  return i;
}
