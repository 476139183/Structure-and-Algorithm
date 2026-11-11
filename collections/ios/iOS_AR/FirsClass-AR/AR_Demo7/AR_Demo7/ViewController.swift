//
//  ViewController.swift
//  AR_Demo7
//  https://www.jianshu.com/p/fa64d4302a05
//  Created by Yutian Duan on 2020/5/16.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
  
  @IBOutlet var sceneView: ARSCNView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sceneView.delegate = self
    sceneView.showsStatistics = true
    sceneView.debugOptions = .showFeaturePoints
    //是否自动给模型打光
//    sceneView.automaticallyUpdatesLighting = true

  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    //平面检测 水平平面
    configuration.planeDetection = .horizontal

    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Pause the view's session
    sceneView.session.pause()
  }
  
  /* ! 检测平面 就会调用这个方法
   * 需要起身在附近慢慢的多多观察 
   */
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    
    if anchor is ARPlaneAnchor {
      //! 如果是 平面锚点
      let planeAnchor = anchor as! ARPlaneAnchor
      //! 水平面，需要 X 和 Z轴
      /*
       extent 侦测的水平面
       */
      let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
      
      let planeNode = SCNNode()
      //! 节点处于 锚点的平面中心
      planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
      //! 逆时针旋转 90度
      planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
      
      let material = SCNMaterial()
      material.diffuse.contents = UIImage.init(named: "art.scnassets/grid.png")
      plane.materials = [material]
      
      planeNode.geometry = plane
      node.addChildNode(planeNode)
      
    }
    
    
  }
  
  //! 侦测出水平面后，点击水平面
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // 第一次触摸屏幕
    if let touch = touches.first {
      //! 获取点击的屏幕区域
      let touchLocation = touch.location(in: sceneView)
      
      /* ! 将屏幕位置 转换为 3D坐标
       * existingPlaneUsingExtent 表示点击事件只有在触摸在侦测的屏幕范围才生效
       */
      let results = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
      
      /*
       *
       */
      if let hitResult = results.first {
        let boxScene = SCNScene.init(named: "art.scnassets/ship.scn")
        
        if let boxNode = boxScene?.rootNode.childNode(withName: "box", recursively: true) {
          
          //! 修改子节点 位置
          boxNode.position = SCNVector3(hitResult.worldTransform.columns.3.x,hitResult.worldTransform.columns.3.y,hitResult.worldTransform.columns.3.z)
          sceneView.scene.rootNode.addChildNode(boxNode)
          
        }
        
      }
      
      
    }
    
    
  }
  
  func session(_ session: ARSession, didFailWithError error: Error) {
    
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    
  }
  
  
}

