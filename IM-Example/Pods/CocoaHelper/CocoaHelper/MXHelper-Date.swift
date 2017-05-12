//
//  MXHelper-Date.swift
//  MXHelper
//
//  Created by Meniny on 2017-04-19.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Foundation

public extension Date {
    /// formated date string
    public func formattedString(_ format: String? = "YYYY-MM-dd HH:mm:ss") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.string(from: self)
    }
    
    public func timeInterval() -> Int {
        return Int(self.timeIntervalSince1970)
    }
}
