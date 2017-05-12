//
//  MXHelper-Device.swift
//  Pods
//
//  Created by Meniny on 2017-05-06.
//
//

import Foundation
#if os(iOS)
import UIKit

public extension UIDevice {
    public var alphanumericSystemVersion: String? {
        return try? sysctlString(levels: CTL_KERN, KERN_OSVERSION)
    }
}
#endif
