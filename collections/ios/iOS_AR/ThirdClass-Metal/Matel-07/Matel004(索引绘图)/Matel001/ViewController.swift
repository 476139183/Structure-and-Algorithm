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
  
  var render:Render?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    metalView.device = MTLCreateSystemDefaultDevice()
    
    guard let device = metalView.device else {
      fatalError("error")
    }
    
    metalView.clearColor = Colors.wenderlichGreen
    
    render = Render.init(device: device)
    metalView.delegate = render as! MTKViewDelegate
    
  }
  
  
}


