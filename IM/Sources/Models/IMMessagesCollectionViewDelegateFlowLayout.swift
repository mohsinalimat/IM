//
//  IMMessagesCollectionViewDelegateFlowLayout.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

@objc public protocol IMMessagesCollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {

    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, layout: IMMessagesCollectionViewFlowLayout, heightForCellTopLabelAtIndexPath indexPath: IndexPath) -> CGFloat
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, layout: IMMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAtIndexPath indexPath: IndexPath) -> CGFloat
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, layout: IMMessagesCollectionViewFlowLayout, heightForCellBottomLabelAtIndexPath indexPath: IndexPath) -> CGFloat
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, didTapAvatarImageView imageView: UIImageView, atIndexPath indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, didTapMessageBubbleAtIndexPath indexPath: IndexPath)
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, didTapCellAtIndexPath indexPath: IndexPath, touchLocation: CGPoint)
    @objc optional func collectionView(_ collectionView: IMMessagesCollectionView, header: IMMessagesLoadEarlierHeaderView, didTapLoadEarlierMessagesButton button: UIButton?)
}
