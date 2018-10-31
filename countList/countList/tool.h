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

//! 定义一个简单的结点，
typedef struct Node {
  int data;  //数据域
  struct Node *next;  //指针域
}Node;

//! 打印结点
void printLink (Node *node);
//! 插入结点
void insertNodetoHead(Node **head, int data);



#endif /* tool_h */
