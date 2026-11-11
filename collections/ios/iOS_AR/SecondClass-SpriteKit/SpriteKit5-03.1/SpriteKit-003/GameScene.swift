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

  }
  
  //! 连续点击，旋转变快，移动卡顿
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
  
    //! 移动动画
//    myTextureSpriteNode.run(SKAction.move(to: CGPoint.init(x: mySpriteNode.frame.size.width, y: mySpriteNode.frame.size.height), duration: 2.0))
    
    //! 单次旋转
//    blueBox.run(SKAction.rotate(byAngle: CGFloat.pi, duration: 2.0))
    
    self.myTextureSpriteNode.position = CGPoint.zero
    
    
    if !blueBox.hasActions() {
      
      //! 1. 无限循环
      //  blueBox.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi, duration: 2.0)))
      
      //! 2. 组合动画，同时旋转，变小
      // blueBox.run(SKAction.group([SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi, duration: 2.0)),SKAction.scale(by: 0.9, duration: 2.0)]))
      
      //! 3. 先执行旋转 再变小
      blueBox.run(SKAction.sequence([SKAction.rotate(byAngle: CGFloat.pi, duration: 2.0),SKAction.scale(by: 0.9, duration: 2.0)]))
      
    } else {
      //! 停止
      blueBox.removeAllActions()
    }
    
    
    if let _ = myTextureSpriteNode.action(forKey: "Rotation") {
      myTextureSpriteNode.removeAction(forKey: "Rotation")
    } else {
      
      myTextureSpriteNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat.pi, duration: 2.0)), withKey: "Rotation")
      
    }
    
    
  }
  
  
}
