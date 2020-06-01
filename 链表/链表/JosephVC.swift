//
//  JosephVC.swift
//  链表
//  约瑟夫问题
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class JosephVC: NSViewController {

    override func viewDidLoad() {
      
      super.viewDidLoad()
    
      josephus()
      
    }
  
  
  @IBAction func again(_ sender: Any) {
    josephus()
  }
  
  @IBAction func more(_ sender: Any) {
    
    let svc:JosephTwoVC = (storyboard?.instantiateController(identifier: "josephTwoVC"))! as JosephTwoVC
    self.presentAsModalWindow(svc);
    
  }
  
}


fileprivate extension JosephVC {
  
  
  //!
  
  func josephus() {
    
    print("约瑟夫问题")
    //! 创建N个的循环链表
    let n = 41
    var m = 3
    var p = creatCycle(n)
      
    var temp:Node?
    // 取余数,其实就是=3
    m %= n
      
    while p != p?.next {
      for _ in 1..<m-1 {
        p = p?.next!
      }
        
      //! 杀死的顺序
      print("->\(String(describing: p!.next!.data))")
      temp = p?.next
      p?.next = temp?.next
      p = p?.next
    }
      
    print("last:\(String(describing: p!.data))")
    
  }
  
  //! 创建 环链表
  func creatCycle(_ n : Int) -> Node? {
    
    var i = 1
      //! 循环之后，让尾节点指向它
    let head = Node(data: 1)
    
      //! 指向当前节点
      var p = head
      //! 保存临时创建节点
      var s:Node?
      
      if n != 0 {
        
        while i <= n {
          s = Node(data: i+1)
          p.next = s
          p = s!
          i = i+1
        }
        s?.next = head.next
      }
      return head
  }
  
}
