//
//  MXHelper.swift
//  MXHelper
//
//  Created by Meniny on 2017-04-19.
//  Copyright © 2017年 Meniny. All rights reserved.
//

#if os(OSX)
    import Cocoa
#else
    import Foundation
    import UIKit
#endif

public func Localized(_ key: String) -> String {
    return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
}
