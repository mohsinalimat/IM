//
//  IMMessagesBubbleImage.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

open class IMMessagesBubbleImage: NSObject, IMMessageBubbleImageDataSource, NSCopying {
    
    fileprivate(set) open var messageBubbleImage: UIImage
    fileprivate(set) open var messageBubbleHighlightedImage: UIImage
    
    public required init(bubbleImage: UIImage, highlightedImage: UIImage) {
        
        self.messageBubbleImage = bubbleImage
        self.messageBubbleHighlightedImage = highlightedImage
    }
    
    // MARK: - NSCopying
    
    open func copy(with zone: NSZone?) -> Any {
        
        return type(of: self).init(bubbleImage: UIImage(cgImage: self.messageBubbleImage.cgImage!), highlightedImage: UIImage(cgImage: self.messageBubbleHighlightedImage.cgImage!))
    }
}
