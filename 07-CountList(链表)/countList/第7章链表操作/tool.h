//
//  tool.h
//  countList
//
//  Created by Yutian Duan on 2018/10/29.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#ifndef tool_h
#define tool_h

#include <stdio.h>

//! 定义一个简单的结点，别名为Node
typedef struct Node {
  int data;  //数据域
  struct Node *next;  //指针域
}Node;

//! 打印结点
void printLink (Node *node);
//! 插入结点,传入指向结点的二级指针
void insertNodetoHead(Node **head, int data);
//! 初始化一个结点指针,并赋值data
Node *initNode(int data);


#endif /* tool_h */
