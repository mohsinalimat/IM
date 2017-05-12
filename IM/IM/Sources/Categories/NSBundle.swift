//
//  NSBundle.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

extension Bundle {
    
    public class func im_messagesBundle() -> Bundle? {
        
        return Bundle(for: IMMessagesViewController.self)
    }
    
    public class func im_messagesAssetBundle() -> Bundle? {

        if let bundle = Bundle.im_messagesBundle() {
            if let bundlePath = bundle.path(forResource: "IMMessagesAssets", ofType: "bundle") {
                return Bundle(path: bundlePath)
            }
        }
        return nil
    }
    
    public class func im_localizedStringForKey(_ key: String) -> String {
        
        if let bundle = Bundle.im_messagesAssetBundle() {
        
            return NSLocalizedString(key, tableName: "IMMessages", bundle: bundle, comment: "")
        }
        return key
    }
}
