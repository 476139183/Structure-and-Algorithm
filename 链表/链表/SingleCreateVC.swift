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

  @IBOutlet var customTextView: NSTextView!
  
  var delegate:SingleCreateDelegate? = nil
  
  @IBOutlet weak var numberTextFile: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
  }
  
  
  
  
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
    
  
  @IBAction func createCustom(_ sender: Any) {

    if  customTextView.string.isEmpty {
      return
    }
    
    guard let arr = customTextView.string.components(separatedBy: ",") as [String]?,
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
  
  


