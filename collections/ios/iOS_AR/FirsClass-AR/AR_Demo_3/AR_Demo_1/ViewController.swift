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
  
  let textures = ["earth.jpg","jupiter.jpg","mars.jpg","venus.jpg"]
  private var index = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // 现实帧数条
        sceneView.showsStatistics = true
        
      
      //!  场景
      let scene = SCNScene()
      sceneView.scene = scene
      
      let sphere = SCNSphere.init(radius: 0.1)
      
      let material = SCNMaterial()
      material.diffuse.contents = UIImage.init(named: "earth.jpg")
      sphere.materials = [material]


      
      let spherNode = SCNNode.init(geometry: sphere)
      
      spherNode.position = SCNVector3(0,0,-0.5)
      
      scene.rootNode.addChildNode(spherNode)
      
      
      registerGestureRecognizers()
      
      
    }
  
  func registerGestureRecognizers() {
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
    self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    
  }
  
  
  @objc func tapped (recognizer: UIGestureRecognizer){
    
    let sceneView = recognizer.view as! ARSCNView
    let touchLoaction = recognizer.location(in: sceneView)
    
    let hitRersults = sceneView.hitTest(touchLoaction, options: [:])
    
    // 每点一次，切换纹理
    if  !hitRersults.isEmpty {
      
      if index == self.textures.count {
        index = 0
      }
      
      guard let hitRersult = hitRersults.first else {
        return
      }
      
      let node = hitRersult.node
      
      node.geometry?.firstMaterial?.diffuse.contents = UIImage(named: textures[index])
      
      index += 1
    }
    
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
