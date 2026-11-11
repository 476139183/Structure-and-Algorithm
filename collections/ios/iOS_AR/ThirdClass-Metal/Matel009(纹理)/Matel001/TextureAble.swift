//
//  TextureAble.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import MetalKit

protocol TextureAble {
  
  var texture:MTLTexture? {get set}

}


extension TextureAble {
  
  func setTexture(deivce:MTLDevice, imageName:String) -> MTLTexture? {
    
    let textureLoader = MTKTextureLoader(device: deivce)
    
    var texture:MTLTexture? = nil
    
    let textureLoaderOptions:[MTKTextureLoader.Option:NSObject]
    
    
    if #available(iOS 10.0, *) {
      //! 从左下开始渲染
      let origin = NSString(string: MTKTextureLoader.Origin.bottomLeft.rawValue)
      textureLoaderOptions = [MTKTextureLoader.Option.origin : origin]

    } else {
      textureLoaderOptions = [:]
    }
    
    
   
    if let textureURL = Bundle.main.url(forResource: imageName, withExtension: nil) {
      
      do {
        texture = try textureLoader.newTexture(URL: textureURL,
                                               options: textureLoaderOptions)
      } catch {
        print("texture not created")
      }
      
      
    }
    
    
    return texture
  }
  
  
}
