//
//  RPNVC.swift
//  栈
//  逆波兰表达式
//  Created by 段雨田 on 2020/6/1.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class RPNVC: NSViewController {
  
  var inputStr:String!
  
  @IBOutlet weak var inputTextField: NSTextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //！ 实现对 逆波兰 输入的表达式进行计算。
    //！ 支持带小数点的数据。
    //！ a+(b-c)*d  ---> a b c - d * +
    
//    inputStr =
//    reversePolish()
    
    inputTextField.stringValue = "5 6 7 + 8 * - 9 4 / +"
    
  }
  
  @IBAction func printInput(_ sender: Any) {
    
    if inputTextField.stringValue.isEmpty {
      return
    }
    
    inputStr = inputTextField.stringValue
    reversePolish()
    
  }
  
  @IBAction func gotoInfixVC(_ sender: Any) {
    
    let svc:InfixVC = (storyboard?.instantiateController(identifier: "infixVC"))! as InfixVC
    svc.delegate = self
    self.presentAsModalWindow(svc);
    
  }
  
  
  //! 求解 逆波兰表达式
  func reversePolish() {
    
    //! 栈
    let stack = Stack<Double>()
    //！ 当前字符
    var c : Character!
    //! 字符串缓存
    var strBuffer = String()
    var d,e : Double!
    
    for index in inputStr.indices {
      
      c = inputStr[index]
      
      if (c >= "0" && c <= "9") || c == "."  {
        //! 说明是数字 或者是 .
        strBuffer.append(c)
      } else if (c == " ") {
        //! 是空格,则将当前的字符串转换为浮点
        if strBuffer.count > 0 {
          d = Double(String.init(strBuffer))
          strBuffer.removeAll()
          stack.push(d)
        }
      
      } else if (c == "+") {
        e = stack.pop()
        d = stack.pop()
        stack.push(d+e)
      } else if (c == "-") {
        e = stack.pop()
        d = stack.pop()
        stack.push(d-e)
      } else if (c == "*") {
        e = stack.pop()
        d = stack.pop()
        stack.push(d*e)
      } else if (c == "/") {
        //! 可以做容错处理， e 不能为0
        e = stack.pop()
        d = stack.pop()
        stack.push(d/e)
      }
      
    }
    
    d = stack.pop()
    print("\n最终计算结果:\(d!)")

  }

    
}

extension RPNVC : InfixDelegate {
  
  func getInfix2RPN(outStr: String) {
    // 将获取的逆波兰表达式显示出来
    inputTextField.stringValue = outStr
    
  }
  
  
  
}


/*
 
 对于 (1-2) * (4+5)
 逆波兰表达式为  1 2 - 4 5 + *
 
 数字 1 和 2 进栈，遇到减号运算符则弹出两个元素进行运算，并将结果-1，入栈
 
 4 和 5 入栈，遇到加号运算符，那么 4 和 5 弹出栈，相加得到结果9，入栈
 
 然后又遇到乘法运算符，将9和-1 弹出栈进行乘法运算，此时栈空，并无其他数据入栈， -9 为最终运算结果！
 
 */
