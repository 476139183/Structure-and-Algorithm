//
//  Renderable.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit


protocol Renderable {
  
  //! 管道状态
  var pipelineState : MTLRenderPipelineState!{get set}
  var vertexFunctionName : String {get}
  var fragmentFunctionName : String {get}
  var vertexDescriptor : MTLVertexDescriptor {get}
  
}


extension Renderable {
  
  func buildPipelineState(device:MTLDevice) -> MTLRenderPipelineState {
    
    //! 存储GPU中的事项
    let libary = device.makeDefaultLibrary()
    ///! 获取metal 的方法
    let vertextFunction = libary?.makeFunction(name: vertexFunctionName)
    
    let fragmentFunction = libary?.makeFunction(name: fragmentFunctionName)
    
    //!
    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    //! 函数
    pipelineDescriptor.vertexFunction = vertextFunction
    pipelineDescriptor.fragmentFunction = fragmentFunction
    
    pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
    
    //! 描述符
    pipelineDescriptor.vertexDescriptor = vertexDescriptor
   
    let pipelineState : MTLRenderPipelineState
    
    
    //!
    do {
      pipelineState = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
      
    } catch let error as NSError {
      //! fatalError
      fatalError("error:\(error.localizedDescription)")
    }
    
    return pipelineState
    
    
  }
  
  
  
  
  
  
}
