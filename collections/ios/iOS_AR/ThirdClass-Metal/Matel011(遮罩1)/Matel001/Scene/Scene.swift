//
//  Scene.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit

class Scene:Node {
  
  var device:MTLDevice
  var size: CGSize
  
  
  
  init(device:MTLDevice,size:CGSize) {
    self.device = device
    self.size = size
    super.init()
  }
  
  
  
}

