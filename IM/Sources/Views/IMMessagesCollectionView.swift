//
//  IMMessagesCollectionView.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

open class IMMessagesCollectionView: UICollectionView, IMMessagesCollectionViewCellDelegate, IMMessagesLoadEarlierHeaderViewDelegate {
    
    open var messagesDataSource: IMMessagesCollectionViewDataSource? {
        get { return self.dataSource as? IMMessagesCollectionViewDataSource }
    }
    open var messagesDelegate: IMMessagesCollectionViewDelegateFlowLayout? {
        get { return self.delegate as? IMMessagesCollectionViewDelegateFlowLayout }
    }
    open var messagesCollectionViewLayout: IMMessagesCollectionViewFlowLayout {
        get { return self.collectionViewLayout as! IMMessagesCollectionViewFlowLayout }
    }
    
    var typingIndicatorDisplaysOnLeft: Bool = true
    var typingIndicatorMessageBubbleColor: UIColor = UIColor.im_messageBubbleLightGrayColor()
    var typingIndicatorEllipsisColor: UIColor = UIColor.im_messageBubbleLightGrayColor().im_colorByDarkeningColorWithValue(0.3)
    
    var loadEarlierMessagesHeaderTextColor: UIColor = UIColor.im_messageBubbleBlueColor()
    
    // MARK: - Initialization
    
    func im_configureCollectionView() {

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.keyboardDismissMode = .none
        self.alwaysBounceVertical = true
        self.bounces = true
        
        self.register(IMMessagesCollectionViewCellIncoming.nib(), forCellWithReuseIdentifier: IMMessagesCollectionViewCellIncoming.cellReuseIdentifier())
        
        self.register(IMMessagesCollectionViewCellOutgoing.nib(), forCellWithReuseIdentifier: IMMessagesCollectionViewCellOutgoing.cellReuseIdentifier())
        
        self.register(IMMessagesCollectionViewCellIncoming.nib(), forCellWithReuseIdentifier: IMMessagesCollectionViewCellIncoming.mediaCellReuseIdentifier())
        
        self.register(IMMessagesCollectionViewCellOutgoing.nib(), forCellWithReuseIdentifier: IMMessagesCollectionViewCellOutgoing.mediaCellReuseIdentifier())
        
        self.register(IMMessagesTypingIndicatorFooterView.nib(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: IMMessagesTypingIndicatorFooterView.footerReuseIdentifier())
        
        self.register(IMMessagesLoadEarlierHeaderView.nib(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: IMMessagesLoadEarlierHeaderView.headerReuseIdentifier())
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.im_configureCollectionView()
    }

    public required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.im_configureCollectionView()
    }
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.im_configureCollectionView()
    }
    
    // MARK: - Typing indicator
    
    func dequeueTypingIndicatorFooterView(_ indexPath: IndexPath) -> IMMessagesTypingIndicatorFooterView {
        
        let footerView = super.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: IMMessagesTypingIndicatorFooterView.footerReuseIdentifier(), for: indexPath) as! IMMessagesTypingIndicatorFooterView
        
        footerView.configure(self.typingIndicatorEllipsisColor, messageBubbleColor: self.typingIndicatorMessageBubbleColor, shouldDisplayOnLeft: self.typingIndicatorDisplaysOnLeft, forCollectionView: self)
        
        return footerView
    }
    
    // MARK: - Load earlier messages header
    
    func dequeueLoadEarlierMessagesViewHeader(_ indexPath: IndexPath) -> IMMessagesLoadEarlierHeaderView {
        
        let headerView = super.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: IMMessagesLoadEarlierHeaderView.headerReuseIdentifier(), for: indexPath) as! IMMessagesLoadEarlierHeaderView
        
        headerView.loadButton.tintColor = self.loadEarlierMessagesHeaderTextColor
        headerView.delegate = self
        
        return headerView
    }
    
    // MARK: - Load earlier messages header delegate
    
    open func headerView(_ headerView: IMMessagesLoadEarlierHeaderView, didPressLoadButton sender: UIButton?) {
        
        self.messagesDelegate?.collectionView?(self, header: headerView, didTapLoadEarlierMessagesButton: sender)
    }
    
    // MARK: - Messages collection cell delegate

    open func messagesCollectionViewCellDidTapAvatar(_ cell: IMMessagesCollectionViewCell) {
        
        if let indexPath = self.indexPath(for: cell) {
            
            self.messagesDelegate?.collectionView?(self, didTapAvatarImageView: cell.avatarImageView, atIndexPath: indexPath)
        }
    }
    
    open func messagesCollectionViewCellDidTapMessageBubble(_ cell: IMMessagesCollectionViewCell) {
        
        if let indexPath = self.indexPath(for: cell) {
            
            self.messagesDelegate?.collectionView?(self, didTapMessageBubbleAtIndexPath: indexPath)
        }
    }
    
    open func messagesCollectionViewCellDidTapCell(_ cell: IMMessagesCollectionViewCell, atPosition position: CGPoint) {
        
        if let indexPath = self.indexPath(for: cell) {
            
            self.messagesDelegate?.collectionView?(self, didTapCellAtIndexPath: indexPath, touchLocation: position)
        }
    }
    
    open func messagesCollectionViewCell(_ cell: IMMessagesCollectionViewCell, didPerformAction action: Selector, withSender sender: AnyObject) {
        
        if let indexPath = self.indexPath(for: cell) {
            
            self.messagesDelegate?.collectionView?(self, performAction: action, forItemAt: indexPath, withSender: sender)
        }
    }
}
