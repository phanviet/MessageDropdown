//
//  MessageDropdown.swift
//  Pods
//
//  Created by Viet Phan on 7/21/15.
//
//

import UIKit

@IBDesignable
public class MessageDropdown: UIView {

  static private let instance = MessageDropdown(frame: CGRectZero)
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required public init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  public class func show() {
    instance.frame.size.height = 100
  }
}


extension MessageDropdown {
  private class func window() -> UIWindow {
    return UIApplication.sharedApplication().keyWindow!
  }
}