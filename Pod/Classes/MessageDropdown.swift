//
//  MessageDropdown.swift
//  Pods
//
//  Created by Viet Phan on 7/21/15.
//
//

import UIKit

@objc public protocol MessageDropdownDelegate {
  
  // Callback before message show
  optional func beforeMessageShow(messageDropdown: MessageDropdown)
  
  // Callback after message show
  optional func afterMessageShow(messageDropdown: MessageDropdown)
  
  // Callback before message hide
  optional func beforeMessageHide(messageDropdown: MessageDropdown)
  
  // Callback after message hide
  optional func afterMessageHide(messageDropdown: MessageDropdown)
}

public enum MessageDropdownType {
  case Default, Info, Success, Warning, Danger
}

struct MessageDropdownColor {
  var backgroundColor = UIColor.clearColor()
  var textColor = UIColor.blackColor()
}

public class MessageDropdown: UIView {

  static private let instance = MessageDropdown(frame: CGRectZero)
  private var topConstraint: NSLayoutConstraint!
  private var heightConstraint: NSLayoutConstraint!
  private var leadingConstraint: NSLayoutConstraint!
  private var trailingConstraint: NSLayoutConstraint!
  private var messageLabel: UILabel!
  private let config = MessageDropdownConfig()
  private var delegates = [MessageDropdownDelegate]()
  private var upTimer: NSTimer?
  
  static public var isAutoDismiss: Bool! {
    didSet {
      instance.config.isAutoDismiss = MessageDropdown.isAutoDismiss
      if !instance.config.isAutoDismiss! {
        instance.stopUpTimer()
      }
    }
  }
  
  static public var dismissTimer: Double! {
    didSet {
      instance.config.dismissTimer = MessageDropdown.dismissTimer
    }
  }
  
  static public var paddingLeft: CGFloat! {
    didSet {
      instance.config.paddingLeft = MessageDropdown.paddingLeft
    }
  }
  
  static public var paddingRight: CGFloat! {
    didSet {
      instance.config.paddingRight = MessageDropdown.paddingRight
    }
  }
  
  static public var paddingTop: CGFloat! {
    didSet {
      instance.config.paddingTop = MessageDropdown.paddingTop
    }
  }
  
  static public var paddingBottom: CGFloat! {
    didSet {
      instance.config.paddingBottom = MessageDropdown.paddingBottom
    }
  }
  
  static public var textColor: UIColor! {
    didSet {
      instance.config.textColor = MessageDropdown.textColor
      instance.messageLabel.textColor = instance.config.textColor
    }
  }
  
  static public var font: UIFont! {
    didSet {
      instance.config.font = MessageDropdown.font
      instance.messageLabel.font = instance.config.font
    }
  }
  
  static public var textAlignment: NSTextAlignment! {
    didSet {
      instance.config.textAlignment = MessageDropdown.textAlignment
      instance.messageLabel.textAlignment = instance.config.textAlignment
    }
  }
  
  static public var animationDelay: NSTimeInterval! {
    didSet {
      instance.config.animationDelay = MessageDropdown.animationDelay
    }
  }
  
  static public var animationDuration: NSTimeInterval! {
    didSet {
      instance.config.animationDuration = MessageDropdown.animationDuration
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  deinit {
    stopUpTimer()
  }
  
  private func stopUpTimer() {
    upTimer?.invalidate()
    upTimer = nil
  }
  
  private func scheduleUpTimer(after: Double) {
    stopUpTimer()
    upTimer = NSTimer.scheduledTimerWithTimeInterval(after, target: self, selector: "upFromTimer:", userInfo: nil, repeats: false)
  }
  
  func upFromTimer(timer: NSTimer) {
    MessageDropdown.hide()
  }
  
  // Get or init message label
  private func initMessageLabel() {
    if messageLabel == nil {
      messageLabel = UILabel(frame: CGRectZero)
    }
  }
  
  public class func setMessageDropdownColorFor(type: MessageDropdownType, backgroundColor: UIColor?, textColor: UIColor?) {
    let defaultColor = instance.config.colorForType[type]
    var color = MessageDropdownColor()
    color.backgroundColor = backgroundColor ?? defaultColor!.backgroundColor
    color.textColor = textColor ?? defaultColor!.textColor
    instance.config.colorForType[type] = color
  }
  
  // Setup frame and constraints
  private func initFrameAndConstraints() {
    let screenBounds = UIScreen.mainScreen().bounds
    frame.size.width = screenBounds.width
    
    let window = MessageDropdown.window()
    
    topConstraint = NSLayoutConstraint(
      item: self,
      attribute: NSLayoutAttribute.Top,
      relatedBy: NSLayoutRelation.Equal,
      toItem: window,
      attribute: NSLayoutAttribute.Top,
      multiplier: 1.0,
      constant: 0.0
    )
    
    leadingConstraint = NSLayoutConstraint(
      item: self,
      attribute: NSLayoutAttribute.Leading,
      relatedBy: NSLayoutRelation.Equal,
      toItem: window,
      attribute: NSLayoutAttribute.Leading,
      multiplier: 1.0,
      constant: 0.0
    )
    
    heightConstraint = NSLayoutConstraint(
      item: self,
      attribute: NSLayoutAttribute.Height,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.Height,
      multiplier: 1.0,
      constant: 0.0
    )
    
    trailingConstraint = NSLayoutConstraint(
      item: window,
      attribute: NSLayoutAttribute.Trailing,
      relatedBy: NSLayoutRelation.Equal,
      toItem: self,
      attribute: NSLayoutAttribute.Trailing,
      multiplier: 1.0,
      constant: 0.0
    )
    
    if !messageLabel.isDescendantOfView(self) {
      self.addSubview(messageLabel)
    }
    if !isDescendantOfView(window) {
      window.addSubview(self)
    }
    
    translatesAutoresizingMaskIntoConstraints = false
    
    window.addConstraint(topConstraint)
    window.addConstraint(leadingConstraint)
    window.addConstraint(trailingConstraint)
    addConstraint(heightConstraint)
  }
  
  // Setup UI
  private func initUI() {
    messageLabel.textColor = UIColor.whiteColor()
    messageLabel.font = config.font
    messageLabel.textAlignment = config.textAlignment
    messageLabel.numberOfLines = 0
    messageLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
  }
  
  // Setup message label frame
  private func initMessageLabelFrame() {
    messageLabel.frame.size.width = frame.size.width
  }
  
  private func setup() {
    initMessageLabel()
    initFrameAndConstraints()
    initUI()
    initMessageLabelFrame()
    
    let tapRecognizer = UITapGestureRecognizer(target: self, action: "hide")
    self.addGestureRecognizer(tapRecognizer)
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public class func addDelegate(delegate: MessageDropdownDelegate) {
    instance.delegates.append(delegate)
  }
  
  public class func removeDelegate(index: Int) {
    instance.delegates.removeAtIndex(index)
  }
  
  private class func hideFrameWithText(message: String) {
    instance.messageLabel.frame.origin.x = instance.config.paddingLeft
    instance.messageLabel.frame.size.width = instance.frame.size.width - (instance.config.paddingLeft + instance.config.paddingRight)
    instance.messageLabel.text = message
    instance.messageLabel.sizeToFit()
    instance.heightConstraint.constant = instance.messageLabel.frame.size.height + (instance.config.paddingTop + instance.config.paddingBottom)
    instance.topConstraint.constant = -instance.heightConstraint.constant
    instance.messageLabel.frame.origin.y = instance.config.paddingTop
    
    instance.layoutIfNeeded()
  }
  
  private func backgroundColorForType(type: MessageDropdownType) -> UIColor {
    return config.colorForType[type]!.backgroundColor
  }
  
  private func textColorForType(type: MessageDropdownType) -> UIColor {
    return config.colorForType[type]!.textColor
  }
  
  func hide() {
    if config.isAutoDismiss! {
      stopUpTimer()
    }
    MessageDropdown.hide()
  }
}

// MARK: - Action for Message Dropdown
extension MessageDropdown {

  public class func show(message: String) {
    MessageDropdown.show(message, type: .Default)
  }

  public class func show(message: String, type: MessageDropdownType) {
    if self.instance.config.isAutoDismiss! {
      self.instance.stopUpTimer()
    }

    instance.backgroundColor = instance.backgroundColorForType(type)
    instance.messageLabel.textColor = instance.textColorForType(type)
    MessageDropdown.hideFrameWithText(message)
    
    for i in 0..<instance.delegates.count {
      instance.delegates[i].beforeMessageShow?(instance)
    }

    dispatch_async(dispatch_get_main_queue()) {
      UIView.animateWithDuration(instance.config.animationDuration,
        delay: instance.config.animationDelay,
        options: UIViewAnimationOptions.CurveEaseOut,
        animations: { () -> Void in
          self.instance.topConstraint.constant = 0.0
          if self.instance.messageLabel.frame.origin.y < 0 {
            self.instance.messageLabel.frame.origin.y = self.instance.config.paddingTop
          }
          self.instance.layoutIfNeeded()
        },
        completion: { (finished: Bool) -> Void in
          if self.instance.config.isAutoDismiss! {
            self.instance.scheduleUpTimer(self.instance.config.dismissTimer)
          }

          for i in 0..<self.instance.delegates.count {
            self.instance.delegates[i].afterMessageShow?(self.instance)
          }
        }
      )
    }
  }
  
  public class func hide() {
    for i in 0..<instance.delegates.count {
      instance.delegates[i].beforeMessageHide?(instance)
    }
    dispatch_async(dispatch_get_main_queue()) {
      UIView.animateWithDuration(instance.config.animationDuration,
        delay: instance.config.animationDelay,
        options: UIViewAnimationOptions.CurveEaseIn,
        animations: { () -> Void in
          self.instance.topConstraint.constant = -self.instance.heightConstraint.constant
          self.instance.layoutIfNeeded()
        }, completion: { (finished: Bool) -> Void in
          for i in 0..<self.instance.delegates.count {
            self.instance.delegates[i].afterMessageHide?(self.instance)
          }
        }
      )
    }
    
  }
}


extension MessageDropdown {
  private class func window() -> UIWindow {
    return UIApplication.sharedApplication().keyWindow!
  }
}

// Message dropdown properties config
class MessageDropdownConfig {
  var paddingLeft: CGFloat!
  var paddingRight: CGFloat!
  var paddingTop: CGFloat!
  var paddingBottom: CGFloat!
  var textColor: UIColor!
  var font: UIFont!
  var textAlignment: NSTextAlignment!
  var colorForType = [MessageDropdownType: MessageDropdownColor]()
  var animationDuration: NSTimeInterval!
  var animationDelay: NSTimeInterval!
  var dismissTimer: Double!
  var isAutoDismiss: Bool!
  
  init() {
    setupDefaultValue()
  }
  
  private func setupDefaultValue() {
    paddingLeft = 16.0
    paddingRight = 16.0
    paddingTop = 16.0
    paddingBottom = 16.0
    
    textColor = UIColor.whiteColor()
    font = UIFont(name: ".HelveticaNeueInterface-Regular", size: 13)
    textAlignment = NSTextAlignment.Center
    
    colorForType[.Default] = MessageDropdownColor(
      backgroundColor: UIColor(red: 41/255.0, green: 128/255.0, blue: 185/255.0, alpha: 1.0),
      textColor: UIColor.whiteColor()
    )
    colorForType[.Info] = MessageDropdownColor(
      backgroundColor: UIColor(red: 52/255.0, green: 152/255.0, blue: 219/255.0, alpha: 1.0),
      textColor: UIColor.whiteColor()
    )
    colorForType[.Success] = MessageDropdownColor(
      backgroundColor: UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0),
      textColor: UIColor.whiteColor()
    )
    colorForType[.Warning] = MessageDropdownColor(
      backgroundColor: UIColor(red: 241/255.0, green: 196/255.0, blue: 15/255.0, alpha: 1.0),
      textColor: UIColor.whiteColor()
    )
    colorForType[.Danger] = MessageDropdownColor(
      backgroundColor: UIColor(red: 192/255.0, green: 57/255.0, blue: 43/255.0, alpha: 1.0),
      textColor: UIColor.whiteColor()
    )
    
    animationDuration = 0.5
    animationDelay = 0
    
    dismissTimer = 3.0
    isAutoDismiss = true
  }
}
