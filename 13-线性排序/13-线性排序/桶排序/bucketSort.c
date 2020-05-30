//
//  bucketSort.c
//  13-线性排序
//
//  Created by Yutian Duan on 2018/12/13.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "bucketSort.h"

//! 为了 使用 free 函数
#include <stdlib.h>




//! 初级桶排序
static void juniorBucket_Sort (void);


void setBucket (void) {
  
  //!
  juniorBucket_Sort();
  
  
}

/*  进行简单理解的桶排序
 只是进行了数字的排序，获取排序的区间 然后进行分配空间
 */
static void juniorBucket_Sort (void) {
  
  //! 假设我们需要排序的数组范围在 [0,10];
  int source[] = {5,3,5,8,2,9};

  //! 声明一个 桶 并初始化
  int a[10], i;
  for (i = 0; i <= 10; i ++) {
    a[i] = 0;
  }
  
  //! 进行桶排序  单从排序的角度看，时间复杂度为O(n), 空间复杂度为O(n)
  for (i = 0; i <= 5; i ++) {
    int k = source[i];
    a[k]++;
  }
  
  //! 打印排序的数据
  for ( i = 0; i < 10; i ++) {
    for (int j = 1; j <= a[i]; j++) {
      printf("%d,",i);
    }
  }
  
  free(source);
  
}


const int BUCKET_NUM = 10;

//! 桶
struct ListNode {
  
  //! 桶里面的数组
  int mData;
  //! 下一个桶
  struct ListNode *next;
};


/* 桶排序只是将数组进行分区，我们还可以采用 少的桶，排序多的数。
 * 比如先进行桶排序，再对桶的数字 进行插入排序或者快速排序。
 *
 */

 static void seniorBucket_Sort(void) {
  
  //!
  int source[] = {30,34,56,52,88,89,21,22,99,96};
  
  //! 创建几个桶
  

  
  
}

