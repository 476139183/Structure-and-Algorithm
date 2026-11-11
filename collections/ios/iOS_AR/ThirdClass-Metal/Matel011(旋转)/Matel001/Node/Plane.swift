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
    
    Vertex(position:float3(-1,1,0),color:float4(1,0,0,1), texture:float2(0,1)), //V0
    Vertex(position:float3(-1,-1,0),color:float4(0,1,0,1), texture:float2(0,0)),//V1
    Vertex(position:float3(1,-1,0),color:float4(0,0,1,1), texture:float2(1,0)), //V2
    Vertex(position:float3(1,1,0),color:float4(1,0,1,1), texture:float2(1,1)),  //V3
    
  ]
  
  //! 索引缓冲区,表示从 顶点数据读取角标，组成三角形
  var indces:[UInt16] = [
    0,1,2,
    2,3,0
  ]
  
  
  //! 场景 Transform
  var modelConstants = ModelConstants()
  
  //! 开始时间
  var time :Float = 0
  
  var pipelineState : MTLRenderPipelineState!
  var vertexFunctionName:String = "vertex_shader"
  var fragmentFunctionName:String = "fragment_shader"
  
  var vertexDescriptor : MTLVertexDescriptor {
    //! 顶点的描述符
    let vertexDescriptor = MTLVertexDescriptor()
    
    //! 取 顶点 的逻辑
    vertexDescriptor.attributes[0].format = .float3
    vertexDescriptor.attributes[0].offset = 0;
    vertexDescriptor.attributes[0].bufferIndex = 0
    
    //! 取 RGBA的逻辑
    vertexDescriptor.attributes[1].format = .float4
    //! 偏移量。跳过顶点的偏移量
    vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
    vertexDescriptor.attributes[1].bufferIndex = 0
    
    //!  纹理坐标
    vertexDescriptor.attributes[2].format = .float2
    //! 跳过顶点和rgba 的 偏移量
    vertexDescriptor.attributes[2].offset = MemoryLayout<float3>.stride + MemoryLayout<float4>.stride
    vertexDescriptor.attributes[2].bufferIndex = 0

    //! 统一处理 整合前面的命令
    vertexDescriptor.layouts[0].stride = MemoryLayout<Vertex>.stride
        

    return vertexDescriptor
  }
  
  
  var texture:MTLTexture?
  
  
  //! 顶点缓冲区
  var vertexBuffer:MTLBuffer?
  
  //! 索引缓冲区
  var indexBuffer:MTLBuffer?
  
  //! 遮罩 mask
  var maskTexture : MTLTexture?
  
  
  
  

  init(device:MTLDevice) {
    super.init()
    buildBuffer(device: device)
    pipelineState = buildPipelineState(device:device)
  }
  
  init(device:MTLDevice,imageName:String) {
    
    super.init()
    
    if let texture = setTexture(deivce: device, imageName: imageName) {
      self.texture = texture
      fragmentFunctionName = "texture_shader"
    }
    
    buildBuffer(device: device)
    pipelineState = buildPipelineState(device:device)
    
  }
  
  //! 遮罩初始化
  init(device:MTLDevice,imageName:String, maskImageName:String) {
    
    super.init()
    
    if let texture = setTexture(deivce: device, imageName: imageName) {
      self.texture = texture
      fragmentFunctionName = "texture_shader"
    }
    
    if let maskTexture = setTexture(deivce: device, imageName: maskImageName) {
      self.maskTexture = maskTexture
      fragmentFunctionName = "texture_mask_fragment"
    }
    
    buildBuffer(device: device)
    pipelineState = buildPipelineState(device:device)
    
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
    
    /* // 1. 缩小到0.5
      let modelViewMatrix = matrix_float4x4(scaleX: 0.5, y: 0.5, z: 0.5)
      modelConstants.modelViewMatrix = modelViewMatrix;
   */
  
   /*  // 2. 缩小并旋转,但是会变形
     var modelViewMatrix = matrix_float4x4(scaleX: 0.5, y: 0.5, z: 0.5)
     let rotationMatrix = matrix_float4x4(rotationAngle:animateBy,x:0,y:0,z:1)
     modelViewMatrix = matrix_multiply(rotationMatrix, modelViewMatrix)
     modelConstants.modelViewMatrix = modelViewMatrix;
    */
    
    
    //! 3. 旋转，但是不会变形
    //! 围绕z轴旋转
    let rotationMatrix = matrix_float4x4(rotationAngle:animateBy,x:0,y:0,z:1)
    //!  移动到 屏幕 -4 的位置，否则看不到
    let viewMatrix = matrix_float4x4(translationX: 0, y: 0, z: -4)

    var modelViewMatrix = matrix_multiply(rotationMatrix, viewMatrix)
    
    let aspect = Float(750.0/1334.0)
    /* 投影矩阵: 等于一个空间盒子,没有投影矩阵，图片会变形
     * 角度
     * 纵横比
     * 近面 和 远面
     */
    let projectionMatrix = matrix_float4x4(projectionFov: radians(fromDegrees: 65.0), aspect: aspect, nearZ: 0.1, farZ: 100)
    
    modelViewMatrix = matrix_multiply(projectionMatrix, modelViewMatrix)
    modelConstants.modelViewMatrix = modelViewMatrix;
    //
    
    //! 设置管道状态
    commandEndcoder.setRenderPipelineState(pipelineState)
    

    commandEndcoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)

    commandEndcoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
    
    //! 设置片元着色器 纹理
    commandEndcoder.setFragmentTexture(texture, index: 0)
    //! mask纹理
    commandEndcoder.setFragmentTexture(maskTexture, index: 1)

    commandEndcoder.drawIndexedPrimitives(type: .triangle, indexCount: indces.count, indexType: .uint16, indexBuffer: indexBuffer, indexBufferOffset: 0)
    
  }
  
  
}


extension Plane : Renderable {
  
  
}


extension Plane: TextureAble {
  
  
}
