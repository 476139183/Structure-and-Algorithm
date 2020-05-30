//
//  Node.swift
//  链表
//
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class Node: NSObject {
  
  var next:Node?
  var data:Int = 0
  
  init(data:Int) {
    self.data = data
    super.init()
  }
  
  //! 添加节点到末尾
  func addNode(_ node:Node) {
    
    var temp = self
    
    while (temp.next != nil) {
      temp = temp.next!
    }
    
    temp.next = node
  }
  
  //! 尾插法
  class func createFast(_ count:Int) -> Node {
    
    let head = Node(data: 1)
    
    if count == 0 || count == 1 {
      return head
    }
    
    var temp:Node = head
    
    for i in 1 ..< count {
      let node = Node(data: i+1)
      temp.next = node
      temp = node
    }
    
    return head
  }
  
  
  //! 打印链表
   func printList() {
     
     var temp:Node? = self
     
     while (temp != nil) {
       let p = temp!
       print(p.data)
       temp = p.next
     }
     
   }
  
  
  //! copyList
  func copyList() -> Node {
    
    var head : Node!
    var current: Node!

    var pre:Node? = self
    
    while (pre != nil) {
    
      let node = Node(data: pre!.data)
      
      if (head == nil) {
        head = node
      }
      
      if current == nil {
        current = node
      } else {
        current?.next = node
        current = node
      }
            
      pre = pre?.next
    }
    
    return head
  }
  
 
  
  
}
