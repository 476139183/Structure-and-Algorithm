//
//  Line+Extention.swift
//  AR_Demo_6
//
//  Created by Yutian Duan on 2020/5/15.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import ARKit


enum LengthUnit {
  case meter,cenitMeter,inch
  
  var factor:Float {
    switch self {
    case .meter:
      return 1.0
    case .cenitMeter:
      return 100.0
    case .inch:
      return 39.3700787
    }
  }
  
  
  var name:String {
    switch self {
    case .meter:
      return "m"
    case .cenitMeter:
      return "cm"
    case .inch:
      return "inch"
    }
  }

}

class Line {
  
  var color = UIColor.orange
  
  var startNode : SCNNode
  var endNode: SCNNode
  
  var textNode : SCNNode
  var text:SCNText
  
  var lineNode: SCNNode?
  
  
  let sceneView : ARSCNView
  let startVector : SCNVector3
  
  let unit : LengthUnit
  
  init(sceneView:ARSCNView, startVector:SCNVector3, unit : LengthUnit) {
    
    //! 创建 开始 结束 线 数字 单位 等节点
    self.sceneView = sceneView
    self.startVector = startVector
    self.unit = unit
    
    let dot = SCNSphere(radius: 0.5)
    dot.firstMaterial?.diffuse.contents = color
    //! 普通光照
    dot.firstMaterial?.lightingModel = .constant
    //! 两边都会光亮
    dot.firstMaterial?.isDoubleSided = true
    
    //！ 创建一个两面光亮 抛光的球
    startNode = SCNNode(geometry: dot)
    //FIXME:需要调整 1/500 有bug
    startNode.scale = SCNVector3(1/500.0, 1/500.0, 1/500.0)
    startNode.position = startVector
    sceneView.scene.rootNode.addChildNode(startNode)
    
    endNode = SCNNode(geometry: dot)
    endNode.scale = startNode.scale
    
    text = SCNText(string: "", extrusionDepth: 0.1)
    
    text.font = .systemFont(ofSize:5)
    text.firstMaterial?.lightingModel = .constant
    text.firstMaterial?.isDoubleSided = true
    text.alignmentMode = CATextLayerAlignmentMode.center.rawValue
    text.truncationMode = CATextLayerTruncationMode.middle.rawValue
    
    //! 包装 text
    let textWrapperNode = SCNNode(geometry: text)
    textWrapperNode.eulerAngles = SCNVector3Make(0, .pi, 0)
    textWrapperNode.scale = startNode.scale
    
    textNode = SCNNode()
    textNode.addChildNode(textWrapperNode)
    
    ///! 始终面向  sceneView.pointOfView
    let constraint = SCNLookAtConstraint(target: sceneView.pointOfView)
    
    constraint.isGimbalLockEnabled = true
    //! 添加约束
    textNode.constraints = [constraint]
    
    sceneView.scene.rootNode.addChildNode(textNode)
    
    
    
  }
  
  func update(to vector :SCNVector3) {
    //! 更新 线条 节点
    lineNode?.removeFromParentNode()
    
    lineNode = startVector.line(to: vector, color: color)
    
    sceneView.scene.rootNode.addChildNode(lineNode!)
    
    //! 更新文字
    text.string = distance(to:vector)
    
    //! 设置文字的位置 (线条中间的位置)
    textNode.position = SCNVector3((startVector.x + vector.x)/2.0, (startVector.y + vector.y)/2.0, (startVector.z + vector.z) / 2.0)
   
    //! 结束时，手机移动距离
    endNode.position = vector
    
    if endNode.parent == nil {
      sceneView.scene.rootNode.addChildNode(endNode)
    }
    
    
    
  }
  
  
  func distance(to vector:SCNVector3) -> String {
    
    
    return String(format:"%.2f %@",startVector.distance(form: vector) * unit.factor, unit.name)
    
  }
  
  
  //! 移除所有节点
  func remove () {
    
    startNode.removeFromParentNode()
    endNode.removeFromParentNode()
    textNode.removeFromParentNode()
    lineNode?.removeFromParentNode()
    
  }
  
  
  
}
