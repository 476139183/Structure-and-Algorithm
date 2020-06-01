//
//  MagicianVC.swift
//  链表
//
//  Created by 段雨田 on 2020/6/1.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class MagicianVC: NSViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      
      print("魔术师发牌问题:")
      
      let n = 13
      
      //1 创建一个单循环链表
      var head = creatCycle(n)
      
      //2 根据魔术师的操作，对牌进行赋值
      magician(head: head)

      for _ in 0 ..< n {
        print("♥️\(head.data)")
        head = (head.next)!
      }
      
    }
    
}


fileprivate extension MagicianVC {
  
  //! 创建循环链表，初始化数字为 0
  func creatCycle(_ n : Int) -> Node {
      
    var head:Node?
    var s:Node!,r:Node?
       
    for _ in 1 ... n {
      s = Node(data: 0)
         
      if head == nil {
        head = s
      } else {
        r?.next = s
      }
      r = s
    }
      
    r?.next = head
    return head!
  }
  
  //! 发牌顺序计算
  func magician(head:Node) {
    
    var p:Node
    //!  每次牌需要存放的数字
    var countnumber = 2
    
    var j = 0
    
    //! 第一张牌肯定是1
    p = head
    p.data = 1
    
    while true {
      j = 0
      
      while j < countnumber {
        p = p.next!
        if p.data != 0 {
          //！ 如果这个位置有牌了，那么就到下一个位置，相当于这个牌已经被我们翻出了，所以忽略这张牌,也就是角标不变
        } else {
          j += 1
        }
      }
      
      if p.data == 0 {
        p.data = countnumber
        countnumber = countnumber+1
        //! 总共只有13张牌，所以数到14就退出
        if countnumber == 14 {
          break
        }
      }
      
    }
    
    
  }
  
  
}
