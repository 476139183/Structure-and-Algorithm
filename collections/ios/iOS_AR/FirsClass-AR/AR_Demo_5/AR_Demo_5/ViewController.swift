//
//  ViewController.swift
//  AR_Demo_5
//
//  Created by Yutian Duan on 2020/5/13.
//  Copyright © 2020年 Lingzhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func enterARVC(_ sender: Any) {
    
    let vc = ARViewController()
    
    self.present(vc, animated: true, completion: nil)
    
    
  }
  
}

