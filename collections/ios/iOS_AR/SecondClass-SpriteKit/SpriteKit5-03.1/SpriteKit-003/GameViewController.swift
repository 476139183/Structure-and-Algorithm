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
 
 
 ignoresSiblingOrder：判別相同位置的两个 node 他们是否并存 默认是不并存的 = false 如果改成 true  那么都可以看到，俺么假设说 在 true 情況下，我們想要遮住他们的话，可以修改他们的 zPosition 数字比较大的会在上面

 
 SKACtion:
 
 runAction: 执行动作
 runActionWithKey: 执行动作并且分配一个 key
 runActionComlietion: 添加完成处理程序
 

 集体的动作
 Sequence: 子操作在另一个操作之后來运行
 Group: 子操作跟他同时运行
 Repeat: 子操作运行一定或无限的循环操作
 
 hasAction: 当物件本身有操作的时候，我才进行子操作
 
 PhysicsWorld:
 
 将重力 定义为 CGVector
 
 SKPhyicsBody: 基于我们的物件所具有质量和体积的动态体

 
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
      
      //! false 则无法同时渲染两个重叠的子节点部分
      view.ignoresSiblingOrder = true
      
      view.showsFPS = true
      view.showsNodeCount = true
      
      
    }
  }
  
 
}

