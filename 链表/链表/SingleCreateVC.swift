//
//  SingleCreateVC.swift
//  链表
//
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

protocol SingleCreateDelegate {
  
  func getCreateHeadNode(head:Node)
  
}

class SingleCreateVC: NSViewController {

    
  @IBOutlet var baseCustomTextView: YTBaseTextView!
  
  var delegate:SingleCreateDelegate? = nil
  
  
  @IBOutlet weak var numberTextFile: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    baseCustomTextView.placeholder = "输入示例：1,4,6,8,9,3,9  ⚠️这边并未做正确性校验"
   
  }
  
  
  //！ 一键 快速创建
  @IBAction func createFast(_ sender: Any) {
    
    
    
    guard let number = Int(numberTextFile.stringValue) else {
      return
    }
    let head = Node.createFast(number)
   
    if (delegate != nil) {
      delegate?.getCreateHeadNode(head: head)
      self.view.window?.close()
    }
    
  }
    
  
  //！ 自定义创建
  @IBAction func createCustom(_ sender: Any) {

    if  baseCustomTextView.string.isEmpty {
      return
    }
    
    guard let arr = baseCustomTextView.string.components(separatedBy: ",") as [String]?,
      arr.count > 0 else {
      return
    }
    
    var head:Node? = nil
    
    for i in stride(from: arr.count-1, through: 0, by: -1) {
      
      let number = Int(arr[i])!
      
      
      let node = Node(data: number)
      
      if ( head != nil) {
        node.next = head!;
        head = node
      } else {
        head = node
      }
            
    }
    
    if (delegate != nil) {
      delegate?.getCreateHeadNode(head: head!)
      self.view.window?.close()
    }
    

  }
  
 
}
  
  


