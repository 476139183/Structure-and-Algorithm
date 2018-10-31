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


//！ 为链表头部插入数据,传入头结点 和新结点的值，（我传入了head的地址，那么打印head 就是0x7ffeebbc1a18， 打印*head 就是0x0， 所以*head 才是 Node 结构体 ,下面完整写法应该是  void insertNodetoHead(Node * (*head), int data ）;
void insertNodetoHead(Node **head, int data) {
  
  //! 申明一个新结点
  Node *newNode = malloc(sizeof(Node));
  //! 新结点赋数据
  newNode->data = data;
  //! 新结点指向目标结点的地址
  newNode->next = *head;
  printf("指向%p \n",newNode->next);
  //! 将头结点指向新插入的结点
  *head = newNode; // 最后一次是 0x604000019df0
  printf("新结点1 %p \n",*head);
}
