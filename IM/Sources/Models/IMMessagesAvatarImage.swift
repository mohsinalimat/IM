//
//  IMMessagesAvatarImage.swift
//  IMMessagesViewController
//
//  Created by Meniny on 20/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

open class IMMessagesAvatarImage: NSObject, IMMessageAvatarImageDataSource, NSCopying {
    
    open var avatarImage: UIImage?
    open var avatarHighlightedImage: UIImage?
    fileprivate(set) open var avatarPlaceholderImage: UIImage
    
    public required init(avatarImage: UIImage?, highlightedImage: UIImage?, placeholderImage: UIImage) {
        
        self.avatarImage = avatarImage
        self.avatarHighlightedImage = highlightedImage
        self.avatarPlaceholderImage = placeholderImage
        
        super.init()
    }
    
    open class func avatar(image: UIImage) -> IMMessagesAvatarImage {
        
        return IMMessagesAvatarImage(avatarImage: image, highlightedImage: image, placeholderImage: image)
    }
    
    open class func avatar(placeholder: UIImage) -> IMMessagesAvatarImage {
        
        return IMMessagesAvatarImage(avatarImage: nil, highlightedImage: nil, placeholderImage: placeholder)
    }
    
    // MARK: - NSObject
    
    open override var description: String {
        
        get {
            
            return "<\(type(of: self)): avatarImage=\(String(describing: self.avatarImage)), avatarHighlightedImage=\(String(describing: self.avatarHighlightedImage)), avatarPlaceholderImage=\(self.avatarPlaceholderImage)>"
        }
    }
    
    func debugQuickLookObject() -> AnyObject? {
        
        return UIImageView(image: self.avatarImage != nil ? self.avatarImage : self.avatarPlaceholderImage)
    }
    
    // MARK: - NSCopying
    
    open func copy(with zone: NSZone?) -> Any {
     
        return type(of: self).init(avatarImage: UIImage(cgImage: self.avatarImage!.cgImage!), highlightedImage: UIImage(cgImage: self.avatarHighlightedImage!.cgImage!), placeholderImage: UIImage(cgImage: self.avatarPlaceholderImage.cgImage!))
    }
}
