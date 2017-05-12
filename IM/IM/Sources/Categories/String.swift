//
//  String.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

extension String {
    
    public func im_className() -> String {
        
        return self.components(separatedBy: ".").last ?? self
    }
    
    public func im_stringByTrimingWhitespace() -> String {
        
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
