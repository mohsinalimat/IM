//
//  MXHelper-Closure.swift
//  Pods
//
//  Created by Meniny on 2017-05-03.
//
//

import Foundation

// MARK: - Closure
public protocol Closure {}

public extension Closure where Self: AnyObject {
    
    /// Makes it available to execute something with closures.
    ///
    /// Usage:
    ///
    ///     let aView = UIView().then {
    ///          $0.backgroundColor = UIColor.redColor()
    ///          $0.translatesAutoresizingMaskIntoConstraints = false
    ///     }
    ///
    /// - Parameter closure: closure
    /// - Returns: self
    public func then(_ closure: (Self) -> Swift.Void) -> Self {
        closure(self)
        return self
    }
}

public extension Closure where Self: Any {
    
    /// Makes it available to execute something with closures.
    ///
    /// Usage:
    ///
    ///     let frame = CGRect().then {
    ///          $0.origin.x = 10
    ///          $0.size.width = 100
    ///     }
    ///
    /// - Parameter closure: closure
    /// - Returns: self
    public func then( _ closure: (inout Self) -> Swift.Void) -> Self {
        var cp = self
        closure(&cp)
        return cp
    }
    
    /// Makes it available to execute something with closures.
    ///
    /// Usage:
    ///
    ///     UserDefaults.standard.do {
    ///          $0.set("Elias", forKey: "username")
    ///          $0.set("meniny@qq.com", forKey: "email")
    ///          $0.synchronize()
    ///     }
    ///
    /// - Parameter closure: closure
    public func `do`(_ closure: (Self) -> Swift.Void) {
        closure(self)
    }
}

extension NSObject: Closure {}

extension CGPoint: Closure {}
extension CGRect: Closure {}
extension CGSize: Closure {}
extension CGVector: Closure {}
