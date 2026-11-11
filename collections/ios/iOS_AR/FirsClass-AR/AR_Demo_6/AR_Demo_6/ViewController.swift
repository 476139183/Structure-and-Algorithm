//
//  ViewController.swift
//  AR_Demo_6
//
//  Created by Yutian Duan on 2020/5/15.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {
  
  @IBOutlet weak var mySceneView: ARSCNView!
  
  @IBOutlet weak var infoLabel: UILabel!
  
  @IBOutlet weak var targetImageView: UIImageView!
  
  
  var session = ARSession()
  var configuration = ARWorldTrackingConfiguration()
  //! 默认测量状态是关闭的
  var isMeasuring = false
  // 0,0,0
  var vectorZero = SCNVector3()
  var vectorStart = SCNVector3()
  var vectorEnd = SCNVector3()
  var lines = [Line]()
  var currentLine: Line?
  //! 默认单位是cm
  var unit = LengthUnit.cenitMeter
    
  override func viewDidLoad() {
    
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //! 移除所有锚点，重新全局追踪
    session.run(configuration, options: [.resetTracking,.removeExistingAnchors])
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    session.pause()
  }
  
  func setup() {
    mySceneView.delegate = self
    mySceneView.session = session
    infoLabel.text = "初始化环境"
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
   
    
    if !isMeasuring {
      print("点击屏幕 开始测量")
      reset()
      isMeasuring = true
      targetImageView.image = UIImage.init(named: "green")
      
    } else {
      print("点击屏幕 完成测量")
      isMeasuring = false
      
      if let line = currentLine {
        lines.append(line)
        currentLine = nil
        targetImageView.image = UIImage.init(named: "white")
      }
      
    }
    
  }
  
  
  @IBAction func resetClick(_ sender: Any) {
    
    for line in lines {
      line.remove()
    }
    
    lines.removeAll()
    
    
    
  }
  
  @IBAction func unitClick(_ sender: Any) {
    
    
  }
  
  
  func reset () {
    
    isMeasuring = true
    
    vectorStart = SCNVector3()
    vectorEnd = SCNVector3()
  }
  
  
  //! 开始测量
  func sceneWorld () {
    //!  捕获当前屏幕的中心位置
    guard let worldPosition = mySceneView.worldVector(for: view.center) else {
      return
    }
    
    //! 如果没有线条
    if lines.isEmpty {
      infoLabel.text = "再点击一次屏幕"
    }
    
    if isMeasuring {
      //! 已经进入测量状态， 设置开始节点
      if vectorStart == vectorZero {
        //! 将当前位置 设置为 初始位置
        vectorStart = worldPosition
        
        currentLine = Line(sceneView: mySceneView, startVector: vectorStart, unit: unit)
    
      }
      
      //! 设置结束的节点
      vectorEnd = worldPosition
      currentLine?.update(to: vectorEnd)
      
      infoLabel.text = currentLine?.distance(to: vectorEnd) ?? "..."
      
      
    }
    
    
    
  }
  
}


extension ViewController: ARSCNViewDelegate {
  
  
  //!  当屏幕实时更新的时候
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    
    DispatchQueue.main.async {
      self.sceneWorld()
    }
    
  }
  

  func session(_ session: ARSession, didFailWithError error: Error) {
    infoLabel.text = "错误"
  }
  
  func sessionWasInterrupted(_ session: ARSession) {
    infoLabel.text = " 中断了"
  }
  
  func sessionInterruptionEnded(_ session: ARSession) {
    infoLabel.text = "结束了"
  }

  
  
}
