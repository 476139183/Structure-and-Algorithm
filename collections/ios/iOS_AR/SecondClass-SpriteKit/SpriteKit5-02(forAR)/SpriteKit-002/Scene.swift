//
//  Scene.swift
//  SpriteKit-002
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import SpriteKit
import ARKit

class Scene: SKScene {
  
  var playing = false
  
  //! 积分器
  var sorce = 0
  //! 计时器
  var BombTimer:Timer?
  
  override func didMove(to view: SKView) {
    // Setup your scene here
  }
  
  override func update(_ currentTime: TimeInterval) {
    // Called before each frame is rendered
  }
  
  
  func displayMenu() {
    //!
    let logoLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    logoLabel.fontSize = 50.0
    
    logoLabel.text = "Game Over!"
    logoLabel.verticalAlignmentMode = .center
    logoLabel.horizontalAlignmentMode = .center
    
    logoLabel.position = CGPoint.init(x: frame.midX, y: frame.midY + logoLabel.frame.size.height)
    
    logoLabel.name = "Menu"
    
    self.addChild(logoLabel)
    
    
    let infoLabel = SKLabelNode(fontNamed: "AvenirNext-Bold")
    infoLabel.fontSize = 50.0
    infoLabel.text = "你死了！！"
    infoLabel.verticalAlignmentMode = .center
    infoLabel.horizontalAlignmentMode = .center
    infoLabel.position = CGPoint.init(x: frame.midX, y: frame.midY - infoLabel.frame.size.height)
    infoLabel.name = "Menu"
    self.addChild(infoLabel)

    //! 最高分
    let hightScore = SKLabelNode(fontNamed: "AvenirNext-Bold")
    hightScore.fontSize = 50.0
    hightScore.text = "最高分：\(UserDefaults.standard.integer(forKey: "HightScore"))"
    hightScore.verticalAlignmentMode = .center
    hightScore.horizontalAlignmentMode = .center
    hightScore.position = CGPoint.init(x: frame.midX, y: infoLabel.frame.midY - hightScore.frame.size.height * 2)
    hightScore.name = "Menu"
    self.addChild(hightScore)
    
  }
  
  
  //! 炸弹
  func addBomb() {
    //! 判断是不是 ARSKView
    guard let sceneView = self.view as? ARSKView else {
      return
    }
    
    //! 判断镜头位置
    if let currentFrame = sceneView.session.currentFrame {
      
      //! 随机位置
      let xOffset = Float(arc4random_uniform(UInt32(30))) / 10 - 1.5
      let zOffset = Float(arc4random_uniform(UInt32(30))) / 10 + 0.5
      
      
      var transform = matrix_identity_float4x4
      transform.columns.3.x = currentFrame.camera.transform.columns.3.x - xOffset
      transform.columns.3.z = currentFrame.camera.transform.columns.3.z - zOffset
      transform.columns.3.y = currentFrame.camera.transform.columns.3.y
      
      let anchor = ARAnchor.init(transform: transform)
      sceneView.session.add(anchor:anchor)
      
    }
    
    BombTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(explode), userInfo: nil, repeats: false)
    
  }
  
  
  //! 爆炸
  @objc func explode() {
    BombTimer?.invalidate()
    
    //! 统计分数,找一下缓存中的最高分
    if UserDefaults.standard.integer(forKey: "HightScore") < sorce {
      UserDefaults.standard.set(sorce, forKey: "HightScore")
      
      
    }
    
    for node in children {
      if let node = node as? SKLabelNode,node.name == "Bomb" {
        node.text = "💥"
        node.name = "Menu"
        //! 放大动画
        let scaleExplode = SKAction.scale(to: 50, duration: 1.0)
        node.run(scaleExplode) {
          self.displayMenu()
        }
      }

      
    }
    
  }
  
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    if !playing {
      playing = true
      //! 遍历子节点,移除旧的炸弹，放入新的炸弹
      
      for label in children {
        label.removeFromParent()
      }
      
      addBomb()
      
    } else {
      //! 正在游戏中,判断是不是第一次触摸
      guard let location = touches.first?.location(in: self) else {
        return
      }
      
      //! 查看所有的子节点 是否在视野范围
      for node in children {
        //! 如果点击了炸弹节点
        if node.contains(location),node.name == "Bomb" {
          
          //! 分数+1
          sorce += 1
          //! 暂停计时
          BombTimer?.invalidate()

          
          ///! 0.5秒
          let fadeOut = SKAction.fadeOut(withDuration: 0.5)
          node.run(fadeOut) {
            ///! 移除炸弹
            node.removeFromParent()
            //! 创建一个新的炸弹
            self.addBomb()
          }
          
          
        }
        
      }
      
      
    }
    
    
  }
}

