//
//  SwapNodeVC.swift
//  链表
//
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class SwapNodeVC: NSViewController {

  var head : Node?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let newNode = head?.swapNodeInPairs2()
    newNode?.printList()
    
  }
    
}

fileprivate extension Node {
  
  //! 反转两个相邻的节点,比如 12345 -> 21435
   func swapNodeInPairs() ->Node! {
     print("\n二次反转")

     //！ 如果只有一个节点，当然是不做操作了
     if self.next == nil {
       return self
     }
     
     let head = self.next
     
     //!
     var cur:Node? = self
     //! 还要记录头节点
     var tempHead:Node?
     
     while (cur?.next != nil) && (cur?.next?.next != nil) {
       
       let a = cur?.next
       let next = a?.next
       
       a?.next = cur
       cur?.next = next
       cur = next
       if (tempHead != nil) {
         tempHead?.next = a
       }
       tempHead = a?.next
     }
     
     return head
   }
     
   
   //! 反转两个相邻的节点,比如 12345 -> 21435
   func swapNodeInPairs2() ->Node! {
     print("\n二次反转")

     //！ 如果只有一个节点，当然是不做操作了
     if self.next == nil {
       return self
     }
     
     let head = self.next
     
     //! 随便创建一个 当作头部节点
     var cur:Node? = Node.init(data: 0)
     cur?.next = self
     
     //！哨兵原理，将问题 统一变成处理当前节点，后面的两个节点交换位置
     while (cur?.next != nil) && (cur?.next?.next != nil) {
       let a = cur?.next
       let b = a?.next
       //! 交换
       a?.next = b?.next
       b?.next = a;
       cur?.next = b
       cur = a
     }
     return head
   }
  
  
  
}
