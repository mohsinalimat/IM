//
//  IMMessageAvatarImageDataSource.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

@objc public protocol IMMessageAvatarImageDataSource {
    
    var avatarImage: UIImage? { get }
    var avatarHighlightedImage: UIImage? { get }
    var avatarPlaceholderImage: UIImage { get }
}
