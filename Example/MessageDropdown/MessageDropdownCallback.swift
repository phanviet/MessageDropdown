//
//  CustomMessageDropdown.swift
//  MessageDropdown
//
//  Created by Viet Phan on 7/23/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import Foundation
import MessageDropdown

class MessageDropdownCallback: NSObject {

}

extension MessageDropdownCallback: MessageDropdownDelegate {

  func beforeMessageShow(messageDropdown: MessageDropdown) {
    println("@ before message show")
  }
  
  func afterMessageShow(messageDropdown: MessageDropdown) {
    println("@ after message show")
  }
  
  func beforeMessageHide(messageDropdown: MessageDropdown) {
    println("@ before message hide")
  }
  
  func afterMessageHide(messageDropdown: MessageDropdown) {
    println("@ after message hide")
  }
}