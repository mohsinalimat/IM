//
//  IMMessagesKeyboardController.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

public let IMMessagesKeyboardControllerNotificationKeyboardDidChangeFrame = "IMMessagesKeyboardControllerNotificationKeyboardDidChangeFrame"
public let IMMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame = "IMMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame"

public protocol IMMessagesKeyboardControllerDelegate {
    
    func keyboardController(_ keyboardController: IMMessagesKeyboardController, keyboardDidChangeFrame keyboardFrame: CGRect)
}

open class IMMessagesKeyboardController: NSObject, UIGestureRecognizerDelegate {
    
    open var delegate: IMMessagesKeyboardControllerDelegate?
    fileprivate(set) open var textView: UITextView
    fileprivate(set) open var contextView: UIView
    fileprivate(set) open var panGestureRecognizer: UIPanGestureRecognizer
    
    open var keyboardTriggerPoint: CGPoint = CGPoint.zero
    open var keyboardIsVisible: Bool {
        
        get {
            
            return self.keyboardView != nil
        }
    }
    open var currentKeyboardFrame: CGRect {
        
        get {
            
            if !self.keyboardIsVisible {
                
                return CGRect.null
            }
            
            return self.keyboardView?.frame ?? CGRect.null
        }
    }
    
    fileprivate var im_isObserving: Bool = false
    fileprivate var keyboardView: UIView? {
        
        didSet {
            
            if self.keyboardView != nil {
                
                self.im_removeKeyboardFrameObserver()
            }
            
            if let keyboardView = self.keyboardView {
                
                if !self.im_isObserving {
                    
                    keyboardView.addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.old,NSKeyValueObservingOptions.new], context: self.kIMMessagesKeyboardControllerKeyValueObservingContext)
                    
                    self.im_isObserving = true
                }
            }
        }
    }
    
    fileprivate var kIMMessagesKeyboardControllerKeyValueObservingContext: UnsafeMutableRawPointer? = nil
    typealias IMAnimationCompletionBlock = ((Bool) -> Void)
    
    // MARK: - Initialization
    
    public init(textView: UITextView, contextView: UIView, panGestureRecognizer: UIPanGestureRecognizer, delegate: IMMessagesKeyboardControllerDelegate?) {
        
        self.textView = textView
        self.contextView = contextView
        self.panGestureRecognizer = panGestureRecognizer
        self.delegate = delegate
    }
    
    // MARK: - Keyboard controller
    
    open func beginListeningForKeyboard() {
        
        if self.textView.inputAccessoryView == nil {
            
            self.textView.inputAccessoryView = UIView()
        }
        
        self.im_registerForNotifications()
    }
    
    open func endListeningForKeyboard() {
        
        self.im_unregisterForNotifications()
        
        self.im_setKeyboardView(hidden: false)
        self.keyboardView = nil
    }
    
    // MARK: - Notifications
    
    func im_registerForNotifications() {
        
        self.im_unregisterForNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(IMMessagesKeyboardController.im_didReceiveKeyboardDidShowNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IMMessagesKeyboardController.im_didReceiveKeyboardWillChangeFrameNotification(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IMMessagesKeyboardController.im_didReceiveKeyboardDidChangeFrameNotification(_:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(IMMessagesKeyboardController.im_didReceiveKeyboardDidHideNotification(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    func im_unregisterForNotifications() {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func im_didReceiveKeyboardDidShowNotification(_ notification: Notification) {
        
        self.keyboardView = self.textView.inputAccessoryView?.superview
        self.im_setKeyboardView(hidden: false)
        
        self.im_handleKeyboardNotification(notification) { (finished) -> Void in
            
            self.panGestureRecognizer.addTarget(self, action: #selector(IMMessagesKeyboardController.im_handlePanGestureRecognizer(_:)))
        }
    }
    
    func im_didReceiveKeyboardWillChangeFrameNotification(_ notification: Notification) {

        self.im_handleKeyboardNotification(notification, completion: nil)
    }
    
    func im_didReceiveKeyboardDidChangeFrameNotification(_ notification: Notification) {
        
        self.im_setKeyboardView(hidden: false)
        self.im_handleKeyboardNotification(notification, completion: nil)
    }
    
    func im_didReceiveKeyboardDidHideNotification(_ notification: Notification) {
        
        self.keyboardView = nil
        
        self.im_handleKeyboardNotification(notification) { (finished) -> Void in
            
            self.panGestureRecognizer.removeTarget(self, action: nil)
        }
    }
    
    func im_handleKeyboardNotification(_ notification: Notification, completion: IMAnimationCompletionBlock?) {
        
        if let userInfo = notification.userInfo,
            let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue {
            
            if keyboardEndFrame.isNull {
                
                return
            }
            
            if let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int,
                let animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double {
            
                    let animationCurveOption = UIViewAnimationOptions(rawValue: UInt(animationCurve << 16))
                let keyboardEndFrameConverted = self.contextView.convert(keyboardEndFrame, from: nil)

                UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurveOption, animations: { () -> Void in
                    
                    self.im_notifyKeyboardFrameNotification(frame: keyboardEndFrameConverted)

                }, completion: { (finished) -> Void in
                    
                    completion?(finished)
                })
            }
        }
    }
    
    // MARK: - Utilities
    
    func im_setKeyboardView(hidden: Bool) {
        
        self.keyboardView?.isHidden = hidden
        self.keyboardView?.isUserInteractionEnabled = !hidden
    }
    
    func im_notifyKeyboardFrameNotification(frame: CGRect) {
        
        self.delegate?.keyboardController(self, keyboardDidChangeFrame: frame)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: IMMessagesKeyboardControllerNotificationKeyboardDidChangeFrame), object: self, userInfo: [IMMessagesKeyboardControllerUserInfoKeyKeyboardDidChangeFrame: NSValue(cgRect: frame)])
    }
    
    func im_resetKeyboardAndTextView() {
        
        self.im_setKeyboardView(hidden: true)
        self.im_removeKeyboardFrameObserver()
        self.textView.resignFirstResponder()
    }
    
    // MARK: - Key-value observing

    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == self.kIMMessagesKeyboardControllerKeyValueObservingContext {
            
            if let object = object as? UIView {
                
                if object == self.keyboardView && keyPath == "frame" {
                    
                    if let oldKeyboardFrame = (change?[NSKeyValueChangeKey.oldKey] as AnyObject).cgRectValue,
                        let newKeyboardFrame = (change?[NSKeyValueChangeKey.newKey] as AnyObject).cgRectValue {
                    
                        if (newKeyboardFrame.isNull || newKeyboardFrame.equalTo(oldKeyboardFrame)) {
                            return;
                        }
                        
                        let keyboardEndFrameConverted = self.contextView.convert(newKeyboardFrame, from: self.keyboardView?.superview)
                            
                        self.im_notifyKeyboardFrameNotification(frame: keyboardEndFrameConverted)
                    }
                }
            }
        }
    }
    
    func im_removeKeyboardFrameObserver() {
        
        if !self.im_isObserving {
            
            return
        }
        
        self.keyboardView?.removeObserver(self, forKeyPath: "frame", context: self.kIMMessagesKeyboardControllerKeyValueObservingContext)
        
        self.im_isObserving = false
    }
    
    // MARK: - Pan gesture recognizer
    
    func im_handlePanGestureRecognizer(_ pan: UIPanGestureRecognizer) {
        
        let touch = pan.location(in: self.contextView.window)
        let contextViewWindowHeight = self.contextView.window?.frame.height ?? 0
        
        let keyboardViewHeight = self.keyboardView?.frame.height ?? 0
        let dragThresholdY = contextViewWindowHeight - keyboardViewHeight - self.keyboardTriggerPoint.y
        var newKeyboardViewFrame = self.keyboardView?.frame ?? CGRect.zero
        
        let userIsDraggingNearThresholdForDismissing = touch.y > dragThresholdY
        self.keyboardView?.isUserInteractionEnabled = !userIsDraggingNearThresholdForDismissing
        
        switch pan.state {
            
            case .changed:
                
                newKeyboardViewFrame.origin.y = touch.y + self.keyboardTriggerPoint.y
                
                //  bound frame between bottom of view and height of keyboard
                newKeyboardViewFrame.origin.y = min(newKeyboardViewFrame.origin.y, contextViewWindowHeight)
                newKeyboardViewFrame.origin.y = max(newKeyboardViewFrame.origin.y, contextViewWindowHeight - keyboardViewHeight)
                
                if newKeyboardViewFrame.minY == (self.keyboardView?.frame ?? CGRect.zero).minY {
                    
                    return
                }
                
                UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { () -> Void in
                    
                    self.keyboardView?.frame = newKeyboardViewFrame
                }, completion: nil)
            
            case .ended, .cancelled, .failed:
                
                let keyboardViewIsHidden: Bool = (self.keyboardView?.frame ?? CGRect.zero).minY >= contextViewWindowHeight
                if keyboardViewIsHidden {
                    
                    self.im_resetKeyboardAndTextView()
                }
                let velocity = pan.velocity(in: self.contextView)
                let userIsScrollingDown: Bool = velocity.y > 0
                let shouldHide: Bool = userIsScrollingDown && userIsDraggingNearThresholdForDismissing
                
                newKeyboardViewFrame.origin.y = shouldHide ? contextViewWindowHeight : (contextViewWindowHeight - keyboardViewHeight)
            
                let options: UIViewAnimationOptions = [UIViewAnimationOptions.beginFromCurrentState, UIViewAnimationOptions.curveEaseOut]
                UIView.animate(withDuration: 0.25, delay: 0, options: options, animations: { () -> Void in
                    
                    self.keyboardView?.frame = newKeyboardViewFrame
                }, completion: { (finished) -> Void in
                    
                    self.keyboardView?.isUserInteractionEnabled = !shouldHide
                    
                    if shouldHide {

                        self.im_resetKeyboardAndTextView()
                    }
                })
            
            default:
                break
        }
    }
}
