//
//  MXHelper-App.swift
//  Pods
//
//  Created by Meniny on 2017-05-06.
//
//

import Foundation

#if os(iOS)
    import UIKit
    
    public extension UIApplication {
        static func usingChinese() -> Bool {
            if let l = NSLocale.preferredLanguages.first {
                if l.contains("zh-Hans") {
                    return true
                }
            }
            return false
        }
    }
#endif

public struct ThisApp {
    
    /// Info.plist as a dictionary objec
    public static var infoDictionary: [String: Any]? {
        return Bundle.main.infoDictionary
    }
    
    /// Bundle name string
    public static var bundleName: String? {
        get {
            if let info = ThisApp.infoDictionary {
                if let n = info["CFBundleName"] {
                    return n as? String
                }
            }
            return nil
        }
    }
    
    /// Version string without build number
    public static var version: String? {
        get {
            if let info = ThisApp.infoDictionary {
                if let v = info["CFBundleShortVersionString"] {
                    return v as? String
                }
            }
            return nil
        }
    }
    
    /// Build number string
    public static var build: String? {
        get {
            if let info = ThisApp.infoDictionary {
                if let b = info["CFBundleVersion"] {
                    return b as? String
                }
            }
            return nil
        }
    }
    
    /// Version string with build number
    public static var fullVersion: String? {
        get {
            if let v = ThisApp.version, let b = ThisApp.build {
                return "\(v).\(b)"
            }
            return nil
        }
    }
}
