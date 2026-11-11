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
        
        // 读取模型
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
      
        //! 添加一个手势
      let topGesutre = UITapGestureRecognizer.init(target: self, action: #selector(ViewController.handtap(gestureRecongnizer:)))
      
      view.addGestureRecognizer(topGesutre)
      
      
    }
  
  
  @objc func handtap(gestureRecongnizer:UITapGestureRecognizer) {
   
    //! 每点一次，需要追踪镜头位置，
    
    guard let currentFrame = sceneView.session.currentFrame else {
      return
    }
    
    
    ///! 创建一个图片
    let imagePlane = SCNPlane.init(width: sceneView.bounds.width/6000.0, height: sceneView.bounds.size.height / 6000.0)
    ///! 渲染图片 , 截屏
    imagePlane.firstMaterial?.diffuse.contents = sceneView.snapshot()
    //!
    imagePlane.firstMaterial?.lightingModel = .constant
    
    //! 创建一个节点
    let planNode = SCNNode.init(geometry: imagePlane)
    
    sceneView.scene.rootNode.addChildNode(planNode)
    
    
    //!  追踪相机的位置
    
    var translate = matrix_identity_float4x4
    //! 向屏幕 移动 0.1
    translate.columns.3.z = -0.1
    //!
    planNode.simdTransform = matrix_multiply(currentFrame.camera.transform, translate)
    
    
    
    
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
