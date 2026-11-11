//
//  SCNVector3+Extention.swift
//  AR_Demo_6
//
//  Created by Yutian Duan on 2020/5/15.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import ARKit


extension SCNVector3 {
  
  static func positionTransform(_ transform:matrix_float4x4) -> SCNVector3 {
    //! 返回相机的 坐标向量
    return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
  }
  
  
  /* 求 两点 的 距离：
   * vertor 出发的位置
   */
  func distance(form vertor : SCNVector3) -> Float {
    
    
    let distanceX = self.x - vertor.x
    let distanceY = self.y - vertor.y
    let distanceZ = self.z - vertor.z
    
    return sqrt((distanceX * distanceX) + (distanceY * distanceY) + (distanceZ * distanceZ))
  }

  //! 返回一个节点
  func line(to vertor:SCNVector3, color:UIColor) -> SCNNode {
    /*
     *
     */
    let indices : [UInt32] = [0,1]
    //! 两点结合连成线，创建一个 几何元素
    let source = SCNGeometrySource(vertices: [self,vertor])
    let element = SCNGeometryElement(indices: indices, primitiveType: .line)
    
    let geomtry = SCNGeometry(sources: [source], elements: [element])
    
    geomtry.firstMaterial?.diffuse.contents = color
    
    let node = SCNNode(geometry: geomtry)
    
    return node
  }
  
  
  
  
}

extension SCNVector3 : Equatable {
  
  
  public static func ==(lhs :SCNVector3, rhs : SCNVector3) ->Bool {
    
    return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z)
  }
  
  
  
}
