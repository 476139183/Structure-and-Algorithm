//
//  FibonacciVC.swift
//   递归
//
//  Created by 段雨田 on 2020/6/1.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class FibonacciVC: NSViewController {

    
  override func viewDidLoad() {
    super.viewDidLoad()
      
    print("斐波拉契数")
    print(fib2(n: 12))
  }
  
  
  //! 递归 斐波拉契
  func fib1(n : Int ) -> Int {
     
    if n <= 1 {
      return n
    }
    return fib1(n:n-1)+fib1(n:n-2)
   
  }
   
  //! 迭代 斐波拉契
  

  func fib2(n : Int ) -> Int {
   
    if n <= 1 {
      return n
    }
     
    var first = 0
    var second = 1
     
    for _ in 0 ..< n-1 {
      let sum = first+second
      first = second
      second = sum
    }
     
    return second
  
  }
    
}

