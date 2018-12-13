//
//  StackTest.c
//  countList
//
//  Created by Yutian Duan on 2018/11/2.
//  Copyright © 2018年 Wanwin. All rights reserved.
//

#include "StackTest.h"



int count = 0;

void arrayStack (void) {
  int n = 100;
  //! 申明一个字符数组(等同与一个字符串，这是c的基本知识)
  char array[n];
  array[0] = 'a';
  array[1] = 'b';
  
  printf("字符串===%s\n",array);
  
  bool result = push('a',array,(int)(sizeof(array)/sizeof(char)));
  //! 是否入栈
  printf("是否入栈%d\n",result);
  
  for (int i = 0; i < 4; i++) {
    printf("入栈后====%c\n",array[i]);
  }
  
  //! 入栈
  
  
}


/*入栈
  数组当作函数参数传递时，传递的是指针变量，在64位里，固定了大小为8个字节。和在为外算的大小不一样
 
 */
bool push (char item,char array[], int length) {
  
  if (count == length) {
    return false;
  }

  array[count] = item;
  count++;
  return true;
}

/*
 出栈
*/

char pop(char array[]) {
  if (count == 0) {
    return '\0';
  }
  
  char temp = array[count-1];
  --count;
  return temp;
  
}
