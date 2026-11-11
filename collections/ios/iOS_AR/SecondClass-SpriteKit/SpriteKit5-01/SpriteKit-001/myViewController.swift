//
//  myViewController.swift
//  SpriteKit-001
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import SpriteKit

class myViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /*
    print("enter")

    let limites = UIScreen.main.bounds
    
    let mySceneView = myScene.init(size:limites.size)
    mySceneView.scaleMode = .aspectFit
    
    let mySKView = self.view as!SKView
    
    mySKView.presentScene(mySceneView)
    mySKView.showsNodeCount = true
    mySKView.showsFPS = true
    ///! 默认是false，
    mySKView.ignoresSiblingOrder = true
    */
    
    if let view = self.view as? SKView {
      
      if let scene = SKScene.init(fileNamed: "myScene") {
        scene.scaleMode = .aspectFit
        view.presentScene(scene)
        
        
        
      }

    }

    
    
  }
  
  
}

