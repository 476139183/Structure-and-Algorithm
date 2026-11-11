//
//  ViewController.swift
//  SpriteKit-002 for AR
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//  使用第三个选项，AR 创建 SpriteKit

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
  
  @IBOutlet var sceneView: ARSKView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and node count
    sceneView.showsFPS = true
    sceneView.showsNodeCount = true
    
    // Load the SKScene from 'Scene.sks'
    if let scene = SKScene(fileNamed: "Scene") {
      sceneView.presentScene(scene)
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //! 只追踪镜头的位置
    let configuration = AROrientationTrackingConfiguration()
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Pause the view's session
    sceneView.session.pause()
  }
  
  // MARK: - ARSKViewDelegate
  
  func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
    // Create and configure a node for the anchor added to the view's session.
    // comtrol+command+空格，调起表情包输入框
    let labelNode = SKLabelNode(text: "💣")
    labelNode.horizontalAlignmentMode = .center
    labelNode.verticalAlignmentMode = .center
    labelNode.fontSize = 50.0
    labelNode.name = "Bomb"
    return labelNode;
  }
  
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

