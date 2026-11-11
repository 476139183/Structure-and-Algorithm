//
//  GameScene.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit

class GameScene: Scene {
  
  var quad : Plane
  
  override init(device: MTLDevice, size: CGSize) {
    quad = Plane.init(device: device, imageName: "picture.png", maskImageName:"picture-frame-mask.png")
    super.init(device: device, size: size)
    
    addNode(childNode: quad)
    
    let pictureFrame = Plane.init(device: device, imageName: "picture-frame.png")
    addNode(childNode: pictureFrame)
    
  }
  
  
  
  
}
