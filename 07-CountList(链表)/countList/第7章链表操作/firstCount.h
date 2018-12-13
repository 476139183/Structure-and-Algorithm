//
//  firstCount.h
//  countList
//
//  Created by Yutian Duan on 2018/10/24.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#ifndef firstCount_h
#define firstCount_h

#include <stdio.h>
#include "tool.h"

/**
 * 1) 单链表反转
 * 2) 链表中环的检测
 * 3) 两个有序的链表合并
 * 4) 删除链表倒数第 n 个结点
 * 5) 求链表的中间结点
 *
 */


//! 初始化一个单链表
void InitAddresses(void);
//! 反转，传递一个Node 的指针
void reverse(Node * *head);

//! createRingLink
void createRingLink(void);
//! 检测是否是环
int checkCircle(Node** head);

//! 两个有序的链表合并
void mergeLink(void);
Node * mergeSortedLinkedList (Node *la,Node *lb);
void modeNode(Node **targetNode, Node **srcNode);

//！ 删除链表倒数第 n 个结点
void deleteLast(void);
void deleteLastKth(Node** head_ref, int k);

//! 求链表的中间结点
void findMiddleNode(void);
Node * findLinkMiddleNode(Node **head);

#endif /* firstCount_h */
