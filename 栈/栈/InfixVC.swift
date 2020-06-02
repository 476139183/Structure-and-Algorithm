//
//  InfixVC.swift
//  栈
//  中缀表达式 转 逆波兰表达式
//  Created by 段雨田 on 2020/6/2.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa


protocol InfixDelegate {
  func getInfix2RPN(outStr:String)
}

class InfixVC: NSViewController {
  
  @IBOutlet weak var inputTextField: NSTextField!
  
  var inputStr : String!
  
   //! 输出缓冲区
   var outStr = String()

  var delegate:InfixDelegate? = nil
  
  
  override func viewDidLoad() {
     
    super.viewDidLoad()
      
    inputTextField.stringValue = "1+(2-3)*4+10/5"
   
  }
  
  @IBAction func printInfix(_ sender: Any) {
    
    if inputTextField.stringValue.isEmpty {
      return
    }
    
    inputStr = inputTextField.stringValue
    printInfixLog()
    
  }
  
  @IBAction func gotoPreVC(_ sender: Any) {
    
    if outStr.count == 0 {
      return
    }
    
    if delegate != nil {
      delegate?.getInfix2RPN(outStr: outStr)
      self.view.window?.close()
    }
    
  }
  
}


fileprivate extension InfixVC {
  
  func printInfixLog() {
    
    //! 栈
    let stack = Stack<Character>()
    //！ 当前字符
    var c : Character!
    
    //!
    var e : Character!
    
    //! 数字缓存
    var strBuffer = String()
    
    outStr.removeAll()
   
    
    for index in inputStr.indices {
      c = inputStr[index]
      
      if (c >= "0" && c <= "9")  {
        //! 添加到缓冲区
        strBuffer.append(c)
        if c == inputStr.last {
          //! 如果是最后一个元素，则直接添加到输出字符串中,否则等待
          outStr.append(contentsOf: "\(strBuffer) ")
          strBuffer.removeAll()
        }
        continue
      } else {
        // 如果是非数字，则先把之前的缓冲区添加到字符串中
        if strBuffer.count > 0 {
          outStr.append(contentsOf: "\(strBuffer) ")
          strBuffer.removeAll()
        }
     
      }
      
       
      if (c == ")") {
        //! 遇到右括号，则一直弹栈，直到遇到对应的右括号:也就是优先处理括号里面的数据
        e = stack.pop()
        while e != "(" {
          outStr.append("\(e!) ")
          e = stack.pop()
        }
        
      } else if (c == "+" || c == "-") {
        //! 优先级比较低 所以要弹出里面的数据
        if stack.size() == 0 {
          //！栈空则入栈
          stack.push(c)
        } else {
          //! 否则按照将栈依次出栈，直到栈空 或者遇到右括号
          repeat {
            e = stack.pop()
            if e == "(" {
              stack.push(e)
            } else {
              //! 栈里面的 加 减 乘 除 优先出列
              outStr.append("\(e!) ")
            }
            
          } while (stack.size() > 0 && e != "(")
          
          //! 清空后，将这个等待的符号入栈
          stack.push(c)
          
        }
        
      } else if (c == "*" || c == "/" || c == "(") {
        
        stack.push(c)
        
      } else {
        
        //! 输入错误
        
      }
      
      
    }
    
    
    //！ 如果栈有元素，则打印出来
    while stack.size() > 0 {
      outStr.append("\(stack.pop()) ")
    }
  
    print("最终得到的逆波兰表达式:\(outStr)")
    
  }
  
  
  
}


//! 中缀表达式 转为 后缀表达式，其实就是利用栈
//! 1+(2-3)*4+10/5
/*
 
 首先遇到第一个输入是数字1，数字1在后缀表达式中都是直接输出，接着是符号 "+",入栈：
 第三个字符是 “(”,依然是符号，入栈，接着是数字2，输出，然后是符号 “-”，入栈：
 
 
 接下来是数字3，输出，紧跟着是 “)”,此时我们去匹配栈里面对应的 "(", 然后在找到对应的"("前 先将栈顶数据依次出栈输出，这样也就是实现括号里优先执行的道理：也就是我们会输出 "-",此时栈只有 "+"。
 
 紧接着是 符号 “*”，直接入栈：
 
 遇到数字4，输出，之后是符号“+”，而此时栈顶元素是符号“*”，按照先乘除后加减的原理，此时栈顶的乘号优先级比即将入栈的
 “+”要高，所以 “*” 先出栈。
 
 此时，栈顶也是 “+”，按照FIFO原则，栈顶的 “+” 也出栈(同理，栈里还有其他操作符，也是依次出栈)
 
 操作完之后，这个 "+" 才能入栈
 
 紧接着是数字 10，输出，然后是符号 "/",进栈：
 
 最后一个数字5 输出，所有的输入处理完毕，但是栈中依然有数据，将栈中的符号依次出栈输出。
 
 
 完整的输出是：
 
 1 2 3 - 4 * + 10 5 / +
 
 */


/*
 
 从左到右遍历中缀表达式的每一个数字和符号，若是数字则直接输出，若是符号，则判断其与栈顶
 符号的优先级，是右括号或者优先级低于栈顶符号，则栈顶元素依次出栈并输出，直到遇到左括号或者栈空，才
 将该符号入栈。
 
 */
