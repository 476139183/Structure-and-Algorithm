//
//  MergeSort.c
//  Algorithm-12
//
//  Created by Yutian Duan on 2018/11/6.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "MergeSort.h"

int *temp[];

void mergeSort(void) {
  
  //! 申明 数组
  int array = {1,2,3,45,6,76,7,8,9,0,12,34};
  
  temp = &array;
  
  for (int i = 0; i < 12; i++) {
    printf("temp==%d",temp[i]);
  }
  
}
