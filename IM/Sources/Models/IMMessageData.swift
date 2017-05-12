//
//  IMMessageData.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

@objc public protocol IMMessageData {
    
    var senderID: String { get }
    var senderDisplayName: String { get }
    var date: Date { get }
    var isMediaMessage: Bool { get }
    var messageHash: Int { get }
    
    var text: String? { get }
    var media: IMMessageMediaData? { get }
}
