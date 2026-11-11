//
//  Node.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit

class Node {
  //! 默认名称
  var name = "Unitiled"
  //! 子节点
  var children:[Node] = []
  
  //! 增加子节点
  func addNode(childNode:Node) {
    children.append(childNode)
  }
  
  //! 处理每一个子节点：
  func render(commandEndcoder:MTLRenderCommandEncoder,detalTime:Float) {
    
    for child in children {
      child.render(commandEndcoder: commandEndcoder, detalTime: detalTime)
    }
    
  }
  
}

