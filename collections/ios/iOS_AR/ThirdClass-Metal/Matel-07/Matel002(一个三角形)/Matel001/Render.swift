//
//  Render.swift
//  Matel001
//  封装渲染器 绘制三角形
//  Created by Yutian Duan on 2020/5/18.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit


class Render: NSObject {
  
  let device : MTLDevice
  let commandQueue : MTLCommandQueue!
  
  //! 顶点数组
  var vertices:[Float] = [
    0,1,0,
    -1,-1,0,
    1,-1,0
  ]
  //! 管道状态
  var pipelineState :MTLRenderPipelineState?
  //! 缓冲区
  var vertexBuffer:MTLBuffer?
  
  init(device:MTLDevice) {
    
    self.device = device
    commandQueue = device.makeCommandQueue()!
 
    super.init()
    buildModel()
    buildPipelineState()
  }
  
  
  //!  处理顶点
  private func buildModel() {
    /* 创建顶点缓冲区
     * 参数1 顶点数组
     * 参数2 总数据大小 = 个数*单个字节数
     */
    vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Float>.size, options: [])
    
    
    
  }
  
  //! 处理管道状态
  private func buildPipelineState() {
    
    //! 存储GPU中的事项
    let libary = device.makeDefaultLibrary()
    ///! 获取metal 的方法
    let vertextFunction = libary?.makeFunction(name: "vertex_shader")
    
    let fragmentFunction = libary?.makeFunction(name: "fragment_shader")
    
    //!
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    //! 函数
    pipelineDescriptor.vertexFunction = vertextFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction
    
    
    pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
    
    //!
    do {
      pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
      
    } catch let error as NSError {
      print("error:\(error.localizedDescription)")
    }
    
    
    
  }
  
  
}


extension Render :MTKViewDelegate {
  
  //! 视图改变大小的时候 调用
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
  
  //! 渲染 每一帧调用
  func draw(in view: MTKView) {
    
    guard let drawable = view.currentDrawable,
      let pipelineState = pipelineState,
      let descriptor = view.currentRenderPassDescriptor else {
      return
    }
    
    //TODO:2
    //! 缓冲区
    let commandBuffer = commandQueue.makeCommandBuffer()
    //! 对命令进行编码（PassDescriptor 描述符）
    let commadEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
    //! 设置管道状态
    commadEncoder?.setRenderPipelineState(pipelineState)
    //! 读取顶点缓冲区
    commadEncoder?.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
    
    //! 绘制模式，读取位置，个数
    commadEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: vertices.count)
    
    commadEncoder?.endEncoding()
    //! 提交
    commandBuffer?.present(drawable)
    commandBuffer?.commit()
    
    
    
  }
  
  
  
}


