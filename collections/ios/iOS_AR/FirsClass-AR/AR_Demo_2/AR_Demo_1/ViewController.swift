//
//  ViewController.swift
//  AR_Demo_1
//
//  Created by Yutian Duan on 2020/5/11.
//  Copyright © 2020年 Lingzhu. All rights reserved.
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
        
        // 现实帧数条
        sceneView.showsStatistics = true
        
      
      //!  场景
      let scene = SCNScene()
      sceneView.scene = scene
      
      //! 创建内置的盒子
      let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
      
      //! 渲染器
      let material = SCNMaterial()
      
//     1.  material.diffuse.contents = UIColor.red
      
      // 2.
      material.diffuse.contents = UIImage.init(named: "brick.png")
      
      //!
      box.materials = [material]
      
      
      // 创建节点
      let boxNode = SCNNode.init(geometry: box)
      
      //! 节点位置
      boxNode.position = SCNVector3(0,0,-0.2)
      //!
      scene.rootNode.addChildNode(boxNode)
    
      
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 设置 追踪
        let configuration = ARWorldTrackingConfiguration()

        // 启动追踪
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
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
