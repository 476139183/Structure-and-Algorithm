//
//  myScene.swift
//  SpriteKit-001
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import SpriteKit

class myScene: SKScene {
  
  
  override func didMove(to view: SKView) {
    //! 对屏幕任意拖动就会调用这个方法
    self.backgroundColor = UIColor.blue
    
    let mySprite = SKSpriteNode.init(imageNamed: "felpudo2")
    mySprite.position = CGPoint.init(x: 100, y: 100)
    self.addChild(mySprite)
    
  }
  
  

}
