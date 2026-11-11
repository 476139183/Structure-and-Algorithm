//
//  GameScene.swift
//  SpriteKit-003
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
  
  
  let myFirstNode = SKNode()
  
  let mySpriteNode = SKSpriteNode(color: UIColor.red, size: CGSize(width: 200, height: 200))
  
  let myTextureSpriteNode = SKSpriteNode.init(imageNamed: "Spaceship")
  
  let blueBox = SKSpriteNode.init(color: .blue, size: CGSize.init(width: 100.0, height: 100.0))
  
  //! 移动即自动调用
  override func didMove(to view: SKView) {
    
    addChild(myFirstNode)
    
    mySpriteNode.position = CGPoint.init(x: frame.midX, y: frame.midY)
    mySpriteNode.anchorPoint = CGPoint.zero
    addChild(mySpriteNode)
    
    myTextureSpriteNode.size = CGSize.init(width: 100.0, height: 100.0)
    myTextureSpriteNode.zPosition = 3
    mySpriteNode.addChild(myTextureSpriteNode)

    //! 类似js的 层级，越大，越在上面
    blueBox.zPosition = 2;
    blueBox.position = CGPoint.init(x: mySpriteNode.frame.size.width/2, y: mySpriteNode.frame.size.height/2)
    mySpriteNode.addChild(blueBox)
    
    
    /* ! 修改重力的方向, 都偏向X和Y的负轴，合力，变成左边下
     *
     */
    physicsWorld.gravity = CGVector(dx: -1.0, dy: -1.0)

    //! 设置边界
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    
    //! 物理引擎
    myTextureSpriteNode.physicsBody = SKPhysicsBody.init(circleOfRadius: myTextureSpriteNode.size.width/2)
    
    ///! 运行碰撞的时候，是否能旋转
    myTextureSpriteNode.physicsBody?.allowsRotation = false
    
    //!  0~1，默认0.2，每次碰撞损失的动能
    myTextureSpriteNode.physicsBody?.restitution = 1.0
    
  }
  
  //! 连续点击，旋转变快，移动卡顿
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
    
  }
  
  
}
