//
//  Queue.c
//  Queue-09
//
//  Created by Yutian Duan on 2018/11/6.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

/*
 如果用链表 是很好组成循环队列的 这里采用数组形式,并假装他们形成一个头尾相连
 在文章讲述循环队列的时候，我的理解是
 
 
 
 */

#include "Queue.h"

static int enqueue (char capacity);
static char dequeue (void);

//! 数组个数
static int n = 10;

//! 声明一个数组指针
static char *arrayP;
// 头 和 尾 标记
static int head = 0;
static int tail = 0;


void rinkQueue (void) {
  
  //! 声明一个数组,让指针指向这个数组
  char items[n];
  arrayP = &items[0];

  
  
}

//! 入队
static int enqueue (char capacity) {
  //! 队满
  if ((tail+1)%n == head) {
    return -1;
  }
  
  arrayP[tail] = capacity;
  tail = (tail + 1) % n;
  
  return 1;
  
}


/*
 出队
 
 */
static char dequeue (void) {
  if (head == tail) {
    //! 队空
    return '\0';
  }
  
  char ret = arrayP[head];
  head = (head +1)%n;
  return ret;
}
