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
        
      let outText = SCNText.init(string: "you say what ?", extrusionDepth: 1.0)
      
      let materal = SCNMaterial.init()
      
      materal.diffuse.contents = UIColor.red
      outText.materials = [materal]
      
      let node = SCNNode.init(geometry: outText)
      node.scale = SCNVector3.init(0.01, 0.01, 0.01)
      node.position = SCNVector3.init(0, 0, -0.1)
      
      sceneView.scene.rootNode.addChildNode(node)
      
      
      
      
      
      
    }
  
  func registerGestureRecognizers() {
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
    self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    
  }
  
  
  @objc func tapped (recognizer: UIGestureRecognizer) {
    
    
    
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
