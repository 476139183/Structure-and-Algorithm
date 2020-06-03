//
//  HanoiVC.swift
//  递归
//
//  Created by 段雨田 on 2020/6/2.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

 //! 3个盘子 走 7 步， 4个盘子 走 15 步，5个盘子 走 31步

class HanoiVC: NSViewController {

  override func viewDidLoad() {
      
    super.viewDidLoad()
    
    print("\n汉诺塔-------移动步骤如下：")
   
    HanoiVC.move(n: 5, x: "X", y: "Y", z: "Z")
  
  }
  
  /// 汉诺塔： 将 n 个 盘子 从 x 借助 y 移动到 z
  /// - Parameters:
  ///   - n: 盘子个数
  ///   - x: 初始轴：盘子所在轴
  ///   - y: 中间轴：借助移动的轴
  ///   - z: 目标轴：移动到该轴上
  class func move(n:Int,x:Character,y:Character,z:Character) {
    
    if n == 1 {
      
      print("\(x)-->\(z)")
      
    } else {
      
      move(n: n-1, x: x, y: z, z: y)    //! 1. 将 n-1 移动到 y 上
     
      print("\(x)-->\(z)")               //! 2. 将 第n个盘子移动到z 上
      
      move(n: n-1, x: y, y: x, z: z)     //！3. 再将 y 上的 n-1 移动到z
    }
    
  }
    
}


/*

如果只有一个盘，那么直接移动到Z轴
 
如果是 n 个盘(n > 1)，想把 n 个盘子借助 y 移动到z， 那么需要先
1. 借助 z，将 n-1个盘子 从x 移动到 y，
2. 然后将 第n个盘子， 从x 移动到 z，
3. 将 n-1 个盘子 借助 从 y 借助 x 移动到z
 
以上就完成了整个移动
*/
