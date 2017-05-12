//
//  IMMessagesInputToolbar.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

var kIMMessagesInputToolbarKeyValueObservingContext: UnsafeMutableRawPointer? = nil

public protocol IMMessagesInputToolbarDelegate: UIToolbarDelegate {
    
    func messagesInputToolbar(_ toolbar: IMMessagesInputToolbar, didPressRightBarButton sender: UIButton)
    func messagesInputToolbar(_ toolbar: IMMessagesInputToolbar, didPressLeftBarButton sender: UIButton)
}

open class IMMessagesInputToolbar: UIToolbar {
    
    var toolbarDelegate: IMMessagesInputToolbarDelegate? {
        get { return self.delegate as? IMMessagesInputToolbarDelegate }
        set { self.delegate = newValue }
    }
    
    fileprivate(set) open var contentView: IMMessagesToolbarContentView!
    
    open var sendButtonOnRight: Bool = true
    open var preferredDefaultHeight: CGFloat = 44
    open var maximumHeight: Int = NSNotFound
    
    fileprivate var im_isObserving: Bool = false
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let toolbarContentView = self.loadToolbarContentView()
        toolbarContentView.frame = self.frame
        self.addSubview(toolbarContentView)
        self.im_pinAllEdgesOfSubview(toolbarContentView)
        self.setNeedsUpdateConstraints()
        self.contentView = toolbarContentView
        
        self.im_addObservers()
        
        self.contentView.leftBarButtonItem = IMMessagesToolbarButtonFactory.defaultAccessoryButtonItem()
        self.contentView.rightBarButtonItem = IMMessagesToolbarButtonFactory.defaultSendButtonItem()
        
        self.toggleSendButtonEnabled()
    }

    func loadToolbarContentView() -> IMMessagesToolbarContentView {
        
        return Bundle(for: IMMessagesToolbarContentView.self).loadNibNamed("\(IMMessagesToolbarContentView.self)".im_className(), owner: nil, options: nil)!.first as! IMMessagesToolbarContentView
    }
    
    deinit {
        
        self.im_removeObservers()
        self.contentView = nil
    }
    
    // MARK: - Input toolbar
    
    func toggleSendButtonEnabled() {
        
        let hasText = self.contentView.textView.hasText
        
        if self.sendButtonOnRight {
            
            self.contentView.rightBarButtonItem?.isEnabled = hasText
        }
        else {
            
            self.contentView.leftBarButtonItem?.isEnabled = hasText
        }
    }
    
    // MARK: - Actions
    
    func im_leftBarButtonPressed(_ sender: UIButton) {
        
        self.toolbarDelegate?.messagesInputToolbar(self, didPressLeftBarButton: sender)
    }
    
    func im_rightBarButtonPressed(_ sender: UIButton) {
        
        self.toolbarDelegate?.messagesInputToolbar(self, didPressRightBarButton: sender)
    }
    
    // MARK: - Key-value observing
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == kIMMessagesInputToolbarKeyValueObservingContext {
            
            if let object = object as? IMMessagesToolbarContentView {
                
                if object == self.contentView {
                    
                    if keyPath == "leftBarButtonItem" {
                        
                        self.contentView.leftBarButtonItem?.removeTarget(self, action: nil, for: .touchUpInside)
                        self.contentView.leftBarButtonItem?.addTarget(self, action: #selector(IMMessagesInputToolbar.im_leftBarButtonPressed(_:)), for: .touchUpInside)
                    }
                    else if keyPath == "rightBarButtonItem" {
                        
                        self.contentView.rightBarButtonItem?.removeTarget(self, action: nil, for: .touchUpInside)
                        self.contentView.rightBarButtonItem?.addTarget(self, action: #selector(IMMessagesInputToolbar.im_rightBarButtonPressed(_:)), for: .touchUpInside)
                    }
                    
                    self.toggleSendButtonEnabled()
                }
            }
        }
    }
    
    func im_addObservers() {
        
        if self.im_isObserving {
            
            return
        }
        
        self.contentView.addObserver(self, forKeyPath: "leftBarButtonItem", options: NSKeyValueObservingOptions(), context: kIMMessagesInputToolbarKeyValueObservingContext)
        self.contentView.addObserver(self, forKeyPath: "rightBarButtonItem", options: NSKeyValueObservingOptions(), context: kIMMessagesInputToolbarKeyValueObservingContext)
        
        self.im_isObserving = true
    }
    
    func im_removeObservers() {
        
        if !self.im_isObserving {
            return
        }
        
        self.contentView.removeObserver(self, forKeyPath: "leftBarButtonItem", context: kIMMessagesInputToolbarKeyValueObservingContext)
        self.contentView.removeObserver(self, forKeyPath: "rightBarButtonItem", context: kIMMessagesInputToolbarKeyValueObservingContext)
        
        self.im_isObserving = false
    }
}
