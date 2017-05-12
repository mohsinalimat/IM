//
//  IMMessagesCollectionViewCellIncoming.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

open class IMMessagesCollectionViewCellIncoming: IMMessagesCollectionViewCell {
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.messageBubbleTopLabel.textAlignment = .left
        self.cellBottomLabel.textAlignment = .left
    }
    
    open override class func nib() -> UINib {
        
        return UINib(nibName: "\(IMMessagesCollectionViewCellIncoming.self)".im_className(), bundle: Bundle(for: IMMessagesCollectionViewCellIncoming.self))
    }
    
    open override class func cellReuseIdentifier() -> String {
        
        return "\(IMMessagesCollectionViewCellIncoming.self)".im_className()
    }
    
    open override class func mediaCellReuseIdentifier() -> String {
        
        return "\(IMMessagesCollectionViewCellIncoming.self)".im_className() + "_IMMedia"
    }
}
