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
  var scene:Scene?
  //! 采样器状态
  var samplerState :MTLSamplerState?
  
  
  
  init(device:MTLDevice) {
    
    self.device = device
    commandQueue = device.makeCommandQueue()!
    super.init()
    buildSamplerState()
  }
  

  
  private func buildSamplerState() {
    //! 采样器的描述符
    let descriptor = MTLSamplerDescriptor()
    //!当设置拉伸的时候 使用线性处理
    descriptor.minFilter = .linear
    //! 当缺失状态的时候也使用线性处理
    descriptor.magFilter = .linear
    
    samplerState = device.makeSamplerState(descriptor: descriptor)
    
  }
  
}


extension Render :MTKViewDelegate {
  
  //! 视图改变大小的时候 调用
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
  
  //! 渲染 每一帧调用
  func draw(in view: MTKView) {
    
    guard let drawable = view.currentDrawable,
      let descriptor = view.currentRenderPassDescriptor else {
      return
    }
    
    //! 缓冲区
    let commandBuffer = commandQueue.makeCommandBuffer()
    
    //! 对命令进行编码（PassDescriptor 描述符）
    let commadEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
    //！ 告诉 GPU 使用这个采样器
    commadEncoder?.setFragmentSamplerState(samplerState, index: 0)
    
    
    let detalTime = 1/Float(view.preferredFramesPerSecond)
    
    scene?.render(commandEndcoder: commadEncoder!, detalTime: detalTime)
    
    commadEncoder?.endEncoding()
    //! 提交
    commandBuffer?.present(drawable)
    commandBuffer?.commit()
    
    
    
  }
  
  
  
}


