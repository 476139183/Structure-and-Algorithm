//
//  Plane.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit

class Plane: Node {
  
  //! 变成新的顶点数组，不存储重复数据
  var vertices:[Vertex] = [
    
    Vertex(position:float3(-1,1,0),color:float4(1,0,0,1)), //V0
    Vertex(position:float3(-1,-1,0),color:float4(0,1,0,1)),//V1
    Vertex(position:float3(1,-1,0),color:float4(0,0,1,1)), //V2
    Vertex(position:float3(1,1,0),color:float4(1,0,1,1)),  //V3
    
  ]
  
  //! 索引缓冲区,表示从 顶点数据读取角标，组成三角形
  var indces:[UInt16] = [
    0,1,2,
    2,3,0
  ]
  
  //! 移动量
  struct Constants {
    var animateBy:Float = 0.0
  }
  
  var constants = Constants()
  
  //! 开始时间
  var time :Float = 0
  //! 顶点缓冲区
  var vertexBuffer:MTLBuffer?
  
  //! 索引缓冲区
  var indexBuffer:MTLBuffer?

  init(device:MTLDevice) {
    super.init()
    buildBuffer(device: device)
  }
  
  func buildBuffer(device:MTLDevice) {
    /* 创建顶点缓冲区
     * 参数1 顶点数组
     * 参数2 总数据大小 = 个数*单个字节数
     */
    vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride, options: [])
    
    //! 创建索引缓冲区
    indexBuffer = device.makeBuffer(bytes: indces, length: indces.count * MemoryLayout<UInt16>.size, options: [])
    
  }

  
  override func render(commandEndcoder: MTLRenderCommandEncoder, detalTime: Float) {
    super.render(commandEndcoder: commandEndcoder, detalTime: detalTime)
    
    guard let indexBuffer = indexBuffer else {
      return
    }
    
    time += detalTime
    
    let animateBy = abs(sin(time))/2 + 0.5
    
    constants.animateBy = animateBy
    
    commandEndcoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)

    commandEndcoder.setVertexBytes(&constants, length: MemoryLayout<Constants>.stride, index: 1)
    
    commandEndcoder.drawIndexedPrimitives(type: .triangle, indexCount: indces.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
    
  }
  
  
}
