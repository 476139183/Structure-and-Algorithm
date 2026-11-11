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
  //! 管道状态
  var pipelineState :MTLRenderPipelineState?
  
  var scene:Scene?
  
  init(device:MTLDevice) {
    
    self.device = device
    commandQueue = device.makeCommandQueue()!
    super.init()
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
    
    let detalTime = 1/Float(view.preferredFramesPerSecond)
    
    scene?.render(commandEndcoder: commadEncoder!, detalTime: detalTime)
    
    commadEncoder?.endEncoding()
    //! 提交
    commandBuffer?.present(drawable)
    commandBuffer?.commit()
    
    
    
  }
  
  
  
}


