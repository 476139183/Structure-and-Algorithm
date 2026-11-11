//
//  ARViewController.swift
//  AR_Demo_5
//
//  Created by Yutian Duan on 2020/5/13.
//  Copyright © 2020年 Lingzhu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController,ARSCNViewDelegate {
  
  var arSCNView : ARSCNView!
  let arSession = ARSession.init()
  var arSessionConfiguration : ARConfiguration!
  
  ///! 地球 月亮 太阳 节点
  let sunNode = SCNNode.init()
  let moonNode = SCNNode.init()
  let earthNode = SCNNode.init()

  //! 月亮和地球的节点，绑定一起，围绕太阳转
  let earthGroupNode = SCNNode.init()
  
  //! 光晕
  let sunHaloNode = SCNNode.init()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    arSCNView = ARSCNView.init(frame: self.view.bounds)
    arSCNView.session = arSession
    arSCNView.automaticallyUpdatesLighting = true
    
    arSCNView.delegate = self
    arSCNView.showsStatistics = true

    self.view.addSubview(arSCNView)
  
    ///! 初始化节点
    initNodes()


  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let configuration = ARWorldTrackingConfiguration()
    arSessionConfiguration = configuration
    ///! 自适应灯光
    arSessionConfiguration.isLightEstimationEnabled = true
    
    arSession.run(arSessionConfiguration, options: [.resetTracking,.removeExistingAnchors])
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Pause the view's session
    arSession.pause()
  }
  
  
  func initNodes() {
    
    //! 渲染节点 几何
    sunNode.geometry = SCNSphere.init(radius: 3)
    moonNode.geometry = SCNSphere.init(radius: 0.5)
    earthNode.geometry = SCNSphere.init(radius: 1.0)

    //!
    /*    multiply: 镶嵌，把图片拉伸之后，变淡
     *    diffuse : 扩散，平均扩散到表面，光泽较深
     *   为了图片更丰满，可以设置 multiply
     */
    sunNode.geometry?.firstMaterial?.multiply.contents = "art.scnassets/earth/sun.jpg"
    sunNode.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/earth/sun.jpg"

    //! 月亮
    moonNode.geometry?.firstMaterial?.multiply.contents = "art.scnassets/earth/moon.jpg"
    moonNode.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/earth/moon.jpg"

    
    //! 地球
    earthNode.geometry?.firstMaterial?.multiply.contents = "art.scnassets/earth/earth-diffuse-mini.jpg"
    earthNode.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/earth/earth-diffuse-mini.jpg"
    /* 背光图
     *
     */
    earthNode.geometry?.firstMaterial?.emission.contents = "art.scnassets/earth/earth-emissive-mini.jpg"
    earthNode.geometry?.firstMaterial?.specular.contents = "art.scnassets/earth/earth-specular-mini.jpg"

    //! 强度
    sunNode.geometry?.firstMaterial?.multiply.intensity = 0.5
    sunNode.geometry?.firstMaterial?.lightingModel = .constant
    
    /* wrapS: 从左到右
       wrapT: 从上到下
     */
    sunNode.geometry?.firstMaterial?.multiply.wrapS = .repeat
    sunNode.geometry?.firstMaterial?.diffuse.wrapS = .repeat
    sunNode.geometry?.firstMaterial?.multiply.wrapT = .repeat
    sunNode.geometry?.firstMaterial?.diffuse.wrapT = .repeat
    //! 位置
    sunNode.position = SCNVector3Make(0, 5, -20)
    
    //
    arSCNView.scene.rootNode.addChildNode(sunNode)
   
    addAnimationToSun()
    
    // 地球光泽
    earthNode.geometry?.firstMaterial?.shininess = 0.1
    ///! 反射光的强度
    earthNode.geometry?.firstMaterial?.specular.intensity = 0.5
    //! 地球位置,以 地月节点为参考系
    earthNode.position = SCNVector3Make(3, 0, 0)
    
    //!TODO: 月球的反射光颜色,镜面反射光颜色
    moonNode.geometry?.firstMaterial?.specular.contents = UIColor.red
    
    
    ///! 地月节点
    earthGroupNode.addChildNode(earthNode)
    earthGroupNode.addChildNode(moonNode)
    ///! 地月节点位置
    earthGroupNode.position = SCNVector3Make(10, 0, 0)
    
    addAnimationRoation()
    addAnimationRoation()
    addLight()
    
  }
  
  //! 太阳自转动画
  func addAnimationToSun() {
    
    let animation = CABasicAnimation.init(keyPath: "contentsTransform")
    animation.duration = 10.0
    animation.repeatCount = 10000

    animation.fromValue = CATransform3DConcat(CATransform3DMakeTranslation(0, 0, 0), CATransform3DMakeScale(3, 3, 3))
    
    animation.toValue = CATransform3DConcat(CATransform3DMakeTranslation(1, 0, 0), CATransform3DMakeScale(5, 5, 5))
    
    sunNode.geometry?.firstMaterial?.diffuse.addAnimation(animation, forKey: "sun-texture")
    
  }
  
  //! 公转动画
  func addAnimationRoation() {
    
    //! 地球自转动画
    earthNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
    
    //! 月球自转的动画
    let animation = CABasicAnimation.init(keyPath: "rotation")
    animation.duration = 1.5
    animation.toValue = SCNVector4Make(0, 1, 0, Float.pi*2)
    animation.repeatCount = 10000
    moonNode.addAnimation(animation, forKey: "moon-rotation")

    
    //! 月球围绕地球转节点
    let moonRotationNode = SCNNode.init()
    moonRotationNode.addChildNode(moonNode)
    
   
    //! 月球围绕地球转的动画
    let moonRotationAnimation = CABasicAnimation.init(keyPath: "rotation")
    moonRotationAnimation.duration = 5.0
    moonRotationAnimation.toValue = SCNVector4Make(0, 1, 0, Float.pi*2)
    moonRotationAnimation.repeatCount = 10000
    moonRotationNode.addAnimation(moonRotationAnimation,forKey: "moon-rotationAround-earth")

    //! 地球围绕太阳转,黄道
    let earthRotationNode = SCNNode.init()
    sunNode.addChildNode(earthRotationNode)
    
    earthGroupNode.addChildNode(moonRotationNode)
    ///! 将地月节点 加入到 黄道。
    earthRotationNode.addChildNode(earthGroupNode)
    
    
    ///! 地球公转动画
    let earthRotation = CABasicAnimation.init(keyPath: "rotation")
    earthRotation.duration = 5.0
    earthRotation.toValue = SCNVector4Make(0, 1, 0, Float.pi*2)
    earthRotation.repeatCount = 10000
    earthRotationNode.addAnimation(earthRotation, forKey: "earth-rotationAround-sun")
    
  }
  
  func addLight() {
    
    let lightNode = SCNNode.init()
    lightNode.light = SCNLight.init()
    lightNode.light?.color = UIColor.red
    sunNode.addChildNode(lightNode)
    
    //!
    lightNode.light?.attenuationEndDistance = 20.0
    lightNode.light?.attenuationStartDistance = 1.0
    
    SCNTransaction.begin()
    SCNTransaction.animationDuration = 1
    
    //!
    lightNode.light?.color = UIColor.white
    sunHaloNode.opacity = 0.5
    
    SCNTransaction.commit()
    
    sunHaloNode.geometry = SCNPlane.init(width: 25, height: 25)
    sunHaloNode.rotation = SCNVector4Make(1, 0, 0, 0 * Float.pi / 180.0)
    sunHaloNode.geometry?.firstMaterial?.diffuse.contents = "art.scnassets/earth/sun-halo.png"
    
    sunHaloNode.geometry?.firstMaterial?.lightingModel = .constant
    sunHaloNode.geometry?.firstMaterial?.writesToDepthBuffer = false
    sunHaloNode.opacity = 0.9
    sunNode.addChildNode(sunHaloNode)

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
