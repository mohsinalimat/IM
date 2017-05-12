//
//  MXHelper-Operator.swift
//  Pods
//
//  Created by Meniny on 2017-05-09.
//
//

import Foundation

prefix operator !~
infix operator =>

//postfix operator ~
//postfix operator ~=

// MARK: - String
/// repeat string
public func * (lhs: String, rhs: Int) -> String {
    return lhs.repeating(rhs)
}

/// repeat string
public func *= (lhs: inout String, rhs: Int) {
    lhs.append(lhs.repeating(rhs - 1))
}

/// find and replace rhs in lhs
public func - (lhs: String, rhs: String) -> String {
    return lhs.replacingOccurrences(of: rhs, with: "")
}

/// find and replace rhs in lhs
public func -= (lhs: inout String, rhs: String) {
    lhs = lhs.replacingOccurrences(of: rhs, with: "")
}

/// reversed string
public prefix func ~ (lhs: String) -> String {
    return String(lhs.characters.reversed())
}

// MARK: - Array
/// append to array
public func + <T> (lhs: [T], rhs: T) -> [T] {
    return lhs + [rhs]
}

/// append to array
public func + <T> (lhs: [T], rhs: [T]) -> [T] {
    var cp = lhs
    cp.append(contentsOf: rhs)
    return cp
}

/// append to array
public func += <T> (lhs: inout [T], rhs: T) {
    lhs.append(rhs)
}

/// append to array
public func += <T> (lhs: inout [T], rhs: [T]) {
    lhs.append(contentsOf: rhs)
}

/// remove from array
public func - <T: Comparable> (lhs: [T], rhs: T) -> [T] {
    if let idx = lhs.index(of: rhs) {
        var cp = lhs
        cp.remove(at: idx)
        return cp
    }
    return lhs
}

/// remove from array
public func - <T: Comparable> (lhs: [T], rhs: [T]) -> [T] {
    if lhs.isEmpty || rhs.isEmpty {
        return lhs
    }
    var cp = lhs
    for i in rhs {
        if let idx = cp.index(of: i) {
            cp.remove(at: idx)
        }
    }
    return cp
}

/// remove from array
public func -= <T: Comparable> (lhs: inout [T], rhs: T) {
    if let idx = lhs.index(of: rhs) {
        lhs.remove(at: idx)
    }
}

/// remove from array
public func -= <T: Comparable> (lhs: inout [T], rhs: [T]) {
    for i in rhs {
        if let idx = lhs.index(of: i) {
            lhs.remove(at: idx)
        }
    }
}

/// repeat array
public func * <T> (lhs: [T], rhs: Int) -> [T] {
    if rhs > 1 {
        var res = [T]()
        for _ in 1...rhs {
            res.append(contentsOf: lhs)
        }
        return res
    }
    return lhs
}

/// repeat array
public func *= <T> (lhs: inout [T], rhs: Int) {
    if rhs > 1 {
        let cp = lhs
        for _ in 2...rhs {
            lhs.append(contentsOf: cp)
        }
    }
}

/// reverse array
public prefix func ~ <T> (rhs: [T]) -> [T] {
    return rhs.reversed()
}

// MARK: - Dictionary

/// append to dictionary
public func + <K, V> (lhs: [K: V], rhs: [K: V]) -> [K: V] {
    if rhs.keys.isEmpty {
        return lhs
    }
    var cp = lhs
    for (k, v) in rhs {
        cp[k] = v
    }
    return cp
}

/// append to dictionary
public func += <K, V> (lhs: inout [K: V], rhs: [K: V]) {
    for (k, v) in rhs {
        lhs[k] = v
    }
}

/// remove a key from dictionary
public func - <K, V> (lhs: [K: V], rhs: K) -> [K: V] {
    var cp = lhs
    cp.removeValue(forKey: rhs)
    return cp
}

/// remove a key from dictionary
public func -= <K, V> (lhs: inout [K: V], rhs: K) {
    _ = lhs.removeValue(forKey: rhs)
}

/// remove keys from dictionary
public func - <K, V> (lhs: [K: V], rhs: [K]) -> [K: V] {
    var cp = lhs
    for k in rhs {
        cp.removeValue(forKey: k)
    }
    return cp
}

/// remove keys from dictionary
public func -= <K, V> (lhs: inout [K: V], rhs: [K]) {
    for k in rhs {
        _ = lhs.removeValue(forKey: k)
    }
}

/// repeat dictionary, return a dictionary array
public func * <K, V> (lhs: [K: V], rhs: Int) -> [[K: V]] {
    if rhs <= 1 {
        return [lhs]
    }
    var res = [[K: V]]()
    for _ in 1...rhs {
        res.append(lhs)
    }
    return res
}

// MARK: - T

/// return true if T is not equal to nil
public prefix func !~ <T> (rhs: T?) -> Bool {
    return rhs != nil
}

// convert lhs to rhs's type
public func => <T1, T2> (lhs: T1, rhs: T2) -> T2? {
    return lhs as? T2
}
