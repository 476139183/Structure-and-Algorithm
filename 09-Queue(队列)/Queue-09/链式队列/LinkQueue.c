//
//  LinkQueue.c
//  Queue-09
//
//  Created by Yutian Duan on 2018/11/6.
//  Copyright © 2018年 Wanwin. All rights reserved.
//


#include "LinkQueue.h"
#include "tool.h"


//! 头指针
Node *head;
//！ 尾指针
Node *tail;

static int enqueue (Node **point);
static Node * dequeue (void);

void linkQueue (void) {
  
  //!  初始化
  head = NULL;
  tail = NULL;
  
  for (int i = 1; i < 5; ++i) {
    //! 将指针地址传入,入队操作
    Node *newNode = initNode(i);
    enqueue(&newNode);
  }
  printLink(head);
  
  //! 出队
  Node *outNode = dequeue();
  printLink(outNode);
  
}

//! 入队
static int enqueue (Node **point) {

  if (tail == NULL) {
    //! 初次入队
    head = *point;
    tail = *point;
    return 1;
  }
  
  //! 新节点插入到尾部
  tail->next = *point;
  
  tail = *point;
  
  return 1;
}


//! 出队
static Node * dequeue (void) {
  
  if (head == NULL) {
    return NULL;
  }
  
  //!
  Node *oldPoint = head;
  oldPoint->next = NULL;
  
  head = (*head).next;
  
  return oldPoint;
  
}



