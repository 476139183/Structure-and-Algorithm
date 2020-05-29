//
//  CycleNodeVC.swift
//  链表
//
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class CycleNodeVC: NSViewController {
    
  
  var head : Node?
    
  override func viewDidLoad() {
     
    super.viewDidLoad()
    
  }
  
  
  @IBAction func crearyNomal(_ sender: Any) {
    
    head =  Node.createFast(10)
    head?.printList()
    
  }
  
  
  @IBAction func creatCycle(_ sender: Any) {
    
    head = Node(data: 1)
    
    var tempNode : Node!
    
    let count = 10
    
    let temp = arc4random()%(UInt32(count-1))+1
      
    for i in 1 ..< count {
      let newNode = Node(data: i+1)
      head?.addNode(newNode)
      if i == temp {
        tempNode = newNode
      } else if i == count-1 {
        newNode.next = tempNode
      }
    }
      
  }
  
  @IBAction func check(_ sender: Any) {
    
    if head == nil {
      return
    }
    
    let reslut : Bool = (head?.cycle())!
    
    let aler = NSAlert.init()
    aler.addButton(withTitle: "确定")
    var str = "有环"
    
    if reslut {
      str = "有环"
    } else {
      str = "无环"
    }
    
    aler.messageText = str

    aler.beginSheetModal(for: self.view.window!, completionHandler: nil)
  }

  
}

fileprivate extension Node {
  
  //！ 判断是否有环
  func cycle() -> Bool {
    var slow :Node? = self
    var fast:Node? = self
    
    while (fast?.next != nil) {
      slow = slow?.next
      fast = fast?.next?.next
      if (slow?.data == fast?.data) {
        return true
      }
    }
    return false
  }
  
}
