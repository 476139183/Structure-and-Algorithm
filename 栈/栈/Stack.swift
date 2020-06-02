//
//  Stack.swift
//  栈
//  
//  Created by 段雨田 on 2020/6/1.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Foundation

class Stack <Element> {
  
  fileprivate var array:[Element] = []
  
  func push(_ element: Element) {
    array.append(element)
  }
  
  func pop() -> Element {
    return array.popLast()!
  }

  func peek() -> Element {
    return array.last!
  }
    
  func size() -> Int {
    return array.count
  }
     
  func isEmpty() -> Bool {
    return array.isEmpty
  }
  
  
}



