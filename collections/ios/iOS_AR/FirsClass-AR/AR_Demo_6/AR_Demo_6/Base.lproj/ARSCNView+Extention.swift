//
//  ARSCNView+Extention.swift
//  AR_Demo_6
//
//  Created by Yutian Duan on 2020/5/15.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import ARKit

extension ARSCNView {
  
  //! 拿到实时的三维坐标
  func worldVector(for position:CGPoint) -> SCNVector3? {
   
    let resluts = self.hitTest(position, types: [.featurePoint])
    
    guard let reslut = resluts.first else {
      return nil;
    }
    //! 获得 相机的位置
    return SCNVector3.positionTransform(reslut.worldTransform)
    
  }
  
  
}
