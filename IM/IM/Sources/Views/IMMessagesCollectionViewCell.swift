//
//  IMMessagesCollectionViewCell.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

public protocol IMMessagesCollectionViewCellDelegate {
    
    func messagesCollectionViewCellDidTapAvatar(_ cell: IMMessagesCollectionViewCell)
    func messagesCollectionViewCellDidTapMessageBubble(_ cell: IMMessagesCollectionViewCell)
    
    func messagesCollectionViewCellDidTapCell(_ cell: IMMessagesCollectionViewCell, atPosition position: CGPoint)
    func messagesCollectionViewCell(_ cell: IMMessagesCollectionViewCell, didPerformAction action: Selector, withSender sender: AnyObject)
}

open class IMMessagesCollectionViewCell: UICollectionViewCell {
    
    fileprivate static var imMessagesCollectionViewCellActions: Set<Selector> = Set()
    
    open var delegate: IMMessagesCollectionViewCellDelegate?
    
    @IBOutlet fileprivate(set) open var cellTopLabel: IMMessagesLabel!
    @IBOutlet fileprivate(set) open var messageBubbleTopLabel: IMMessagesLabel!
    @IBOutlet fileprivate(set) open var cellBottomLabel: IMMessagesLabel!
    
    @IBOutlet fileprivate(set) open var messageBubbleContainerView: UIView!
    @IBOutlet fileprivate(set) open var messageBubbleImageView: UIImageView?
    @IBOutlet fileprivate(set) open var textView: IMMessagesCellTextView?
    
    @IBOutlet fileprivate(set) open var avatarImageView: UIImageView!
    @IBOutlet fileprivate(set) open var avatarContainerView: UIView!
    
    @IBOutlet fileprivate var messageBubbleContainerWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate var textViewTopVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var textViewBottomVerticalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var textViewAvatarHorizontalSpaceConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var textViewMarginHorizontalSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate var cellTopLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var messageBubbleTopLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var cellBottomLabelHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet fileprivate var avatarContainerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate var avatarContainerViewHeightConstraint: NSLayoutConstraint!
    
    fileprivate(set) var tapGestureRecognizer: UITapGestureRecognizer?
    
    fileprivate var textViewFrameInsets: UIEdgeInsets {
        
        set {

            if UIEdgeInsetsEqualToEdgeInsets(newValue, self.textViewFrameInsets) {
                
                return
            }
            
            self.im_update(constraint: self.textViewTopVerticalSpaceConstraint, withConstant: newValue.top)
            self.im_update(constraint: self.textViewBottomVerticalSpaceConstraint, withConstant: newValue.bottom)
            self.im_update(constraint: self.textViewAvatarHorizontalSpaceConstraint, withConstant: newValue.right)
            self.im_update(constraint: self.textViewMarginHorizontalSpaceConstraint, withConstant: newValue.left)
        }

        get {
            
            return UIEdgeInsetsMake(self.textViewTopVerticalSpaceConstraint.constant,
                                    self.textViewMarginHorizontalSpaceConstraint.constant,
                                    self.textViewBottomVerticalSpaceConstraint.constant,
                                    self.textViewAvatarHorizontalSpaceConstraint.constant)
        }
    }
    
    fileprivate var avatarViewSize: CGSize {
        
        set {
            
            if newValue.equalTo(self.avatarViewSize) {
                
                return
            }
            
            self.im_update(constraint: self.avatarContainerViewWidthConstraint, withConstant: newValue.width)
            self.im_update(constraint: self.avatarContainerViewHeightConstraint, withConstant: newValue.height)
        }
        
        get {
            
            return CGSize(width: self.avatarContainerViewWidthConstraint.constant,
                              height: self.avatarContainerViewHeightConstraint.constant)
        }
    }
    
    open var mediaView: UIView? {
        
        didSet {
            
            if let mediaView = self.mediaView {
                
                self.messageBubbleImageView?.removeFromSuperview()
                self.textView?.removeFromSuperview()

                mediaView.translatesAutoresizingMaskIntoConstraints = false
                mediaView.frame = self.messageBubbleContainerView.bounds
                
                self.messageBubbleContainerView.addSubview(mediaView)
                self.messageBubbleContainerView.im_pinAllEdgesOfSubview(mediaView)
                
                DispatchQueue.main.async {
                    for i in 0 ..< self.messageBubbleContainerView.subviews.count {
                        if i < self.messageBubbleContainerView.subviews.count {
                            if self.messageBubbleContainerView.subviews[i] != mediaView {
                                self.messageBubbleContainerView.subviews[i].removeFromSuperview()
                            }                            
                        }
                    }
                }
            }
        }
    }
    
    open override var backgroundColor: UIColor? {
        
        didSet {
            
            self.cellTopLabel.backgroundColor = backgroundColor
            self.messageBubbleTopLabel.backgroundColor = backgroundColor
            self.cellBottomLabel.backgroundColor = backgroundColor
            
            self.messageBubbleImageView?.backgroundColor = backgroundColor
            self.avatarImageView.backgroundColor = backgroundColor
            
            self.messageBubbleContainerView.backgroundColor = backgroundColor
            self.avatarContainerView.backgroundColor = backgroundColor
        }
    }
    
    // MARK: - Class methods
    
    open class func nib() -> UINib {
        
        return UINib(nibName: "\(IMMessagesCollectionViewCell.self)".im_className(), bundle: Bundle(for: IMMessagesCollectionViewCell.self))
    }
    
    open class func cellReuseIdentifier() -> String {
        
        return "\(IMMessagesCollectionViewCell.self)".im_className()
    }
    
    open class func mediaCellReuseIdentifier() -> String {
        
        return "\(IMMessagesCollectionViewCell.self)".im_className() + "_IMMedia"
    }
    
    open class func registerMenuAction(_ action: Selector) {
        
        IMMessagesCollectionViewCell.imMessagesCollectionViewCellActions.insert(action)
    }
    
    // MARK: - Initialization
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()

        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = UIColor.white
        
        self.cellTopLabelHeightConstraint.constant = 0
        self.messageBubbleTopLabelHeightConstraint.constant = 0
        self.cellBottomLabelHeightConstraint.constant = 0
        
        self.cellTopLabel.textAlignment = .center
        self.cellTopLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.cellTopLabel.textColor = UIColor.lightGray
        
        self.messageBubbleTopLabel.font = UIFont.systemFont(ofSize: 12)
        self.messageBubbleTopLabel.textColor = UIColor.lightGray
        
        self.cellBottomLabel.font = UIFont.systemFont(ofSize: 11);
        self.cellBottomLabel.textColor = UIColor.lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(IMMessagesCollectionViewCell.im_handleTapGesture(_:)))
        self.addGestureRecognizer(tap)
        self.tapGestureRecognizer = tap
    }
    
    deinit {
        
        self.tapGestureRecognizer?.removeTarget(nil, action: nil)
        self.tapGestureRecognizer = nil
    }
    
    // MARK: - Collection view cell
    
    open override func prepareForReuse() {
        
        super.prepareForReuse()
        
        self.cellTopLabel.text = nil
        self.messageBubbleTopLabel.text = nil
        self.cellBottomLabel.text = nil
        
        self.textView?.dataDetectorTypes = UIDataDetectorTypes()
        self.textView?.text = nil
        self.textView?.attributedText = nil
        
        self.avatarImageView.image = nil
        self.avatarImageView.highlightedImage = nil
    }
    
    open override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        return layoutAttributes
    }
    
    open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        
        super.apply(layoutAttributes)
        
        if let customAttributes = layoutAttributes as? IMMessagesCollectionViewLayoutAttributes {
            
            if let textView = self.textView {
                
                if textView.font != customAttributes.messageBubbleFont {
                    
                    textView.font = customAttributes.messageBubbleFont
                }
                
                if !UIEdgeInsetsEqualToEdgeInsets(textView.textContainerInset, customAttributes.textViewTextContainerInsets) {
                    
                    textView.textContainerInset = customAttributes.textViewTextContainerInsets
                }
            }
            
            self.textViewFrameInsets = customAttributes.textViewFrameInsets
            
            self.im_update(constraint: self.messageBubbleContainerWidthConstraint, withConstant: customAttributes.messageBubbleContainerViewWidth)
            self.im_update(constraint: self.cellTopLabelHeightConstraint, withConstant: customAttributes.cellTopLabelHeight)
            self.im_update(constraint: self.messageBubbleTopLabelHeightConstraint, withConstant: customAttributes.messageBubbleTopLabelHeight)
            self.im_update(constraint: self.cellBottomLabelHeightConstraint, withConstant: customAttributes.cellBottomLabelHeight)
            
            if self is IMMessagesCollectionViewCellIncoming {
                
                self.avatarViewSize = customAttributes.incomingAvatarViewSize
            }
            else if self is IMMessagesCollectionViewCellOutgoing {
                
                self.avatarViewSize = customAttributes.outgoingAvatarViewSize
            }
        }
    }
    
    open override var isHighlighted: Bool {
        
        didSet {
            
            self.messageBubbleImageView?.isHighlighted = self.isHighlighted
        }
    }
    
    open override var isSelected: Bool {
        
        didSet {
            
            self.messageBubbleImageView?.isHighlighted = self.isSelected
        }
    }
    
    open override var bounds: CGRect {
        
        didSet {
            
            if UIDevice.im_isCurrentDeviceBeforeiOS8() {
 
                self.contentView.frame = bounds
            }
        }
    }
    
    // MARK: - Menu actions
    
    open override func responds(to aSelector: Selector) -> Bool {
        
        if IMMessagesCollectionViewCell.imMessagesCollectionViewCellActions.contains(aSelector) {
            
            return true
        }
        
        return super.responds(to: aSelector)
    }
    
    //TODO: Swift compatibility
    /*override func forwardInvocation(anInvocation: NSInvocation!) {
        
        if IMMessagesCollectionViewCell.imMessagesCollectionViewCellActions.contains(aSelector) {
            
            return
        }
    }
    
    override func methodSignatureForSelector(aSelector: Selector) -> NSMethodSignature! {
        
        if IMMessagesCollectionViewCell.imMessagesCollectionViewCellActions.contains(aSelector) {
            
            return NSMethodSign
        }
    }*/
    
    // MARK: - Utilities
    
    func im_update(constraint: NSLayoutConstraint, withConstant constant: CGFloat) {
        
        if constraint.constant == constant {
            return
        }
        
        constraint.constant = constant
    }
    
    // MARK: - Gesture recognizers
    
    func im_handleTapGesture(_ tap: UITapGestureRecognizer) {
        
        let touchPoint = tap.location(in: self)
        
        if self.avatarContainerView.frame.contains(touchPoint) {
            
            self.delegate?.messagesCollectionViewCellDidTapAvatar(self)
        }
        else if self.messageBubbleContainerView.frame.contains(touchPoint) {
            
            self.delegate?.messagesCollectionViewCellDidTapMessageBubble(self)
        }
        else {
            
            self.delegate?.messagesCollectionViewCellDidTapCell(self, atPosition: touchPoint)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        let touchPoint = touch.location(in: self)
        
        if let _ = gestureRecognizer as? UILongPressGestureRecognizer {
            
            return self.messageBubbleContainerView.frame.contains(touchPoint)
        }
        
        return true
    }
}
