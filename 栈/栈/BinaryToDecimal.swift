//
//  BinaryToDecimal.swift
//  栈
//  二进制转十进制
//  Created by 段雨田 on 2020/6/1.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class BinaryToDecimal: NSViewController {

  var inputStr:String!

  @IBOutlet weak var inputField: NSTextField!
  
  override func viewDidLoad() {
     
    super.viewDidLoad()
    
    
//    inputStr = "11001001"
        
  }
  
  
  @IBAction func bin2Dec(_ sender: Any) {
    
    if inputField.stringValue.isEmpty {
      let alert = NSAlert.init()
      alert.messageText = "请输入二进制"
      alert.icon = NSImage.init(named: "tishi.png")
      alert.beginSheetModal(for: self.view.window!, completionHandler: nil)
      return
    }
    
    inputStr = inputField.stringValue
    
    //! 栈
    let stack = Stack<Character>()
    //! 临时工
    var c : Character!
     
    //!
    var sum:Int = 0
    
    //！ 先入栈
    for index in inputStr.indices {
      c = inputStr[index]
      stack.push(c)
    }
    
    //! decimal 转换器
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .decimal
//
//    var numberStr:String!
//    numberStr = formatter.string(from: pow(2, i) as NSDecimalNumber)!

    var k:Int = 0
    
    for i in 0 ..< inputStr.count {
      c = stack.pop()
      k = (Int(pow(2, Double(i))))
      sum = sum + Int(c.asciiValue!-48) + k
    }
    print("二进制转换为十进制:\(sum)")
    
  }
  

  
  
  
    
}
