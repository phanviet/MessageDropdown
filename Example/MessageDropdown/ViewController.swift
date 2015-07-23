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
    MessageDropdown.addDelegate(MessageDropdownCallback())
    MessageDropdown.textAlignment = NSTextAlignment.Justified
    MessageDropdown.setMessageDropdownColorFor(.Danger, backgroundColor: UIColor.redColor(), textColor: nil)
    MessageDropdown.paddingTop = 32.0
    MessageDropdown.show("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod" +
      "tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam," +
      "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
    )
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func message() -> String {
    return "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod" +
        "tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam," +
        "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo"
  }
  
  private func toggleMessage(message: String, type: MessageDropdownType) {
    MessageDropdown.show(message, type: type)
  }
  
  @IBAction func toggleDangerMessage(sender: AnyObject) {
    toggleMessage(message(), type: .Danger)
  }
  
  @IBAction func toggleWarningMessage(sender: AnyObject) {
    toggleMessage(message(), type: .Warning)
  }
  @IBAction func toggleSuccessMessage(sender: AnyObject) {
    toggleMessage(message(), type: .Success)
  }
  @IBAction func toggleInfoMessage(sender: AnyObject) {
    toggleMessage(message(), type: .Info)
  }

  @IBAction func toggleDefaultMessage(sender: AnyObject) {
    toggleMessage(message(), type: .Default)
  }
  @IBAction func autoDismiss(sender: AnyObject) {
    MessageDropdown.isAutoDismiss = true
  }
  @IBAction func offAutoDismiss(sender: AnyObject) {
    MessageDropdown.isAutoDismiss = false
  }
}

