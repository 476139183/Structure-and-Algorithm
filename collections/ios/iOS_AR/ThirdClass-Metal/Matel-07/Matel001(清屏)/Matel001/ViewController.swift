//
//  ViewController.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/18.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import MetalKit

enum Colors {
  static let wenderlichGreen = MTLClearColor(red: 0.0, green: 0.4, blue: 0.0, alpha: 1.0)
  
}

class ViewController: UIViewController {
  
  //! 创建一个view
  var metalView:MTKView {
    return view as! MTKView
  }
  
  //! 创建设备
  var device:MTLDevice!
  //! 队列
  var commadQueue:MTLCommandQueue!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //! 使用手机的GPU
    metalView.device = MTLCreateSystemDefaultDevice()
    device = metalView.device
    //! 清屏颜色
    metalView.clearColor = Colors.wenderlichGreen
    //! 获取队列，一个CPU 对应一个队列
    commadQueue = device.makeCommandQueue()
    
    //TODO:1
//    //! 缓冲区
//    let commandBuffer = commadQueue.makeCommandBuffer()
//    //! 对命令进行编码（PassDescriptor 描述符）
//    let commadEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: metalView.currentRenderPassDescriptor!)
//    commadEncoder?.endEncoding()
//    //! 提交
//    commandBuffer?.present(metalView.currentDrawable!)
//    commandBuffer?.commit()
    
  }
  
  
}


extension ViewController :MTKViewDelegate {
  
  //! 视图改变大小的时候 调用
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
  
  //! 渲染 每一帧调用
  func draw(in view: MTKView) {
    
    guard let drawable = view.currentDrawable,let descriptor = view.currentRenderPassDescriptor else {
      return
    }
    
    //TODO:2
    //! 缓冲区
    let commandBuffer = commadQueue.makeCommandBuffer()
    //! 对命令进行编码（PassDescriptor 描述符）
    let commadEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
    commadEncoder?.endEncoding()
    //! 提交
    commandBuffer?.present(drawable)
    commandBuffer?.commit()

    
    
  }
  
  
  
}

