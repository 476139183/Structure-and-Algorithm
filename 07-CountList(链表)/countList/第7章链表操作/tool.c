//
//  tool.c
//  countList
//
//  Created by Yutian Duan on 2018/10/29.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "tool.h"
#include <stdlib.h>


//！ 打印 链表
void printLink (Node *node) {
  printf("start----\n");
  
  while (node != NULL) {
    printf("data==%d\n",node->data);
    node = node->next;
  }
  printf("end---\n");
}


//！ 为链表头部插入数据,传入头结点 和新结点的值，（为了能修改指针head的指向，将指针head的地址传入，地址为0x7ffeebbc1a18，那么*head指向的就是指针指向的结构体   我传入了指针head的地址，那么打印head 就是0x7ffeebbc1a18， 打印 *head 就是指针变量指向的 0x0， 所以 取址 *head 才是 Node 结构体 ;
void insertNodetoHead(Node **head, int data) {
  
  //! 动态分配内存
  Node *newNode = malloc(sizeof(Node));
  //! 新结点赋数据 也可以写成这样 (*newNode).data = data
  newNode->data = data;
  
  //! 新结点指向目标结点的地址
  newNode->next = *head;
  printf("指向%p \n",newNode->next);
  //! 将头结点指向新插入的结点指针
  *head = newNode; // 最后一次是 0x604000019df0
  printf("新结点1 %p \n",*head);
}

//! 初始化一个结点指针,并赋值data
Node *initNode(int data) {
  Node *pointOne = malloc(sizeof(Node));
  pointOne->data = data;
  return pointOne;
}
