//
//  ReverseListVC.swift
//  链表
//  反转链表
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class ReverseListVC: NSViewController {
  
  var head : Node?
   
  override func viewDidLoad() {
     
    super.viewDidLoad()
      
    let newNode = head?.reverseList()
    newNode?.printList()
  }
  
}

fileprivate extension Node {
  
   //! 链表反转
   func reverseList() -> Node! {
     
     print("\n反转")
     //!
     var head:Node?
     //!
     var cur:Node? = self
     
     while (cur != nil) {
       //! 优化点，不需要重复创建临时变量，所以可以放外面去
       let next = cur?.next
       cur?.next = head
       head = cur;
       cur = next
     }
     return head
   }
  
  
}
