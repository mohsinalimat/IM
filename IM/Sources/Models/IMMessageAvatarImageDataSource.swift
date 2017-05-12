//
//  IMMessageAvatarImageDataSource.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol IMMessageAvatarImageDataSource {
    
    var avatarImage: UIImage? { get }
    var avatarHighlightedImage: UIImage? { get }
    var avatarPlaceholderImage: UIImage { get }
}
