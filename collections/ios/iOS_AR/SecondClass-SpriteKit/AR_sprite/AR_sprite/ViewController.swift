//
//  ViewController.swift
//  AR_sprite
//
//  Created by Yutian Duan on 2020/5/17.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import ARKit


enum BitMaskCategory : Int {
  case bullet = 2
  case target = 3
}


class ViewController: UIViewController, SCNPhysicsContactDelegate {
  
  @IBOutlet weak var sceneView: ARSCNView!
  
  //! 碰撞之后的结果节点
  var Target : SCNNode?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  
    /*
     * ARSCNDebugOptions.showWorldOrigin 画面中出现三维
     * ARSCNDebugOptions.showFeaturePoints     出现 特征点，
     */
    sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin,ARSCNDebugOptions.showFeaturePoints]
    
    //! 判断，视图中，是否要更新 sceneKit 的灯光
    sceneView.automaticallyUpdatesLighting = true
    
    
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let configuartion = ARWorldTrackingConfiguration()
    sceneView.session.run(configuartion)
    
    let getureRecongnizer = UITapGestureRecognizer.init(target: self, action: #selector(handleTap(sander:)))
    self.sceneView.addGestureRecognizer(getureRecongnizer)
    
    sceneView.scene.physicsWorld.contactDelegate = self
    
  }
  
  
  @objc func  handleTap(sander: UITapGestureRecognizer) {
    
    //! 判断是否是 ARSCNView
    guard let csceneView = sander.view as? ARSCNView else {
      return
    }
    
    guard let pointOfView = csceneView.pointOfView else {
      return
    }
    
    let transform = pointOfView.transform
    
    //! 物件方向
    let oriectation = SCNVector3(-transform.m31,-transform.m32,-transform.m33)
    
    //! 本地方向
    let location = SCNVector3(-transform.m41,-transform.m42,-transform.m43)
    
    //! 得到子弹要射向的位置
    let position = oriectation + location
    
    let bullet = SCNNode.init(geometry: SCNSphere.init(radius: 0.1))
    
    bullet.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    
    bullet.position = position
    
    //! physicBody
    let body = SCNPhysicsBody.init(type: .dynamic, shape: SCNPhysicsShape.init(node: bullet, options: nil))
    
    bullet.physicsBody = body
    
    /* 线性向前,向量代表方向和速度
     
     bullet.physicsBody?.applyForce(oriectation, asImpulse: true)
     
     */
    bullet.physicsBody?.applyForce(SCNVector3Make(oriectation.x * 50, oriectation.y * 50, oriectation.z * 50), asImpulse: true)
    
    //! 无视重力， 防止子弹掉下去
    body.isAffectedByGravity = false
    
    //! 设置子弹的物理特性，这样才会调用代理
    bullet.physicsBody?.categoryBitMask = BitMaskCategory.bullet.rawValue
    
    ///! 碰撞检测之后，这样才会调用代理
    bullet.physicsBody?.contactTestBitMask = BitMaskCategory.target.rawValue
    
    sceneView.scene.rootNode.addChildNode(bullet)
    
    
  }
  
  //! SCNPhysicsContactDelegate
  /*
   *
   */
  func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
    //! 射击一次，碰撞后，会调用4次。一颗子弹，3个鸡蛋，检测到4个物体性质
    print("物理性质被调用了")
    //! A B 表示碰撞的两个物体,A 表示 第一响应节点， B表示第二响应节点
    let nodeA = contact.nodeA
    let nodeB = contact.nodeB
    
    //! 碰撞之后的，留下的mask 类型
    if nodeA.physicsBody?.contactTestBitMask == BitMaskCategory.bullet.rawValue {
      //! 与设置的一一对应，这边表示第一响应的 碰撞mask为子弹，所以节点是鸡蛋
      self.Target = nodeA
    } else if nodeB.physicsBody?.contactTestBitMask == BitMaskCategory.bullet.rawValue {
      self.Target = nodeB
    }
    
    
    // SceneKit Particle System File
    
    let confetti = SCNParticleSystem.init(named: "art.scnassets/comfetti.scnp", inDirectory: nil)
    
    confetti?.loops = false
    confetti?.particleLifeSpan = 4.0
    //! 几何效果
    confetti?.emitterShape = Target?.geometry
    
    let confettiNode = SCNNode()
    //! 添加特效
    confettiNode.addParticleSystem(confetti!)
    //! 作用点的坐标赋值给新节点，也就是两个node 碰撞的点
    confettiNode.position = contact.contactPoint
    
    self.sceneView.scene.rootNode.addChildNode(confettiNode)
    
    Target?.removeFromParentNode()
    
    
  }
  
  
  
  
  @IBAction func addTagert(_ sender: Any) {
    

    addEggs(x: 5, y: 0, z: -40)
    addEggs(x: 0, y: 0, z: -40)
    addEggs(x: -5, y: 0, z: -40)

  }
  
  //! 加入蛋
  func addEggs(x:Float,y:Float,z:Float) {
    
    let eggscene = SCNScene.init(named: "art.scnassets/egg.scn")
    
    let eggNode = eggscene?.rootNode.childNode(withName: "egg", recursively: false)
    eggNode?.position = SCNVector3.init(x: x, y: y, z: z)
    
    
    /*
     表示碰到鸡蛋的都会弹开,但是边角是不会有反应
     eggNode?.physicsBody = SCNPhysicsBody.static()
     表示碰到鸡蛋的都会弹开，边角也会弹开
     eggNode?.physicsBody = SCNPhysicsBody.init(type: .static, shape: SCNPhysicsShape.init(node: eggNode!, options: nil))
     
     */
    eggNode?.physicsBody = SCNPhysicsBody.init(type: .static, shape: SCNPhysicsShape.init(node: eggNode!, options: nil))
    
    //! 设置鸡蛋的的物理特性，这样才会调用代理
    eggNode?.physicsBody?.categoryBitMask = BitMaskCategory.target.rawValue
    eggNode?.physicsBody?.contactTestBitMask = BitMaskCategory.bullet.rawValue

    
    sceneView.scene.rootNode.addChildNode(eggNode!)
    
  }
  
  
}

///!
func + (left:SCNVector3,right:SCNVector3) ->SCNVector3 {
  return SCNVector3Make(left.x+right.x, left.y+right.y, left.z+right.z)
}
