//
//  IMMessagesCollectionViewDataSource.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol IMMessagesCollectionViewDataSource: UICollectionViewDataSource {
    
    var senderID: String { get }
    var senderDisplayName: String { get }
    
    func collectionView(_ collectionView: IMMessagesCollectionView, messageDataForItemAtIndexPath indexPath: IndexPath) -> IMMessageData
    func collectionView(_ collectionView: IMMessagesCollectionView, messageBubbleImageDataForItemAtIndexPath indexPath: IndexPath) -> IMMessageBubbleImageDataSource
    func collectionView(_ collectionView: IMMessagesCollectionView, avatarImageDataForItemAtIndexPath indexPath: IndexPath) -> IMMessageAvatarImageDataSource?
    
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, attributedTextForCellTopLabelAtIndexPath indexPath: IndexPath) -> NSAttributedString?
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: IndexPath) -> NSAttributedString?
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, attributedTextForCellBottomLabelAtIndexPath indexPath: IndexPath) -> NSAttributedString?
}
