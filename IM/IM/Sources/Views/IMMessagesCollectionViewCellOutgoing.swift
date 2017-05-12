//
//  IMMessagesCollectionViewCellOutgoing.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

open class IMMessagesCollectionViewCellOutgoing: IMMessagesCollectionViewCell {
    
    open override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.messageBubbleTopLabel.textAlignment = .right
        self.cellBottomLabel.textAlignment = .right
    }
    
    open override class func nib() -> UINib {
        
        return UINib(nibName: "\(IMMessagesCollectionViewCellOutgoing.self)".im_className(), bundle: Bundle(for: IMMessagesCollectionViewCellOutgoing.self))
    }
    
    open override class func cellReuseIdentifier() -> String {
        
        return "\(IMMessagesCollectionViewCellOutgoing.self)".im_className()
    }
    
    open override class func mediaCellReuseIdentifier() -> String {
        
        return "\(IMMessagesCollectionViewCellOutgoing.self)".im_className() + "_IMMedia"
    }
}
