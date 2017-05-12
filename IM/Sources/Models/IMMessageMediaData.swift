//
//  IMMessageMediaData.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol IMMessageMediaData: NSObjectProtocol {
    
    var mediaView: UIView? { get }
    var mediaViewDisplaySize: CGSize { get }
    var mediaPlaceholderView: UIView { get }
    var mediaHash: Int { get }
}
