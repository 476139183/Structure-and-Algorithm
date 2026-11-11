//
//  ViewController.swift
//  AR_Demo_8
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
  
  @IBOutlet var sceneView: ARSCNView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information
    sceneView.showsStatistics = true
    
    // 
    let scene = SCNScene(named: "art.scnassets/ship.scn")!
    
    // Set the scene to the view
    sceneView.scene = scene
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    
    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Pause the view's session
    sceneView.session.pause()
  }
  
  
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
  
  // MARK: - ARSCNViewDelegate
  
  /*
   // Override to create and configure nodes for anchors added to the view's session.
   func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
   let node = SCNNode()
   
   return node
   }
   */
  
  func session(_ session: ARSession, didFailWithError error: Error) {
    // Present an error message to the user
    
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
  }
}

