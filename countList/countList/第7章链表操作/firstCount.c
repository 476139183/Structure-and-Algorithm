//
//  firstCount.c
//  countList
//
//  Created by Yutian Duan on 2018/10/24.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "firstCount.h"
#include <stdlib.h>


//class Node{
//  int data;  //数据域
//  Node next;  //指针域
//  public Node(int data){
//    this.data = data;
//  }
//}

//MARK: 链表反转
void InitAddresses (void) {
  printf("进入初始化\n");
  //! 定义头结点 指向null, 此时head的地址是0x0;
  Node *head = NULL;
  printf("初始化 %p \n",head); // 打印head存的数据 ，此时存的是 NUll，地址也就是0x0
 //printf("\n %p",&head); // head本身的地址， 0x7ffeebbc1a18
  //！ 在头结点插入一个值,为了修改head 需要传入head的地址。
  insertNodetoHead(&head, 1);
  insertNodetoHead(&head, 2);
  insertNodetoHead(&head, 3);
  insertNodetoHead(&head, 4);
  insertNodetoHead(&head, 5);
  insertNodetoHead(&head, 6);
  insertNodetoHead(&head, 7);

  printLink(head);
  
  //! 进行反转
  reverse(&head);
  printf("\n反转之后\n");
  printLink(head);

}

//MARK: 单链表是否有环
void createRingLink(void) {

  //! 生成一个环链表
  Node *head = NULL;

  insertNodetoHead(&head, 6);
  Node *node6 = head;
  insertNodetoHead(&head, 5);
  insertNodetoHead(&head, 4);
  insertNodetoHead(&head, 3);
  Node *node3= head;
  insertNodetoHead(&head, 2);
  insertNodetoHead(&head, 1);

  node6->next = node3;
//  printLink(head);

  int result = checkCircle(&head);
  
  printf("\n是否是有环链表==%d",result);
}

//MARK: 有序链表合并
void mergeLink(void) {
  
  //！ 申明两个 链表
  Node *head = NULL;
  insertNodetoHead(&head, 9);
  insertNodetoHead(&head, 3);
  insertNodetoHead(&head, 1);

  Node *head2 = NULL;
  insertNodetoHead(&head2, 12);
  insertNodetoHead(&head2, 10);
  insertNodetoHead(&head2, 6);
  insertNodetoHead(&head2, 2);
  

  //! 合并 成为一个新的链表
  Node *newLink = mergeSortedLinkedList(head,head2);
  printLink(newLink);
  
}

//MARK: 删除链表倒数第 n 个结点
void deleteLast() {
  Node *head = NULL;
  insertNodetoHead(&head, 12);
  insertNodetoHead(&head, 10);
  insertNodetoHead(&head, 9);
  insertNodetoHead(&head, 3);
  insertNodetoHead(&head, 1);

  //! 删除倒数第一个结点
  deleteLastKth(&head,6);
  printLink(head);

}

//MARK: 求链表的中间结点
void findMiddleNode(void) {
  Node *head = NULL;
//  insertNodetoHead(&head, 12);
  insertNodetoHead(&head, 10);
  insertNodetoHead(&head, 9);
  insertNodetoHead(&head, 3);
  insertNodetoHead(&head, 1);
  //! 返回奇数的中结点 和偶数的中低结点。
  Node *midNode = findLinkMiddleNode(&head);
  //! 如果是偶数，再返回midNode->next->data 就是偶数的中高结点了
  printf("\n中间结点==%d",midNode->data);
  
}


//MARK: 其他方法

//! 反转单链表->传入 头结点
void reverse(Node * *head) {
  
  printf("\n新结点2\n %p",*head); // 此时打印的也是 0x604000019df0
  //! 如果是空
  if (*head == NULL) {
    return;
  }
  //! 如果是一个结点
  if ((*head)->next == NULL) {
    return;
  }
  
  //! 我们声明一个临时结点
  Node *newHeadNode = NULL;
  //! 当前结点 -> 最终也是新链表的 头部结点
  Node *currentNode = *head;
  
  while (currentNode != NULL) {
    //! 获取当前下一个结点
    Node *nestNode = currentNode->next;
    //！当前结点指向tempNode
    currentNode->next = newHeadNode;
    //! 最新头部结点
    newHeadNode = currentNode;
    //! 循环走
    currentNode = nestNode;
  }

  *head = newHeadNode;
  
}

//! 1 是有环链表， 0 是非环链表
int checkCircle(Node** head) {
  
  if (*head == NULL) {
    return 0;
  }
  
  //! 申明快慢指针
  Node *slow = *head, *fast = *head;
  //! 如果快指针 到了终点，依然没有匹配那就是 单链表
  while (fast!= NULL && fast->next != NULL) {
    //! 快指针走两步，慢指针走一步
    fast = fast->next->next;
    slow = slow->next;
    if (slow == fast) {
      return 1;
    }
  }

  return 0;
  
}

Node * mergeSortedLinkedList (Node *la,Node *lb) {
  
  //! 申明一个空结点用来做循环时，链表尾部 和一个结点用来拿到新链表的头部
  Node *temp = malloc(sizeof(Node));
  //! 将尾部指向头结点
  Node *tail = temp;
  
  //! 一直循环 直到一个链表结束,
  while (1) {
  
    // 直到链表结束
    if (la == NULL) {
      tail->next = lb;
      break;
    } else if (lb == NULL) {
      tail->next = la;
      break;
    }
    
    if (la->data <= lb->data) {
      //! a结点比b结点小，将a传进去
      modeNode(&tail,&la);
    } else {
      modeNode(&tail,&lb);
    }
    
  }
  //! 去掉我们自己创建的头结点
  return temp->next;
}

//! 揉合结点,将 srcNode 的头 拼接到 目标结点
void modeNode(Node **targetNode, Node **srcNode) {
  //! 保留src的下一个结点
  Node *next = (*srcNode)->next;
  //! 将
  (*targetNode)->next = *srcNode;
  *targetNode = *srcNode;
  *srcNode = next;
  
}


/** 删除倒数第 K 个结点 */

void deleteLastKth(Node** head_ref, int k) {
  
  if (*head_ref == NULL || k == 0) {
    return;
  }
  
  // 设置一个快慢指针
  Node *slow = *head_ref;
  Node *fast = *head_ref;
  Node *scr = *head_ref;

  //! 计数器
  int i = 1;

  //! 因为我设置的结点，最后一个尾结点是NUll，所以我们需要剔除null
  while (scr->next != NULL) {
    if (i >= k + 1) {
      slow = slow->next;
    }
    if (i >= k ) {
      fast = fast->next;
    }
    //! 遍历指针
    scr = scr->next;
    i++;
  }
  
  
  //! 次数不够 说明结点小于k
  if ( i < k) {
    return;
  }
  
  //! 说明要删除的正好是头结点
  if (slow == fast && i < k+1) {
    //
    *head_ref = (*head_ref)->next;
  }
  
  //! 这个时候已经找到要删除的结点 fast 和 fast的前一个结点 slow
  slow->next = fast->next;
  

}


//!
Node * findLinkMiddleNode(Node **head) {
  
  //! 申明快慢指针
  Node *slow = *head;
  Node *fast = *head;
  
  while (fast->next != NULL && fast->next->next != NULL) {
    slow = slow->next;
    fast = fast->next->next;
  }
  
  return slow;
  
}

