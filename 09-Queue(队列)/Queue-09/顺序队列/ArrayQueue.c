//
//  ArrayQueue.c
//  Queue-09
//
//  Created by Yutian Duan on 2018/11/6.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "ArrayQueue.h"


//
static int enqueue (char capacity);
static char dequeue (void);

//! 数组个数
static int n = 10;

//! 声明一个数组指针
static char *arrayP;
// 头 和 尾 标记
static int head = 0;
static int tail = 0;

void arrayQueue (void) {
  
  //! 声明一个数组,让指针指向这个数组
  char items[n];
  arrayP = &items[0];
  
  //! 入队
  int ret = enqueue('a');
  ret = enqueue('b');
  ret = enqueue('c');

  if (ret == 1) {
    printf("入队成功:%s\n",arrayP);
  }
  
  //! 出队
  char retChar = dequeue();
  if (retChar != '\0') {
    printf("出队成功:%c",retChar);
  }
  
  /*
   可以看到满足先进先出
   */
  
}



//！ 入队 返回成功还是失败
static int enqueue (char capacity) {
  //! 队满
  if (tail == n) {
    return -1;
  }
  
  arrayP[tail] = capacity;
  ++tail;
  return 1;
}

//! 出队 返回出队的数据
static char dequeue (void) {
  if (head == tail) {
    return '\0';
  }
  
  char ret = arrayP[head];
  ++head;
  
  return ret;
  
}

/*
 优化处理入队,防止出队入队，导致有空间却无法继续入队
 */

static int newEnqueue (char capacity) {
  if (tail == n) {
    //! 队满
    if (head == 0) { //! 比如一直入队 head 并未改变
      return -1;
    }
    
    //! 否则数据搬移
    for (int i = head; i < tail; ++i) {
      arrayP[i-head] = arrayP[i];
    }
    //! 重置
    tail -= head;
    head = 0;
  }
  
  arrayP[tail] = capacity;
  ++tail;
  return 1;
}

