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
  
  override func didMove(to view: SKView) {
    //! 移动即自动调用
    addChild(myFirstNode)
    
    mySpriteNode.position = CGPoint.init(x: frame.midX, y: frame.midY)
    mySpriteNode.anchorPoint = CGPoint.zero
    addChild(mySpriteNode)
    
    myTextureSpriteNode.size = CGSize.init(width: 100, height: 100)
    mySpriteNode.addChild(myTextureSpriteNode)
    
    
  }
  
  
  
}
