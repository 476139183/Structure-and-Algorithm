//
//  InfixVC.swift
//  栈
//  中缀表达式 转 逆波兰表达式
//  Created by 段雨田 on 2020/6/2.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class InfixVC: NSViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
      
      
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
 
 
 */


/*
 
 从左到右遍历中缀表达式的每一个数字和符号，若是数字则直接输出，若是符号，则判断其与栈顶
 符号的优先级，是右括号或者优先级低于栈顶符号，则栈顶元素依次出栈并输出，直到遇到左括号或者栈空，才
 将该符号入栈。
 
 */
