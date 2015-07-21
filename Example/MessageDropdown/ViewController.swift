//
//  ViewController.swift
//  MessageDropdown
//
//  Created by Viet Phan on 07/21/2015.
//  Copyright (c) 2015 Viet Phan. All rights reserved.
//

import UIKit
import MessageDropdown

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewDidAppear(animated: Bool) {
    MessageDropdown.show()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}

