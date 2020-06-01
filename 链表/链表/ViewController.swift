//
//  ViewController.swift
//  链表
//  https://www.cnblogs.com/rayshen/p/5145861.html
//  Created by 段雨田 on 2020/5/29.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }

  @IBAction func magician(_ sender: Any) {
    
     let svc:MagicianVC = (storyboard?.instantiateController(identifier: "magicianVC"))! as MagicianVC
     self.presentAsModalWindow(svc);
    
  }
  
}

