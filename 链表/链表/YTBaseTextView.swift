//
//  YTBaseTextView.swift
//  链表
//
//  Created by 段雨田 on 2020/6/2.
//  Copyright © 2020 段雨田. All rights reserved.
//

import Cocoa

class YTBaseTextView: NSTextView {

  
  var placeholder:String?
  
  var placeholderColor = NSColor.lightGray
  
  fileprivate var placeHolderLabel:NSTextField!
  
  override class func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  
  override init(frame frameRect: NSRect) {
    super.init(frame: frameRect)
    registNotication()
  }
  
  

  override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
    super.init(frame: frameRect, textContainer: container)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    registNotication()
  }
  
    
  override func draw(_ dirtyRect: NSRect) {
    
    if (placeholder?.isEmpty == false) {
         
      if (placeHolderLabel == nil) {
        placeHolderLabel = NSTextField.init(frame: NSRect(x: 3, y: 0, width: self.bounds.size.width, height: 10))
        placeHolderLabel.isBordered = false
        placeHolderLabel.font = self.font
        placeHolderLabel.lineBreakMode = .byWordWrapping
        placeHolderLabel.backgroundColor = NSColor.clear
        placeHolderLabel.textColor = NSColor.lightGray
        placeHolderLabel.isEditable = false
        placeHolderLabel.alphaValue = 0
        placeHolderLabel.maximumNumberOfLines = 2
        placeHolderLabel.tag = 999
        placeHolderLabel.placeholderString = self.placeholder
        placeHolderLabel.sizeToFit()
        self.addSubview(placeHolderLabel)
      }
      
      if self.string.isEmpty == true {
        placeHolderLabel.alphaValue = 1
      }
         
    }
       
    super.draw(dirtyRect)
   
  }

    
}

extension YTBaseTextView: NSTextViewDelegate {
  
  
  func registNotication() {
    self.delegate = self
    
//    NotificationCenter.default.addObserver(self, selector: #selector(textChanged:), name: NSTextView.willChangeNotifyingTextViewNotification.rawValue, object: nil)
    
  }
  
  func textDidChange(_ notification: Notification) {
    
    if placeholder != nil {
      if self.string.isEmpty {
        placeHolderLabel.alphaValue = 1
      } else {
        placeHolderLabel.alphaValue = 0
      }
    }    
    
  }
  
  
}
