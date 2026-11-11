//
//  GameViewController.swift
//  SpriteKit-003
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

/**
 SKNode & SKScene
 
 node: 树状的组织结构
 
 属性：
 Position: node 定位在坐标系中的位置
 xScale & yScale 尺寸的缩放
 zRotate:  旋转节点
 Frame: 节点所包围的矩形区域
 Accumulated: 积累，  AccumulatedFrame 就是节点未覆盖的区域
 Alpha: 透明度
 isHidden: 能见度
 
 */

class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let view = self.view as! SKView? {
      // Load the SKScene from 'GameScene.sks'
      
      /*
       SKScene(fileNamed: "GameScene") 寻找的是 GameScene.sks 文件
       
       */
      
      let scene = GameScene(size:view.bounds.size)
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        // Present the scene
        view.presentScene(scene)
      
      
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
    }
  }
  
 
}

