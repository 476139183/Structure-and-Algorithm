//
//  SingleNodeVC.swift
//  链表
//
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class SingleNodeVC: NSViewController,SingleCreateDelegate {

  var currentHead:Node?

  override func viewDidLoad() {
      super.viewDidLoad()
    
   
  }
  
  
    
  @IBAction func createNode(_ sender: Any) {
    
    let svc:SingleCreateVC = (storyboard?.instantiateController(identifier: "create"))! as SingleCreateVC
    svc.delegate = self
    self.presentAsModalWindow(svc);
  }
  
  @IBAction func printList(_ sender: Any) {
    
    currentHead?.printList()
  }
  
  @IBAction func reverseList(_ sender: Any) {
    let svc:ReverseListVC = (storyboard?.instantiateController(identifier: "reverseListVC"))! as ReverseListVC
    let head = currentHead?.copyList()
    svc.head = head
    self.presentAsModalWindow(svc);
  }
  
 
  @IBAction func reverseTwoList(_ sender: Any) {
    
 
    let svc:SwapNodeVC = (storyboard?.instantiateController(identifier: "swapNodeVC"))! as SwapNodeVC
    let head = currentHead?.copyList()
    svc.head = head
    self.presentAsModalWindow(svc);
    
  }
  
  func getCreateHeadNode(head: Node) {
    currentHead = head
  }
  
  
  
}
