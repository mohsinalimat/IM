//
//  UIDevice.swift
//  IMMessagesViewController
//
//  Created by Meniny on 19/08/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import UIKit

extension UIDevice {
    
    class func im_isCurrentDeviceBeforeiOS8() -> Bool {
        
        return UIDevice.current.systemVersion.compare("8.0", options: NSString.CompareOptions.numeric) == ComparisonResult.orderedAscending
    }
}
