//
//  RadixSort.c
//  LinearSort
//
//  Created by 段雨田 on 2019/11/12.
//  Copyright © 2019 段雨田. All rights reserved.
//

#include "RadixSort.h"

#include <stdlib.h>
#include<string.h>
#include <assert.h>

#include <math.h>

///! 基数排序
void radix_sort(int arr[], int n,int num_count);

void setRadix(void) {
  
  int arr[10] = {123,12341,1232134,124,236,128,1112313129,98,9,8989};

  radix_sort(arr, 10, 10);
  
  for (int i = 0; i < 10; i++) {
    printf("%d,",arr[i]);
  }
  
}


#define NUM_OF_POS(a,pval) ((a)/pval)%10

void radix_sort(int arr[], int n,int num_count) {
  
  /*计数*/
  int count[10] = {0};

  int *pres = NULL;
  int i = 0;
  int j = 0;
  int pval = 10;
  int index = 0;
  int break_flg = 0;
  
  pres = (int *)malloc(sizeof(int)*n);
  assert(pres != NULL);
  
  for (i = 0; i < num_count; i ++) {
    memset(count,0,sizeof(int)*10);
    
    /* 使用pow函数获取 10的i次方  作为当前的基数 */
    pval = pow(10,i);
    
    /*计数*/
    for (j = 0; j < n; j++) {
      index = NUM_OF_POS(arr[j],pval);
      count[index]++;
    }
    
    /* 小的优化，可能位数最大的就1，其他的位数差很多*/
    if(count[0] == 9) {
      break_flg++;
    }
    
    if(break_flg >= 2) {
      printf("\r\n %i\n",i);
      break;
    }
    
    /*累加*/
    for(j = 1; j < 10; j ++) {
      count[j] += count[j-1];
    }
    
    /*排序必须从后往前，否则不是稳定排序*/
    for(j = n -1; j >= 0; j--) {
      index = NUM_OF_POS(arr[j],pval);
      pres[count[index] - 1] = arr[j];
      count[index]--;
    }
    /*本轮排序好的，拷贝到a中*/
    memcpy(arr,pres,sizeof(int)*n);
  }
  
  return;
  
}
